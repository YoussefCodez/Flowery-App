import 'package:flowery/config/general_cubit/cart_manager/cart_events.dart';
import 'package:flowery/config/general_cubit/cart_manager/cart_manager.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/checkout/presentation/view_model/cubit/web_view_cubit.dart';
import 'package:flowery/features/checkout/presentation/view_model/states/web_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  final String title;
  final AppLocalizations localizations;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.title,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WebViewCubit(url),
      child: BlocListener<WebViewCubit, WebViewState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            // show snackBar of success
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations.your_order_has_been_placed)),
            );
            context.read<CartManager>().doEvent(GetUserCartProductsEvent());
            context.pushNamed(AppRoutes.home);
          }
          if (state is PaymentFailed) {
            // show snackBar of failure
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(localizations.your_order_is_not_completed),
              ),
            );
            context.pop();
          }
        },
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(localizations.your_order_is_not_completed),
                    ),
                  );
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              title: Text(
                title,
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                WebViewWidget(
                  controller: context.read<WebViewCubit>().controller,
                ),
                BlocBuilder<WebViewCubit, WebViewState>(
                  builder: (context, state) => state is WebViewLoading
                      ? const ColoredBox(
                          color: AppColors.whiteColor,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
