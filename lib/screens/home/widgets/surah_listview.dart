import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import 'package:quran/core/colors.dart';
import '../../surah/surah.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: AppCubit.get(context).surah.length,
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
                              page: AppCubit.get(context).surah[index]["page"],
                              name: AppCubit.get(context).surah[index]["name"],
                              surah: AppCubit.get(context).surah[index],
                              pdfName: 'quran',
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
                          Stack(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/aya.svg",
                                height: 42.h,
                                width: 42.w,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: index + 1 < 10
                                    ? 17.w
                                    : index + 1 < 100
                                        ? 13.w
                                        : 8.5.w,
                                top: 10.h,
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            AppCubit.get(context).surah[index]["name"],
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondray,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            AppCubit.get(context).surah[index]["makkia"] == 1
                                ? "مكية"
                                : "مدنية",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xff8789A3),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.circle,
                            size: 4.h,
                            color: const Color(0xffBBC4CE),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "${AppCubit.get(context).surah[index]["aya"]} آية ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xff8789A3),
                            ),
                          ),
                        ],
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
