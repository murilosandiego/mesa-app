import 'package:get/get.dart';
import 'package:mesa_news/domain/errors/domain_error.dart';
import 'package:mesa_news/domain/usecases/add_account.dart';
import 'package:mesa_news/domain/usecases/save_current_account.dart';
import 'package:mesa_news/main/pages/app_pages.dart';
import 'package:mesa_news/ui/helpers/app_snackbar.dart';
import 'package:mesa_news/ui/helpers/field_validator.dart';
import 'package:mesa_news/ui/helpers/ui_error.dart';
import 'package:meta/meta.dart';

class SignUpPresenter extends GetxController {
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  SignUpPresenter({
    @required this.saveCurrentAccount,
    @required this.addAccount,
  });

  final _nameError = Rx<UIError>();
  final _emailError = Rx<UIError>();
  final _passwordError = Rx<UIError>();
  final _isLoading = false.obs;
  final _navigateTo = RxString();
  final _mainError = Rx<UIError>();
  final _passwordConfirmError = Rx<UIError>();

  String _name;
  String _email;
  String _password;

  Worker _navigationWorker;
  Worker _mainErrorWorker;

  UIError get nameError => _nameError.value;
  UIError get passwordError => _passwordError.value;
  UIError get passwordConfirmError => _passwordConfirmError.value;
  UIError get emailError => _emailError.value;
  UIError get mainError => _mainError.value;
  bool get isLoading => _isLoading.value;

  Future<void> add() async {
    try {
      _isLoading.value = true;

      final account = await addAccount.add(AddAccountParams(
        email: _email,
        secret: _password,
        name: _name,
      ));

      await saveCurrentAccount.save(account);

      _navigateTo.value = AppPages.feed;
    } on DomainError catch (error) {
      _mainError.update((_) {});
      if (error == DomainError.invalidCredentials) {
        _mainError.value = UIError.invalidCredentials;
        return;
      }

      _mainError.value = UIError.unexpected;
    } finally {
      _isLoading.value = false;
    }
  }

  void handleName(String name) {
    _name = name;
    _nameError.value = Validator.requiredField(name);
  }

  void handleEmail(String email) {
    _email = email;
    _emailError.value = Validator.emailField(email);
  }

  void handlePassword(String password) {
    _password = password;
    _passwordError.value = Validator.requiredField(password);
  }

  void handlePasswordConfirm(String password) {
    _passwordConfirmError.value =
        password == _password ? null : UIError.passwordConfirm;
  }

  bool get isFormValid =>
      _emailError.value == null &&
      _nameError.value == null &&
      _passwordError.value == null &&
      _passwordConfirmError.value == null &&
      _email != null &&
      _password != null &&
      _name != null;

  void _handleNavigation() {
    _navigationWorker = ever(_navigateTo, (page) {
      Get.offAllNamed(page);
    });
  }

  void _handleMainError() {
    _mainErrorWorker = ever<UIError>(_mainError, (error) {
      if (error == null) return;

      AppSnackbar.showError(message: error.description);
    });
  }

  @override
  void onInit() {
    super.onInit();
    _handleNavigation();
    _handleMainError();
  }

  @override
  void onClose() {
    super.onClose();
    _navigationWorker.dispose();
    _mainErrorWorker.dispose();
  }
}
