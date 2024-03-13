import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/jHijri.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../main.dart';
import '../../prayer_time/prayer_time.dart';

class PrayerTimeContainer extends StatefulWidget {
  const PrayerTimeContainer({
    super.key,
  });

  @override
  State<PrayerTimeContainer> createState() => _PrayerTimeContainerState();
}

class _PrayerTimeContainerState extends State<PrayerTimeContainer> {
  List<DateTime> prayerTime = [
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        prayerTimes.fajr.hour, prayerTimes.fajr.minute),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        prayerTimes.sunrise.hour, prayerTimes.sunrise.minute),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        prayerTimes.dhuhr.hour, prayerTimes.dhuhr.minute),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        prayerTimes.asr.hour, prayerTimes.asr.minute),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        prayerTimes.maghrib.hour, prayerTimes.maghrib.minute),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        prayerTimes.isha.hour, prayerTimes.isha.minute),
  ];

  DateTime? nearestPrayerTime;
  String? nearestTime;
  String nearestPrayer = "";

  void calculateNearestPrayerTime() {
    DateTime now = DateTime.now();
    nearestPrayerTime = prayerTime.firstWhere((time) => time.isAfter(now),
        orElse: () => prayerTime.first);
    nearestTime = DateFormat.jm().format(nearestPrayerTime!);
    if (nearestTime == DateFormat.jm().format(prayerTimes.sunrise)) {
      nearestPrayer = "الشروق";
    } else if (nearestTime == DateFormat.jm().format(prayerTimes.fajr)) {
      nearestPrayer = "الفجر";
    } else if (nearestTime == DateFormat.jm().format(prayerTimes.dhuhr)) {
      nearestPrayer = "الظهر";
    } else if (nearestTime == DateFormat.jm().format(prayerTimes.asr)) {
      nearestPrayer = "العصر";
    } else if (nearestTime == DateFormat.jm().format(prayerTimes.maghrib)) {
      nearestPrayer = "المغرب";
    } else if (nearestTime == DateFormat.jm().format(prayerTimes.isha)) {
      nearestPrayer = "العشاء";
    }
  }

  late Duration _timeUntil;

  @override
  void initState() {
    super.initState();
    calculateNearestPrayerTime();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        calculateNearestPrayerTime();
      });
    });
    _timeUntil = nearestPrayerTime!.difference(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeUntil = nearestPrayerTime!.difference(DateTime.now());
      });
    });
  }

  final String _jHijriDate = "${JHijri(
    fYear: JHijri.now().year,
    fMonth: JHijri.now().month,
    fDay: JHijri.now().day,
  ).day} ${JHijri(
    fYear: JHijri.now().year,
    fMonth: JHijri.now().month,
    fDay: JHijri.now().day,
  ).monthName} ${JHijri(
    fYear: JHijri.now().year,
    fMonth: JHijri.now().month,
    fDay: JHijri.now().day,
  ).year}";

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
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            lat == 35.652832 && lng == 139.839478
                ? null
                : PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const PrayerTime(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350.w,
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  color: AppColors.primary,
                  image: const DecorationImage(
                    opacity: 0.5,
                    fit: BoxFit.fill,
                    image: AssetImage("assets/img/home.png"),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: lat == 35.652832 && lng == 139.839478
                    ? Column(
                        children: [
                          Text(
                            "قم بتفعيل الموقع لمعرفة مواعيد الصلاة",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              fontFamily: "TheSansBold",
                            ),
                          ),
                          SizedBox(height: 12.h),
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
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 173.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      nearestPrayer,
                                      style: TextStyle(
                                        fontSize: 25.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "TheSansBold",
                                      ),
                                    ),
                                    nearestPrayerTime != null
                                        ? Text(
                                            nearestTime!,
                                            style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                    nearestPrayerTime == null ||
                                            _timeUntil.inHours < 0
                                        ? Container()
                                        : Text(
                                            'متبقى : ${_timeUntil.inHours}:${_timeUntil.inMinutes.remainder(60)}:${_timeUntil.inSeconds.remainder(60)}',
                                            style: TextStyle(
                                              fontSize: 23.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 120.w,
                                          child: Text(
                                            city ?? "",
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 21.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 23.r,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.h),
                                    Text(
                                      _jHijriDate,
                                      style: TextStyle(
                                        fontSize: 21.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
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
