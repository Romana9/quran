import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../core/app_cubit/app_cubit.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../surah/surah.dart';

class AzkarListView extends StatelessWidget {
  const AzkarListView({super.key});

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
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                            left: 24.w, right: 24.w, bottom: 20.h),
                        itemCount: AppCubit.get(context).azkar.length,
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
                            onTap: () =>
                                PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: Surah(
                                page: AppCubit.get(context).azkar[index]
                                    ["page"],
                                name: AppCubit.get(context).azkar[index]
                                    ["name"],
                                surah: AppCubit.get(context).azkar[index],
                                pdfName: "azkar",
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                        AppCubit.get(context).azkar[index]
                                            ["name"],
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
