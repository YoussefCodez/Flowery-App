import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/address_details/data/data_source/address_details_data_source_contract.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/data/models/responce/address_details_dto_responce.dart';
import 'package:flowery/features/address_details/data/models/responce/address_details_responce.dart';
import 'package:flowery/features/address_details/data/repo/address_details_repo_impl.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddressDetailsDataSourceContract extends Mock
    implements AddressDetailsDataSourceContract {}

void main() {
  late AddressDetailsRepoImpl repo;
  late MockAddressDetailsDataSourceContract mockDataSource;

  final errorMessage = "An error has occured";

  late AddressDetailsRequest request;
  late AddressDetailsResponce responce;
  late AddressDetailsEntity entity;

  setUp(() {
    mockDataSource = MockAddressDetailsDataSourceContract();
    repo = AddressDetailsRepoImpl(dataSource: mockDataSource);

    request = AddressDetailsRequest(
      street: "street",
      phone: "01000000000",
      city: "city",
      lat: "30.0",
      long: "31.0",
      username: "username",
    );

    final dto = AddressDto(
      street: "street",
      phone: "01000000000",
      city: "city",
      lat: "30.0",
      long: "31.0",
      username: "username",
      id: "addressId",
    );

    responce = AddressDetailsResponce(message: "success", address: [dto]);
    entity = responce.toDomain();
  });

  group("Testing updateAddressDetails", () {
    test("Success in updating address details", () async {
      // Arrange
      when(() => mockDataSource.updateAddressDetails(request)).thenAnswer(
        (_) async => Success<AddressDetailsResponce>(data: responce),
      );

      // Act
      final result = await repo.updateAddressDetails(request);

      // Assert
      expect(result, isA<Success<AddressDetailsEntity>>());
      expect((result as Success<AddressDetailsEntity>).data, entity);
      verify(() => mockDataSource.updateAddressDetails(request)).called(1);
    });

    test("Error updating address details", () async {
      when(() => mockDataSource.updateAddressDetails(request)).thenAnswer(
        (_) async =>
            Error<AddressDetailsResponce>(exception: Exception(errorMessage)),
      );

      final result = await repo.updateAddressDetails(request);

      expect(result, isA<Error<AddressDetailsEntity>>());
      expect(
        (result as Error<AddressDetailsEntity>).exception.toString(),
        "Exception: $errorMessage",
      );
      verify(() => mockDataSource.updateAddressDetails(request)).called(1);
    });
  });

  group("Testing getSavedAddresses", () {
    test("Success in getting saved addresses", () async {
      when(() => mockDataSource.getSavedAddresses()).thenAnswer(
        (_) async => Success<AddressDetailsEntity>(data: entity),
      );

      final result = await repo.getSavedAddresses();

      expect(result, isA<Success<AddressDetailsEntity>>());
      expect((result as Success<AddressDetailsEntity>).data, entity);
      verify(() => mockDataSource.getSavedAddresses()).called(1);
    });

    test("Error getting saved addresses", () async {
      when(() => mockDataSource.getSavedAddresses()).thenAnswer(
        (_) async =>
            Error<AddressDetailsEntity>(exception: Exception(errorMessage)),
      );

      final result = await repo.getSavedAddresses();

      expect(result, isA<Error<AddressDetailsEntity>>());
      expect(
        (result as Error<AddressDetailsEntity>).exception.toString(),
        "Exception: $errorMessage",
      );
      verify(() => mockDataSource.getSavedAddresses()).called(1);
    });
  });

  group("Testing deleteAddress", () {
    test("Success in deleting address", () async {
      when(() => mockDataSource.deleteAddress("addressId")).thenAnswer(
        (_) async => Success<AddressDetailsResponce>(data: responce),
      );

      final result = await repo.deleteAddress("addressId");

      expect(result, isA<Success<AddressDetailsEntity>>());
      expect((result as Success<AddressDetailsEntity>).data, entity);
      verify(() => mockDataSource.deleteAddress("addressId")).called(1);
    });

    test("Error deleting address", () async {
      when(() => mockDataSource.deleteAddress("addressId")).thenAnswer(
        (_) async =>
            Error<AddressDetailsResponce>(exception: Exception(errorMessage)),
      );

      final result = await repo.deleteAddress("addressId");

      expect(result, isA<Error<AddressDetailsEntity>>());
      expect(
        (result as Error<AddressDetailsEntity>).exception.toString(),
        "Exception: $errorMessage",
      );
      verify(() => mockDataSource.deleteAddress("addressId")).called(1);
    });
  });
}