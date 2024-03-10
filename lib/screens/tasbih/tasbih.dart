import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quran/core/colors.dart';

class Tasbih extends StatefulWidget {
  final Map data;
  const Tasbih({super.key, required this.data});

  @override
  State<Tasbih> createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {
  int tasbihNum = 0;
  double tasbihPercent = 0;
  int completedNum = 0;
  int totalNum = 0;

  @override
  Widget build(BuildContext context) {
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
                      const Spacer(),
                      Text(
                        "تسابيح",
                        style: TextStyle(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "TheSansBold",
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 25.h,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    width: 350.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondray.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.data["title"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "TheSansBold",
                          ),
                        ),
                        SizedBox(height: 40.h),
                        InkWell(
                          onTap: () {
                            if (tasbihNum < int.parse(widget.data["num"])) {
                              setState(() {
                                totalNum++;
                                tasbihNum++;
                                tasbihPercent =
                                    (tasbihNum / int.parse(widget.data["num"]));
                              });
                            } else if (tasbihNum ==
                                int.parse(widget.data["num"])) {
                              setState(() {
                                completedNum++;
                                totalNum++;
                                tasbihNum = 1;
                                tasbihPercent =
                                    (tasbihNum / int.parse(widget.data["num"]));
                              });
                            }
                          },
                          child: CircularPercentIndicator(
                            percent: tasbihPercent,
                            radius: 150.r,
                            lineWidth: 13.w,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: AppColors.secondray,
                            center: Stack(
                              children: [
                                SizedBox(
                                  width: 78.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        tasbihNum.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp,
                                          color: Colors.white,
                                          fontFamily: "TheSansBold",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 40.h,
                                  child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(start: 20.w),
                                    child: Text(
                                      widget.data["num"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "المرات المكتملة",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    completedNum.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: const Color(0xffBBC4CE),
                                thickness: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "العدد الاجمالي",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    totalNum.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  totalNum = 0;
                                  completedNum = 0;
                                  tasbihNum = 0;
                                  tasbihPercent = 0;
                                });
                              },
                              child: Container(
                                height: 50.h,
                                width: 50.h,
                                decoration: BoxDecoration(
                                  color: AppColors.secondray,
                                  shape: BoxShape.circle,
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
                                    child: Icon(
                                  Icons.replay_outlined,
                                  color: Colors.white,
                                  size: 22.h,
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (tasbihNum != 0) {
                                  setState(() {
                                    totalNum--;
                                    tasbihNum--;
                                    tasbihPercent = (tasbihNum /
                                        int.parse(widget.data["num"]));
                                  });
                                }
                              },
                              child: Container(
                                height: 50.h,
                                width: 50.h,
                                decoration: BoxDecoration(
                                  color: AppColors.secondray,
                                  shape: BoxShape.circle,
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
                                  child: Text(
                                    "1-",
                                    style: TextStyle(
                                      fontSize: 21.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
