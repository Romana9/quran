import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quran/core/colors.dart';
import '../home/home.dart';
import '../home/widgets/azkar_listview.dart';
import '../home/widgets/last_read_listview.dart';
import '../home/widgets/qiblah_compass.dart';
import '../tasbih/tasbih_listview.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [
        const Home(),
        const AzkarListView(),
        const LastReadListView(),
        const QiblahCompass(),
        const TasbihListView(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          iconSize: 24.h,
          title: ("الرئيسية"),
          textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset("assets/svg/doaa.svg"),
          iconSize: 24.h,
          title: ("الأذكار"),
          textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset("assets/svg/home.svg"),
          iconSize: 24.h,
          title: ("المرجعيات"),
          textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.compass),
          iconSize: 24.h,
          title: ("القبلة"),
          textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset("assets/svg/tasbih.svg"),
          iconSize: 24.h,
          title: ("التسبيح"),
          textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      navBarHeight: 75.h,
      backgroundColor: AppColors.primary,
      screens: buildScreens(),
      items: navBarsItems(),
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.r),
          topLeft: Radius.circular(15.r),
        ),
        colorBehindNavBar: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5.r,
            spreadRadius: 1.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
