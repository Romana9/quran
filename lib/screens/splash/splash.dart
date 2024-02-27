import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/colors.dart';
import 'package:quran/screens/home/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    slidingAnimation =
        Tween<Offset>(begin: const Offset(1.5, 1.5), end: Offset.zero)
            .animate(animationController);

    animationController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 86.h),
            Text(
              "قرآني",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontFamily: "TheSansBold",
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "إِنَّا نَحْنُ نَزَّلْنَا الذِّكْرَ وَإِنَّا لَهُ لَحَافِظُونَ",
              style: TextStyle(
                fontSize: 18.sp,
                color: const Color(0xff8789A3),
              ),
            ),
            SizedBox(height: 40.h),
            AnimatedBuilder(
              animation: slidingAnimation,
              builder: (BuildContext context, Widget? child) {
                return SlideTransition(
                  position: slidingAnimation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: SizedBox(
                      height: 500.h,
                      child: Container(
                        height: 500.h,
                        width: 314.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: const DecorationImage(
                            image: AssetImage("assets/img/splash.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
