import 'package:faker/faker.dart';
import 'package:mesa_news/domain/entities/account_entity.dart';
import 'package:mesa_news/domain/usecases/load_current_account.dart';
import 'package:mesa_news/main/pages/app_pages.dart';
import 'package:mesa_news/ui/pages/splash/splash_presenter.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  LoadCurrentAccountSpy loadCurrentAccount;
  SplashPresenter sut;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = SplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to FeedPage if has token', () async {
    when(loadCurrentAccount.load())
        .thenAnswer((_) async => AccountEntity(token: faker.guid.guid()));

    await sut.checkAccount();

    expect(sut.navigateTo, AppPages.feed);
  });

  test('Should go to WelcomePage if not token', () async {
    when(loadCurrentAccount.load())
        .thenAnswer((_) async => AccountEntity(token: null));

    await sut.checkAccount();

    expect(sut.navigateTo, AppPages.welcome);
  });

  test('Should go to WelcomePage if throws', () async {
    when(loadCurrentAccount.load()).thenThrow(Exception());

    await sut.checkAccount();

    expect(sut.navigateTo, AppPages.welcome);
  });
}
