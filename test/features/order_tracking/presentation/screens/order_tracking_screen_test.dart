import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/order_tracking/data/models/order_information.dart';
import 'package:flowery/features/order_tracking/domain/use_cases/get_order_information_use_case.dart';
import 'package:flowery/features/order_tracking/domain/use_cases/get_order_status_use_case.dart';
import 'package:flowery/features/order_tracking/domain/use_cases/get_user_and_driver_coordinations_use_case.dart';
import 'package:flowery/features/order_tracking/presentation/screens/order_tracking_screen.dart';
import 'package:flowery/features/order_tracking/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flowery/features/order_tracking/presentation/widgets/state_time_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetOrderStatusUseCase extends Mock implements GetOrderStatusUseCase {}

class MockGetOrderInformationUseCase extends Mock
    implements GetOrderInformationUseCase {}

class MockGetUserAndDriverCoordinationsUseCase extends Mock
    implements GetUserAndDriverCoordinationsUseCase {}

void main() {
  late MockGetOrderStatusUseCase mockGetOrderStatusUseCase;
  late MockGetOrderInformationUseCase mockGetOrderInformationUseCase;
  late MockGetUserAndDriverCoordinationsUseCase
  mockGetUserAndDriverCoordinationsUseCase;
  late OrderTrackingCubit cubit;

  const orderInfo = OrderInformation(
    acceptedAt: '2026-07-28T12:00:00.000',
    driverFirstName: 'Ahmed',
    driverLastName: 'Ali',
    driverPhoto: 'https://example.com/driver.png',
    driverPhoneNumber: '+201234567890',
  );

  setUp(() {
    mockGetOrderStatusUseCase = MockGetOrderStatusUseCase();
    mockGetOrderInformationUseCase = MockGetOrderInformationUseCase();
    mockGetUserAndDriverCoordinationsUseCase =
        MockGetUserAndDriverCoordinationsUseCase();

    cubit = OrderTrackingCubit(
      mockGetOrderStatusUseCase,
      mockGetOrderInformationUseCase,
      mockGetUserAndDriverCoordinationsUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('OrderTrackingScreen', () {
    testWidgets('shows the app bar title in the initial state', (tester) async {
      await pumpWidget(tester, cubit);

      expect(find.text('Track order'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets(
      'shows a loading indicator while order information is loading',
      (tester) async {
        cubit.emit(
          cubit.state.copyWith(
            orderInfoState: const BaseState<OrderInformation>.loading(),
          ),
        );
        await pumpWidget(tester, cubit);

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('renders arrival, driver and timeline details on success', (
      tester,
    ) async {
      cubit.emit(
        cubit.state.copyWith(
          orderInfoState: const BaseState<OrderInformation>.success(orderInfo),
        ),
      );
      await pumpWidget(tester, cubit);

      expect(find.text('Estimated arrival'), findsOneWidget);
      expect(find.text('Ahmed Ali'), findsOneWidget);
      expect(find.byType(StateTimeLine), findsOneWidget);
    });

    testWidgets(
      'shows a snackbar when the order information state reports an error',
      (tester) async {
        await pumpWidget(tester, cubit);
        cubit.emit(
          cubit.state.copyWith(
            orderInfoState: BaseState<OrderInformation>.error(
              Exception('order failed'),
            ),
          ),
        );

        await tester.pump();
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('order failed'), findsOneWidget);
      },
    );
  });
}

Future<void> pumpWidget(WidgetTester tester, OrderTrackingCubit cubit) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider.value(
          value: cubit,
          child: const OrderTrackingScreen(),
        ),
      ),
    ),
  );
  await tester.pump();
}
