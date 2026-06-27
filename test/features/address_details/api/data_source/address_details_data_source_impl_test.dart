import 'package:dio/dio.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/core/const/address_details_values.dart';
import 'package:flowery/features/address_details/api/api_client/address_details_api_client.dart';
import 'package:flowery/features/address_details/api/data_source/address_details_data_source_impl.dart';
import 'package:flowery/features/address_details/data/models/request/address_details_request.dart';
import 'package:flowery/features/address_details/data/models/responce/address_details_dto_responce.dart';
import 'package:flowery/features/address_details/data/models/responce/address_details_responce.dart';
import 'package:flowery/features/address_details/data/models/responce/get_addresses_responce.dart';
import 'package:flowery/features/address_details/domain/entities/address_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddressDetailsApiClient extends Mock
    implements AddressDetailsApiClient {}

void main() {
  late AddressDetailsDataSourceImpl dataSource;
  late MockAddressDetailsApiClient mockApiClient;

  final errorMessage = "An error has occured";

  late AddressDetailsRequest request;
  late AddressDetailsResponce responce;
  late GetAddressesResponce getAddressesResponce;

  setUp(() {
    mockApiClient = MockAddressDetailsApiClient();
    dataSource = AddressDetailsDataSourceImpl(apiClient: mockApiClient);

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
    getAddressesResponce = GetAddressesResponce(
      message: "success",
      addresses: [dto],
    );
  });

  group("Testing updateAddressDetails", () {
    test("Success in updating address details", () async {
      when(
        () => mockApiClient.updateUserAddressDetails(request),
      ).thenAnswer((_) async => responce);

      final result = await dataSource.updateAddressDetails(request);

      expect(result, isA<Success<AddressDetailsResponce>>());
      expect((result as Success<AddressDetailsResponce>).data, responce);
      verify(() => mockApiClient.updateUserAddressDetails(request)).called(1);
    });

    test("Error updating address details", () async {
      when(() => mockApiClient.updateUserAddressDetails(request)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {AddressDetailsValues.message: errorMessage},
          ),
        ),
      );

      final result = await dataSource.updateAddressDetails(request);

      expect(result, isA<Error<AddressDetailsResponce>>());
      expect(
        (result as Error<AddressDetailsResponce>).exception.toString(),
        "Exception: $errorMessage",
      );
      verify(() => mockApiClient.updateUserAddressDetails(request)).called(1);
    });
  });

  group("Testing getSavedAddresses", () {
    test("Success in getting saved addresses", () async {
      when(
        () => mockApiClient.getSavedAddresses(),
      ).thenAnswer((_) async => getAddressesResponce);

      final result = await dataSource.getSavedAddresses();

      expect(result, isA<Success<AddressDetailsEntity>>());
      expect(
        (result as Success<AddressDetailsEntity>).data,
        getAddressesResponce.toDomain(),
      );
      verify(() => mockApiClient.getSavedAddresses()).called(1);
    });

    test("Error getting saved addresses", () async {
      when(() => mockApiClient.getSavedAddresses()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {AddressDetailsValues.message: errorMessage},
          ),
        ),
      );

      final result = await dataSource.getSavedAddresses();

      expect(result, isA<Error<AddressDetailsEntity>>());
      expect(
        (result as Error<AddressDetailsEntity>).exception.toString(),
        "Exception: $errorMessage",
      );
      verify(() => mockApiClient.getSavedAddresses()).called(1);
    });
  });

  group("Testing deleteAddress", () {
    test("Success in deleting address", () async {
      when(
        () => mockApiClient.deleteAddress("addressId"),
      ).thenAnswer((_) async => responce);

      final result = await dataSource.deleteAddress("addressId");

      expect(result, isA<Success<AddressDetailsResponce>>());
      expect((result as Success<AddressDetailsResponce>).data, responce);
      verify(() => mockApiClient.deleteAddress("addressId")).called(1);
    });

    test("Error deleting address", () async {
      when(() => mockApiClient.deleteAddress("addressId")).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {AddressDetailsValues.message: errorMessage},
          ),
        ),
      );

      final result = await dataSource.deleteAddress("addressId");

      expect(result, isA<Error<AddressDetailsResponce>>());
      expect(
        (result as Error<AddressDetailsResponce>).exception.toString(),
        "Exception: $errorMessage",
      );
      verify(() => mockApiClient.deleteAddress("addressId")).called(1);
    });
  });
}
