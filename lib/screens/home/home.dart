import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import '../../core/widgets/custom_appbar.dart';
import 'widgets/prayer_time_container.dart';
import 'widgets/surah_listview.dart';

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
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(top: 50.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: const CustomAppBar(),
                      ),
                      SizedBox(height: 24.h),
                      const PrayerTimeContainer(),
                      SizedBox(height: 24.h),
                      // const CustomRowButtons(),
                      // SizedBox(height: 24.h),
                      const SurahListView(),
                      // AppCubit.get(context).buttonIndex == 0
                      //     ?
                      //     : AppCubit.get(context).buttonIndex == 1
                      //         ? const AzkarListView()
                      //         : AppCubit.get(context).buttonIndex == 2
                      //             ? currentList.isEmpty
                      //                 ? SizedBox(
                      //                     height: 350.h,
                      //                     child: Center(
                      //                       child: Lottie.asset(
                      //                         'assets/svg/bookmark.json',
                      //                       ),
                      //                     ),
                      //                   )
                      //                 : const LastReadListView()
                      //             : const QiblahCompass(),
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
