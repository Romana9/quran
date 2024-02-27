import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';

import '../../tasbih/tasbih_listview.dart';

class CustomRowButtons extends StatelessWidget {
  const CustomRowButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: 50.h,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(0),
            children: [
              Material(
                color: Colors.transparent,
                shape: Border(
                  bottom: BorderSide(
                    color: AppCubit.get(context).buttonIndex == 0
                        ? Colors.white
                        : const Color(0xff8789A3).withOpacity(0.1),
                    width: 3.w,
                  ),
                ),
                child: TextButton(
                  style: const ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Color(0xff027770))),
                  onPressed: () {
                    AppCubit.get(context).buttonIndexFun(0);
                  },
                  child: Text(
                    'السور',
                    style: TextStyle(
                      color: AppCubit.get(context).buttonIndex == 0
                          ? Colors.white
                          : const Color(0xff8789A3),
                      fontSize: 19.sp,
                      fontFamily: AppCubit.get(context).buttonIndex == 0
                          ? "TheSansBold"
                          : "TheSans",
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                shape: Border(
                  bottom: BorderSide(
                    color: AppCubit.get(context).buttonIndex == 1
                        ? Colors.white
                        : const Color(0xff8789A3).withOpacity(0.1),
                    width: 3.w,
                  ),
                ),
                child: TextButton(
                  style: const ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Color(0xff027770))),
                  onPressed: () {
                    AppCubit.get(context).buttonIndexFun(1);
                  },
                  child: Text(
                    'الأذكار',
                    style: TextStyle(
                      color: AppCubit.get(context).buttonIndex == 1
                          ? Colors.white
                          : const Color(0xff8789A3),
                      fontSize: 19.sp,
                      fontFamily: AppCubit.get(context).buttonIndex == 1
                          ? "TheSansBold"
                          : "TheSans",
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                shape: Border(
                  bottom: BorderSide(
                    color: AppCubit.get(context).buttonIndex == 2
                        ? Colors.white
                        : const Color(0xff8789A3).withOpacity(0.1),
                    width: 3.w,
                  ),
                ),
                child: TextButton(
                  style: const ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Color(0xff027770))),
                  onPressed: () {
                    AppCubit.get(context).buttonIndexFun(2);
                  },
                  child: Text(
                    'آخر قراءة',
                    style: TextStyle(
                      color: AppCubit.get(context).buttonIndex == 2
                          ? Colors.white
                          : const Color(0xff8789A3),
                      fontSize: 19.sp,
                      fontFamily: AppCubit.get(context).buttonIndex == 2
                          ? "TheSansBold"
                          : "TheSans",
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                shape: Border(
                  bottom: BorderSide(
                    color: AppCubit.get(context).buttonIndex == 3
                        ? Colors.white
                        : const Color(0xff8789A3).withOpacity(0.1),
                    width: 3.w,
                  ),
                ),
                child: TextButton(
                  style: const ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Color(0xff027770))),
                  onPressed: () {
                    AppCubit.get(context).buttonIndexFun(3);
                  },
                  child: Text(
                    "القبلة",
                    style: TextStyle(
                      color: AppCubit.get(context).buttonIndex == 3
                          ? Colors.white
                          : const Color(0xff8789A3),
                      fontSize: 19.sp,
                      fontFamily: AppCubit.get(context).buttonIndex == 3
                          ? "TheSansBold"
                          : "TheSans",
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                shape: Border(
                  bottom: BorderSide(
                    color: AppCubit.get(context).buttonIndex == 4
                        ? Colors.white
                        : const Color(0xff8789A3).withOpacity(0.1),
                    width: 3.w,
                  ),
                ),
                child: TextButton(
                  style: const ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Color(0xff027770))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TasbihListView()));
                  },
                  child: Text(
                    "التسبيح",
                    style: TextStyle(
                      color: AppCubit.get(context).buttonIndex == 4
                          ? Colors.white
                          : const Color(0xff8789A3),
                      fontSize: 19.sp,
                      fontFamily: AppCubit.get(context).buttonIndex == 4
                          ? "TheSansBold"
                          : "TheSans",
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
