import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/features/forget_password/data/data_source/forget_password_data_source_contract.dart';
import 'package:flowery/features/forget_password/data/model/reqest_models/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/model/reqest_models/reset_password_request.dart';
import 'package:flowery/features/forget_password/data/model/reqest_models/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/model/response_model/forget_password_response.dart';
import 'package:flowery/features/forget_password/data/model/response_model/reset_password_response.dart';
import 'package:flowery/features/forget_password/data/model/response_model/verify_email_response.dart';
import 'package:flowery/features/forget_password/data/repository/forget_password_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mock
// ---------------------------------------------------------------------------
class MockDataSource extends Mock implements ForgetPasswordDataSourceContract {}

// ---------------------------------------------------------------------------
// Fakes  (required by mocktail for any() / captureAny())
// ---------------------------------------------------------------------------
class FakeForgetPasswordRequest extends Fake implements ForgetPasswordRequest {}
class FakeVerifyResetPassword   extends Fake implements VerifyResetPassword {}
class FakeResetPasswordRequest  extends Fake implements ResetPasswordRequest {}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
final _emailRequest  = ForgetPasswordRequest(email: 'test@test.com');
final _verifyRequest = VerifyResetPassword(resetCode: '123456');
final _resetRequest  = ResetPasswordRequest(password: 'NewPass123!');

final _sendError   = Exception('send failed');
final _verifyError = Exception('wrong code');
final _resetError  = Exception('reset failed');

void main() {
  late MockDataSource mockDataSource;
  late ForgetPasswordRepoImpl repo;

  setUpAll(() {
    registerFallbackValue(FakeForgetPasswordRequest());
    registerFallbackValue(FakeVerifyResetPassword());
    registerFallbackValue(FakeResetPasswordRequest());
  });

  setUp(() {
    mockDataSource = MockDataSource();
    repo = ForgetPasswordRepoImpl(mockDataSource);
  });

  // ── forgetPassword ────────────────────────────────────────────────────────
  group('forgetPassword', () {
    test('returns Success when data source returns Success', () async {
      final fakeResponse = ForgetPasswordResponse(message: 'Email sent');
      when(() => mockDataSource.forgetPassword(any()))
          .thenAnswer((_) async => Success(data: fakeResponse));

      final result = await repo.forgetPassword(_emailRequest);

      expect(result, isA<Success<ForgetPasswordResponse>>());
      expect((result as Success).data, isA<ForgetPasswordResponse>());
    });

    test('returns Error when data source returns Error', () async {
      when(() => mockDataSource.forgetPassword(any()))
          .thenAnswer((_) async => Error(exception: _sendError));

      final result = await repo.forgetPassword(_emailRequest);

      expect(result, isA<Error<ForgetPasswordResponse>>());
      expect((result as Error).exception, _sendError);
    });

    test('delegates the call with the correct request', () async {
      when(() => mockDataSource.forgetPassword(any()))
          .thenAnswer((_) async => Success(data: ForgetPasswordResponse()));

      await repo.forgetPassword(_emailRequest);

      verify(() => mockDataSource.forgetPassword(any())).called(1);
    });
  });

  // ── verifyEmail ───────────────────────────────────────────────────────────
  group('verifyEmail', () {
    test('returns Success when data source returns Success', () async {
      final fakeResponse = VerifyEmailResponse(status: 'verified');
      when(() => mockDataSource.verifyEmail(any()))
          .thenAnswer((_) async => Success(data: fakeResponse));

      final result = await repo.verifyEmail(_verifyRequest);

      expect(result, isA<Success<VerifyEmailResponse>>());
      expect((result as Success).data, isA<VerifyEmailResponse>());
    });

    test('returns Error when data source returns Error', () async {
      when(() => mockDataSource.verifyEmail(any()))
          .thenAnswer((_) async => Error(exception: _verifyError));

      final result = await repo.verifyEmail(_verifyRequest);

      expect(result, isA<Error<VerifyEmailResponse>>());
      expect((result as Error).exception, _verifyError);
    });

    test('delegates the call with the correct request', () async {
      when(() => mockDataSource.verifyEmail(any()))
          .thenAnswer((_) async => Success(data: VerifyEmailResponse()));

      await repo.verifyEmail(_verifyRequest);

      verify(() => mockDataSource.verifyEmail(any())).called(1);
    });
  });

  // ── resetPassword ─────────────────────────────────────────────────────────
  group('resetPassword', () {
    test('returns Success when data source returns Success', () async {
      final fakeResponse = ResetPasswordResponse(message: 'Password updated', token: 'abc');
      when(() => mockDataSource.resetPassword(any()))
          .thenAnswer((_) async => Success(data: fakeResponse));

      final result = await repo.resetPassword(_resetRequest);

      expect(result, isA<Success<ResetPasswordResponse>>());
      expect((result as Success).data, isA<ResetPasswordResponse>());
    });

    test('returns Error when data source returns Error', () async {
      when(() => mockDataSource.resetPassword(any()))
          .thenAnswer((_) async => Error(exception: _resetError));

      final result = await repo.resetPassword(_resetRequest);

      expect(result, isA<Error<ResetPasswordResponse>>());
      expect((result as Error).exception, _resetError);
    });

    test('delegates the call with the correct request', () async {
      when(() => mockDataSource.resetPassword(any()))
          .thenAnswer((_) async => Success(data: ResetPasswordResponse()));

      await repo.resetPassword(_resetRequest);

      verify(() => mockDataSource.resetPassword(any())).called(1);
    });
  });
}
