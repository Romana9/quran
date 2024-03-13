import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import 'package:quran/core/colors.dart';
import '../../main.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is UpdateLocatingSuccess) {
          Fluttertoast.showToast(
              msg: "تم تحديث الموقع بنجاح",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM_LEFT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0.sp);
        } else if (state is UpdateLocatingFailure) {
          Fluttertoast.showToast(
              msg: "قم بتفعيل الموقع من فضلك",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM_LEFT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0.sp);
        } else if (state is UpdateLocatingConnectionFailure) {
          Fluttertoast.showToast(
              msg: "تحقق من الاتصال بالانترنت",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM_LEFT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0.sp);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  image: DecorationImage(
                    opacity: 0.5,
                    fit: BoxFit.fill,
                    image: AssetImage("assets/img/home.png"),
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(top: 50.h, right: 24.w, left: 24.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "قرآني",
                                style: TextStyle(
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "TheSansBold",
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                              size: 24.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      ElevatedButton.icon(
                        onPressed: () {
                          AppCubit.get(context).updateLocation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          minimumSize: Size(100.w, 50.h),
                        ),
                        label: state is UpdateLocationLoading
                            ? SizedBox(
                                height: 30.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "تحديث الموقع",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                        icon: Icon(
                          Icons.replay_circle_filled_outlined,
                          color: Colors.white,
                          size: 25.h,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Container(
                        height: 72.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondray,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5.r,
                              spreadRadius: 1.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppCubit.get(context).fajrNotification ==
                                              false
                                          ? "تشغيل الاذان"
                                          : "ايقاف الاذان",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.85.h,
                                      child: Switch(
                                        activeColor: AppColors.primary,
                                        value: AppCubit.get(context)
                                            .fajrNotification,
                                        onChanged: (value) {
                                          AppCubit.get(context)
                                              .changefajrNotification();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "الفجر",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(prayerTimes.fajr),
                                style: TextStyle(
                                  fontSize: 23.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        height: 72.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondray,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5.r,
                              spreadRadius: 1.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 80.w),
                              Text(
                                "الشروق",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(prayerTimes.sunrise),
                                style: TextStyle(
                                  fontSize: 23.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        height: 72.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondray,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5.r,
                              spreadRadius: 1.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppCubit.get(context).duhrNotification ==
                                              false
                                          ? "تشغيل الاذان"
                                          : "ايقاف الاذان",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.85.h,
                                      child: Switch(
                                        activeColor: AppColors.primary,
                                        value: AppCubit.get(context)
                                            .duhrNotification,
                                        onChanged: (value) {
                                          AppCubit.get(context)
                                              .changeduhrNotification();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "الظهر",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(prayerTimes.dhuhr),
                                style: TextStyle(
                                  fontSize: 23.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        height: 72.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondray,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5.r,
                              spreadRadius: 1.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppCubit.get(context).asrNotification ==
                                              false
                                          ? "تشغيل الاذان"
                                          : "ايقاف الاذان",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.85.h,
                                      child: Switch(
                                        activeColor: AppColors.primary,
                                        value: AppCubit.get(context)
                                            .asrNotification,
                                        onChanged: (value) {
                                          AppCubit.get(context)
                                              .changeasrNotification();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "العصر",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(prayerTimes.asr),
                                style: TextStyle(
                                  fontSize: 23.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        height: 72.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondray,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5.r,
                              spreadRadius: 1.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppCubit.get(context)
                                                  .maghribNotification ==
                                              false
                                          ? "تشغيل الاذان"
                                          : "ايقاف الاذان",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.85.h,
                                      child: Switch(
                                        activeColor: AppColors.primary,
                                        value: AppCubit.get(context)
                                            .maghribNotification,
                                        onChanged: (value) {
                                          AppCubit.get(context)
                                              .changemaghribNotification();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "المغرب",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(prayerTimes.maghrib),
                                style: TextStyle(
                                  fontSize: 23.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        height: 72.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondray,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5.r,
                              spreadRadius: 1.r,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppCubit.get(context).ishaNotification ==
                                              false
                                          ? "تشغيل الاذان"
                                          : "ايقاف الاذان",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.85.h,
                                      child: Switch(
                                        activeColor: AppColors.primary,
                                        value: AppCubit.get(context)
                                            .ishaNotification,
                                        onChanged: (value) {
                                          AppCubit.get(context)
                                              .changeishaNotification();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "العشاء",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(prayerTimes.isha),
                                style: TextStyle(
                                  fontSize: 23.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
