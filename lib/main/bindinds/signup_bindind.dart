import 'package:get/get.dart';
import '../../application/usecases/remote_add_account.dart';
import '../../domain/usecases/add_account.dart';
import '../../ui/pages/signup/signup_presenter.dart';

import '../../application/usecases/local_save_current_account.dart';
import '../../domain/usecases/save_current_account.dart';
import '../factories/api_url_factory.dart';

class SignupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAccount>(() => RemoteAddAccount(
        httpClient: Get.find(), url: makeApiUrl('v1/client/auth/signup')));
    Get.lazyPut<SaveCurrentAccount>(
        () => LocalSaveCurrentAccount(localStorage: Get.find()));
    Get.lazyPut(
      () => SignUpPresenter(
          saveCurrentAccount: Get.find(), addAccount: Get.find()),
    );
  }
}
