import 'package:faker/faker.dart';
import 'package:mesa_news/application/storage/local_storage.dart';
import 'package:mesa_news/application/usecases/local_save_current_account.dart';
import 'package:mesa_news/domain/entities/account_entity.dart';
import 'package:mesa_news/domain/errors/domain_error.dart';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalStorageSpy extends Mock implements LocalStorage {}

void main() {
  LocalStorageSpy localStorage;
  LocalSaveCurrentAccount sut;
  AccountEntity account;

  setUp(() {
    localStorage = LocalStorageSpy();
    sut = LocalSaveCurrentAccount(localStorage: localStorage);
    account = AccountEntity(token: faker.guid.guid());
  });

  test('Should call the save method of LocalStorage with correct values',
      () async {
    await sut.save(account);

    verify(localStorage.save(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if LocalStorage throws', () {
    when(localStorage.save(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
