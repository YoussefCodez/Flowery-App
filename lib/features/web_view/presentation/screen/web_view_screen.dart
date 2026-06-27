import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/web_view/presentation/view_model/web_view_cubit.dart';
import 'package:flowery/features/web_view/presentation/view_model/web_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  final String title;

  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WebViewCubit(url),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
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
    );
  }
}
