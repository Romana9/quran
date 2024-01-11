import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import '../../core/colors.dart';
import '../surah/surah.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 45.h, right: 24.w, left: 24.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "قرآني",
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 25.h,
                        color: const Color(0xff8789A3),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                AppCubit.get(context).search.isEmpty
                    ? SizedBox(
                        height: 600.h,
                        child: Center(
                          child: Text(
                            "اكتب اسم السوره صحيح من فضلك",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemCount: AppCubit.get(context).search.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            width: 326.w,
                            child: Divider(
                              color: const Color(0xffBBC4CE),
                              thickness: 1.h,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Surah(
                                          index: AppCubit.get(context)
                                              .search[index]["id"],
                                          name: AppCubit.get(context)
                                              .search[index]["name"]))),
                              child: SizedBox(
                                height: 62.h,
                                width: 342.w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                              right: 8.5.w,
                                              top: 10.h,
                                              child: Text(
                                                "${AppCubit.get(context).search[index]["id"]}",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color:
                                                      const Color(0xff240F4F),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 16.w),
                                        Text(
                                          AppCubit.get(context).search[index]
                                              ["name"],
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
                                          AppCubit.get(context).search[index]
                                                      ["makkia"] ==
                                                  1
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
                                          "${AppCubit.get(context).search[index]["aya"]} آية ",
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
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
