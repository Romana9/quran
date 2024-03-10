import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import 'package:quran/screens/tasbih/tasbih.dart';

import '../../core/widgets/custom_appbar.dart';

class TasbihListView extends StatelessWidget {
  const TasbihListView({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.only(top: 50.h, right: 24.w, left: 24.w),
            child: Column(
              children: [
                const CustomAppBar(),
                SizedBox(height: 24.h),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 30.h),
                    itemCount: AppCubit.get(context).tasbih.length,
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
                        onTap: () => PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: Tasbih(
                            data: AppCubit.get(context).tasbih[index],
                          ),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        ),
                        child: Container(
                          width: 342.w,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/aya.svg",
                                    height: 30.h,
                                    width: 30.w,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 16.w),
                                  SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      AppCubit.get(context).tasbih[index]
                                          ["title"],
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "TheSansBold",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "التكرار : ${AppCubit.get(context).tasbih[index]["num"]}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff8789A3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
