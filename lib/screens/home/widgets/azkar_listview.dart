import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/app_cubit/app_cubit.dart';
import '../../surah/surah.dart';

class AzkarListView extends StatelessWidget {
  const AzkarListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 20.h),
            itemCount: AppCubit.get(context).azkar.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 326.w,
              child: Divider(
                color: const Color(0xffBBC4CE),
                thickness: 1.h,
              ),
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Surah(
                              page: AppCubit.get(context).azkar[index]["page"],
                              name: AppCubit.get(context).azkar[index]["name"],
                              surah: AppCubit.get(context).azkar[index],
                              pdfName: AppCubit.get(context).azkar[index]
                                  ["pdfName"],
                              index: index,
                            ))),
                child: SizedBox(
                  height: 62.h,
                  width: 342.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/aya.svg",
                            height: 30.h,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppCubit.get(context).azkar[index]["name"],
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${AppCubit.get(context).azkar[index]["pageNum"]} صفحة ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xff8789A3),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
