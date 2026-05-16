import 'package:flowery/config/di/injectable_config.dart';
import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view_model/search_cubit.dart';
import '../widget/search_bar.dart';
import '../widget/search_result.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchViewModel>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_new),
                    ),
                    Expanded(child: SearchBarWidget()),
                  ],
                ),
                Expanded(child: SearchResults()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
