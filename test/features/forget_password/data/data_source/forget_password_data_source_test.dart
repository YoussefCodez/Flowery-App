import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/forget_password/api/forget_password_client.dart';
import 'package:flowery/features/forget_password/data/data_source/forget_password_data_source_impl.dart';
import 'package:flowery/features/forget_password/data/model/reqest_models/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/model/reqest_models/reset_password_request.dart';
import 'package:flowery/features/forget_password/data/model/reqest_models/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/model/response_model/forget_password_response.dart';
import 'package:flowery/features/forget_password/data/model/response_model/reset_password_response.dart';
import 'package:flowery/features/forget_password/data/model/response_model/verify_email_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mock
// ---------------------------------------------------------------------------
class MockForgetPasswordClient extends Mock implements ForgetPasswordClient {}

// ---------------------------------------------------------------------------
// Fakes  (required by mocktail for any() / captureAny())
// ---------------------------------------------------------------------------
class FakeForgetPasswordRequest extends Fake implements ForgetPasswordRequest {}
class FakeVerifyResetPassword   extends Fake implements VerifyResetPassword {}
class FakeResetPasswordRequest  extends Fake implements ResetPasswordRequest {}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
final _emailRequest   = ForgetPasswordRequest(email: 'test@test.com');
final _verifyRequest  = VerifyResetPassword(resetCode: '123456');
final _resetRequest   = ResetPasswordRequest(password: 'NewPass123!');

void main() {
  late MockForgetPasswordClient mockClient;
  late ForgetPasswordDataSourceImpl dataSource;

  setUpAll(() {
    registerFallbackValue(FakeForgetPasswordRequest());
    registerFallbackValue(FakeVerifyResetPassword());
    registerFallbackValue(FakeResetPasswordRequest());
  });

  setUp(() {
    mockClient = MockForgetPasswordClient();
    dataSource = ForgetPasswordDataSourceImpl(client: mockClient);
  });

  // ─── NOTE ─────────────────────────────────────────────────────────────────
  // The implementation has `const bool isMock = true` at the top of the file.
  // While that flag is true every method returns a hardcoded Success and the
  // real HTTP client is NEVER reached.
  //
  // The tests below therefore verify the mock-path behaviour.
  // When the API is ready, set isMock = false and see the "Real API" section.
  // ──────────────────────────────────────────────────────────────────────────

  group('ForgetPasswordDataSourceImpl — mock path (isMock = true)', () {
    // ── forgetPassword ──────────────────────────────────────────────────────
    group('forgetPassword', () {
      test('returns Success<ForgetPasswordResponse>', () async {
        final result = await dataSource.forgetPassword(_emailRequest);

        expect(result, isA<Success<ForgetPasswordResponse>>());
      });

      test('returned data is a ForgetPasswordResponse instance', () async {
        final result = await dataSource.forgetPassword(_emailRequest) as Success<ForgetPasswordResponse>;

        expect(result.data, isA<ForgetPasswordResponse>());
      });

      test('HTTP client is never called', () async {
        await dataSource.forgetPassword(_emailRequest);

        verifyNever(() => mockClient.forgetPassword(any()));
      });
    });

    // ── verifyEmail ─────────────────────────────────────────────────────────
    group('verifyEmail', () {
      test('returns Success<VerifyEmailResponse>', () async {
        final result = await dataSource.verifyEmail(_verifyRequest);

        expect(result, isA<Success<VerifyEmailResponse>>());
      });

      test('returned data is a VerifyEmailResponse instance', () async {
        final result = await dataSource.verifyEmail(_verifyRequest) as Success<VerifyEmailResponse>;

        expect(result.data, isA<VerifyEmailResponse>());
      });

      test('HTTP client is never called', () async {
        await dataSource.verifyEmail(_verifyRequest);

        verifyNever(() => mockClient.verifyEmail(any()));
      });
    });

    // ── resetPassword ────────────────────────────────────────────────────────
    group('resetPassword', () {
      test('returns Success<ResetPasswordResponse>', () async {
        final result = await dataSource.resetPassword(_resetRequest);

        expect(result, isA<Success<ResetPasswordResponse>>());
      });

      test('returned data is a ResetPasswordResponse instance', () async {
        final result = await dataSource.resetPassword(_resetRequest) as Success<ResetPasswordResponse>;

        expect(result.data, isA<ResetPasswordResponse>());
      });

      test('HTTP client is never called', () async {
        await dataSource.resetPassword(_resetRequest);

        verifyNever(() => mockClient.resetPassword(any()));
      });
    });
  });

  // ─── Real API path ────────────────────────────────────────────────────────
  // Set isMock = false in forget_password_data_source_impl.dart to activate.
  // ─────────────────────────────────────────────────────────────────────────
  // group('ForgetPasswordDataSourceImpl — real API path (isMock = false)', () {
  //   test('forgetPassword returns Success when client responds 200', () async {
  //     when(() => mockClient.forgetPassword(any()))
  //         .thenAnswer((_) async => ForgetPasswordResponse(message: 'ok'));
  //
  //     final result = await dataSource.forgetPassword(_emailRequest);
  //
  //     expect(result, isA<Success<ForgetPasswordResponse>>());
  //     verify(() => mockClient.forgetPassword(any())).called(1);
  //   });
  //
  //   test('forgetPassword returns Error when client throws DioException', () async {
  //     when(() => mockClient.forgetPassword(any()))
  //         .thenThrow(DioException(requestOptions: RequestOptions(path: '/')));
  //
  //     final result = await dataSource.forgetPassword(_emailRequest);
  //
  //     expect(result, isA<Error<ForgetPasswordResponse>>());
  //   });
  // });
}
