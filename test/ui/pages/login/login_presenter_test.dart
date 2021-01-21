import 'package:faker/faker.dart';
import 'package:mesa_news/application/models/account_model.dart';
import 'package:mesa_news/domain/usecases/authentication.dart';
import 'package:mesa_news/ui/helpers/errors/ui_error.dart';
import 'package:mesa_news/ui/pages/login/login_presenter.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class AutheticationMock extends Mock implements Authetication {}

void main() {
  LoginPresenter sut;
  AutheticationMock authentication;
  String email;
  String password;

  setUp(() {
    authentication = AutheticationMock();
    sut = LoginPresenter(authetication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
  });

  group('validateEmail', () {
    test('Should emit requiredFieldError if email is empty', () {
      const email = '';
      sut.handleEmail(email);

      expect(sut.emailError, UIError.requiredField);
    });

    test('Should emit null if email is null', () {
      String email;
      sut.handleEmail(email);

      expect(sut.emailError, null);
    });

    test('Should emit invalidEmail if email is invalid', () {
      String email = 'asdf';
      sut.handleEmail(email);

      expect(sut.emailError, UIError.invalidEmail);
    });

    test('Should emit null if validation succeeds', () {
      String email = faker.internet.email();
      sut.handleEmail(email);

      expect(sut.emailError, null);
    });
  });

  group('validatePassword', () {
    test('Should emit requiredFieldError if password is empty', () {
      const password = '';

      sut.handlePassword(password);

      expect(sut.passwordError, UIError.requiredField);
    });

    test('Should emit null if password is null', () {
      String password;
      sut.handlePassword(password);

      expect(sut.passwordError, null);
    });

    test('Should emit null if has password', () {
      String password = faker.internet.password();
      sut.handlePassword(password);

      expect(sut.passwordError, null);
    });
  });

  group('validateForm', () {
    test('Should emits false if any field is invalid', () {
      const email = 'asd';
      sut.handleEmail(email);

      expect(sut.isFormValid, false);
    });

    test('Should emits true if all field is valid', () {
      sut.handleEmail(email);
      sut.handlePassword(password);

      expect(sut.isFormValid, true);
    });
  });

  group('Authentication', () {
    test('Should call Authentication with correct values', () async {
      sut.handleEmail(email);
      sut.handlePassword(password);

      await sut.auth();

      verify(authentication
              .auth(AuthenticationParams(email: email, secret: password)))
          .called(1);
    });
  });
}