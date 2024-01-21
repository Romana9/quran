import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../main.dart';
import 'widgets/last_read_listview.dart';
import 'widgets/qiblah_compass.dart';
import 'widgets/surah_listview.dart';
import 'widgets/row_buttons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 45.h, right: 24.w, left: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  child: InkWell(
                    onTap: () {
                      FlutterRingtonePlayer().stop();
                    },
                    child: SvgPicture.asset("assets/svg/menu.svg"),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "السلام عليكم",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff240F4F),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/home.png",
                      height: 131.h,
                      width: 326.w,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                const CustomRowButtons(),
                SizedBox(height: 24.h),
                AppCubit.get(context).buttonIndex == 0
                    ? const SurahListView()
                    : AppCubit.get(context).buttonIndex == 1
                        ? currentList.isEmpty
                            ? SizedBox(
                                height: 350.h,
                                child: Center(
                                  child:
                                      Lottie.asset('assets/svg/bookmark.json'),
                                ),
                              )
                            : const LastReadListView()
                        : const QiblahCompass(),
              ],
            ),
          ),
        );
      },
    );
  }
}
