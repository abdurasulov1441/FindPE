import 'package:easy_localization/easy_localization.dart';
import 'package:find_pe/common/style/app_colors.dart';
import 'package:find_pe/common/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lotties/not_found.json', width: 200),
          const SizedBox(height: 10),
          Text(
            "no_results".tr(),
            style: AppStyle.fontStyle.copyWith(
              fontSize: 18,
              color: AppColors.uiText,
            ),
          ),
        ],
      ),
    );
  }
}
