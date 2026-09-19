import 'package:flowery/config/base_response/base_response.dart' as base;
import 'package:flowery/features/register/data/data_sources/register_data_source.dart';
import 'package:flowery/features/register/data/models/request/register_request.dart';
import 'package:flowery/features/register/data/models/responce/register_response.dart';
import 'package:flowery/features/register/data/models/responce/user.dart';
import 'package:flowery/features/register/data/repo/register_repository_imp.dart';
import 'package:flowery/features/register/domain/entities/register_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterDataSource extends Mock implements RegisterDataSource {}

void main() {
  late MockRegisterDataSource dataSource;
  late RegisterRepositoryImpl repository;

  // Shared request used across tests
  final request = RegisterRequestModel(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@test.com',
    password: '123456',
    rePassword: '123456',
    phone: '01000000000',
    gender: 'male',
  );

  // Shared mock user and response
  const mockUser = User(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@test.com',
    gender: 'male',
    phone: '01000000000',
  );

  const mockResponse = RegisterResponseModel(
    message: 'User created successfully',
    user: mockUser,
    token: 'mock_token_123',
  );

  setUp(() {
    dataSource = MockRegisterDataSource();
    repository = RegisterRepositoryImpl(dataSource);
  });

  group('RegisterRepositoryImpl', () {
    test(
      'returns Success<RegisterEntity> with correct data when data source succeeds',
      () async {
        // Arrange
        when(() => dataSource.register(request)).thenAnswer(
          (_) async => const base.Success<RegisterResponseModel>(
            data: mockResponse,
          ),
        );

        // Act
        final result = await repository.register(request);

        // Assert
        expect(result, isA<base.Success<RegisterEntity>>());
        final success = result as base.Success<RegisterEntity>;
        expect(success.data?.message, 'User created successfully');
        expect(success.data?.token, 'mock_token_123');
        expect(success.data?.user, mockUser);
      },
    );

    test(
      'returns Error<RegisterEntity> when data source throws an exception',
      () async {
        // Arrange
        final exception = Exception('Network error');
        when(() => dataSource.register(request)).thenAnswer(
          (_) async => base.Error<RegisterResponseModel>(
            exception: exception,
          ),
        );

        // Act
        final result = await repository.register(request);

        // Assert
        expect(result, isA<base.Error<RegisterEntity>>());
        final error = result as base.Error<RegisterEntity>;
        expect(error.exception, exception);
      },
    );

    test('calls data source exactly once with the correct request', () async {
      // Arrange
      when(() => dataSource.register(request)).thenAnswer(
        (_) async => const base.Success<RegisterResponseModel>(
          data: mockResponse,
        ),
      );

      // Act
      await repository.register(request);

      // Assert
      verify(() => dataSource.register(request)).called(1);
    });

    test('never calls data source when not invoked', () {
      verifyNever(() => dataSource.register(any()));
    });
  });
}