import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../main.dart';
import '../../surah/surah.dart';

class LastReadListView extends StatelessWidget {
  const LastReadListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  "assets/img/home.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: const CustomAppBar(),
                    ),
                    SizedBox(height: 24.h),
                    currentList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 50.h),
                            child: Column(
                              children: [
                                Lottie.asset(
                                  'assets/svg/bookmark.json',
                                ),
                                Text(
                                  "لم تضف سور",
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: "TheSansBold",
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                  left: 24.w, right: 24.w, bottom: 20.h),
                              itemCount: currentList.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                width: 326.w,
                                child: Divider(
                                  color: const Color(0xffBBC4CE),
                                  thickness: 1.h,
                                ),
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () =>
                                      PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: Surah(
                                      page: currentList[index]["currentPage"] ??
                                          currentList[index]["page"],
                                      name: currentList[index]["name"],
                                      surah: currentList[index],
                                      pdfName: 'quran',
                                      index: index,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  ),
                                  child: SizedBox(
                                    height: 62.h,
                                    width: 342.w,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 42.h,
                                              width: 42.h,
                                              child: Stack(
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/svg/aya.svg",
                                                    height: 42.h,
                                                    width: 42.h,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 16.w),
                                            Text(
                                              currentList[index]["name"],
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              currentList[index]["makkia"] == 1
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
                                              "${currentList[index]["aya"]} آية ",
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
            ],
          ),
        );
      },
    );
  }
}
