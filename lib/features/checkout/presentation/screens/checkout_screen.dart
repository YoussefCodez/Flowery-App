import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/firebase/services/remote_config_service.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flowery/features/checkout/presentation/widgets/containers/address_container.dart';
import 'package:flowery/features/checkout/presentation/widgets/custom_divider.dart';
import 'package:flowery/features/checkout/presentation/widgets/containers/delivery_time_container.dart';
import 'package:flowery/features/checkout/presentation/widgets/containers/gift_container.dart';
import 'package:flowery/features/checkout/presentation/widgets/containers/payment_method_container.dart';
import 'package:flowery/features/checkout/presentation/widgets/place_order_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  final int subtotal;
  final int discount;
  final int subtotalAfterDiscount;
  const CheckoutScreen({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.subtotalAfterDiscount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late AppLocalizations localizations;
  late TextTheme textTheme;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final deliveryDays = getIt<RemoteConfigService>().deliveryDays;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutCubit>(
      create: (context) => getIt.get<CheckoutCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              titleSpacing: 0.0,
              title: Text(localizations.checkout),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery time
                    DeliveryTimeContainer(
                      localizations: localizations,
                      textTheme: textTheme,
                      deliveryDays: deliveryDays,
                    ),
                    CustomDivider(),

                    // Delivery address
                    CustomAddressContainer(
                      localizations: localizations,
                      textTheme: textTheme,
                    ),
                    CustomDivider(),

                    // Delivery Payment Method
                    PaymentMethodContainer(
                      localizations: localizations,
                      textTheme: textTheme,
                    ),
                    CustomDivider(),

                    // Gift Container
                    GiftContainer(
                      localizations: localizations,
                      nameController: nameController,
                      phoneController: phoneController,
                    ),

                    // Place order Button
                    PlaceOrderButton(
                      subtotal: widget.subtotal,
                      discount: widget.discount,
                      subtotalAfterDiscount: widget.subtotalAfterDiscount,
                      localizations: localizations,
                      textTheme: textTheme,
                      formKey: _formKey,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
