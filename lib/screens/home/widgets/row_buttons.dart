import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import '../../../core/colors.dart';

class CustomRowButtons extends StatelessWidget {
  const CustomRowButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            Material(
              color: Colors.transparent,
              shape: Border(
                bottom: BorderSide(
                  color: AppCubit.get(context).buttonIndex == 0
                      ? AppColors.primary
                      : const Color(0xff8789A3).withOpacity(0.1),
                  width: 3.w,
                ),
              ),
              child: TextButton(
                style: const ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(AppColors.primary)),
                onPressed: () {
                  AppCubit.get(context).buttonIndexFun(0);
                },
                child: Text(
                  'السور',
                  style: TextStyle(
                    color: AppCubit.get(context).buttonIndex == 0
                        ? AppColors.primary
                        : const Color(0xff8789A3),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
