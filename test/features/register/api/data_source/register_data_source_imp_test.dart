import 'package:flowery/config/base_response/base_response.dart' as base;
import 'package:flowery/features/register/api/api_client/register_api_client.dart';
import 'package:flowery/features/register/api/data_source/register_data_source_imp.dart';
import 'package:flowery/features/register/data/models/request/register_request.dart';
import 'package:flowery/features/register/data/models/responce/register_response.dart';
import 'package:flowery/features/register/data/models/responce/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterApiClient extends Mock implements RegisterApiClient {}

void main() {
  late MockRegisterApiClient apiClient;
  late RegisterDataSourceImpl dataSource;

  final request = RegisterRequestModel(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@test.com',
    password: '123456',
    rePassword: '123456',
    phone: '01000000000',
    gender: 'male',
  );

  const mockResponse = RegisterResponseModel(
    message: 'User created successfully',
    user: User(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@test.com',
    ),
    token: 'mock_token_123',
  );

  setUp(() {
    apiClient = MockRegisterApiClient();
    dataSource = RegisterDataSourceImpl(registerApiClient: apiClient);
  });

  group('RegisterDataSourceImpl', () {
    test(
      'returns Success<RegisterResponseModel> with correct data when api client succeeds',
      () async {
        // Arrange
        when(() => apiClient.register(request)).thenAnswer(
          (_) async => mockResponse,
        );

        // Act
        final result = await dataSource.register(request);

        // Assert
        expect(result, isA<base.Success<RegisterResponseModel>>());
        final success = result as base.Success<RegisterResponseModel>;
        expect(success.data?.message, 'User created successfully');
        expect(success.data?.token, 'mock_token_123');
      },
    );

    test(
      'returns Error<RegisterResponseModel> when api client throws an exception',
      () async {
        // Arrange
        when(() => apiClient.register(request)).thenThrow(
          Exception('Network error'),
        );

        // Act
        final result = await dataSource.register(request);

        // Assert
        expect(result, isA<base.Error<RegisterResponseModel>>());
        final error = result as base.Error<RegisterResponseModel>;
        expect(error.exception.toString(), contains('Network error'));
      },
    );

    test(
      'returns Error<RegisterResponseModel> when api client throws a non-Exception error',
      () async {
        // Arrange
        when(() => apiClient.register(request)).thenThrow(
          'Something went wrong',
        );

        // Act
        final result = await dataSource.register(request);

        // Assert
        expect(result, isA<base.Error<RegisterResponseModel>>());
        final error = result as base.Error<RegisterResponseModel>;
        expect(error.exception.toString(), contains('Something went wrong'));
      },
    );

    test('calls api client exactly once with the correct request', () async {
      // Arrange
      when(() => apiClient.register(request)).thenAnswer(
        (_) async => mockResponse,
      );

      // Act
      await dataSource.register(request);

      // Assert
      verify(() => apiClient.register(request)).called(1);
    });

    test('never calls api client when not invoked', () {
      verifyNever(() => apiClient.register(any()));
    });
  });
}