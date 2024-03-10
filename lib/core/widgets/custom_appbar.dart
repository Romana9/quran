import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quran/core/app_cubit/app_cubit.dart';
import 'package:share/share.dart';
import '../../screens/search/search.dart';
import '../colors.dart';

final _searchController = TextEditingController();

class CustomAppBar extends StatelessWidget {
  final Widget? child;
  const CustomAppBar({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            InkWell(
              onTap: () {
                // if (Platform.isIOS) {
                //   Share.share(
                //       "https://apps.apple.com/eg/app/القرآن-الكريـم/id1603915644");
                // } else {
                //   Share.share("http://onelink.to/k5eqch");
                // }
                Share.share("http://onelink.to/k5eqch");
              },
              child: Icon(
                Icons.share,
                color: Colors.white,
                size: 24.h,
              ),
            ),
            const Spacer(),
            Text(
              "قرآني",
              style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "TheSansBold",
              ),
            ),
            const Spacer(),
            // InkWell(
            //   onTap: () {
            //     AppCubit.get(context).search.clear();
            //     print(AppCubit.get(context).search);
            //     searchDialog(context);
            //   },
            //   child: Icon(
            //     Icons.search,
            //     color: Colors.white,
            //     size: 24.h,
            //   ),
            // ),
          ],
        );
      },
    );
  }

  Future<bool?> searchDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "البحث",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            content: TextFormField(
              controller: _searchController,
              validator: (value) {
                if (_searchController.text.isEmpty) {
                  return "ادخل البحث من فضلك";
                } else {
                  return null;
                }
              },
              onFieldSubmitted: (value) {
                AppCubit.get(context).search = AppCubit.get(context)
                    .surah
                    .where((s) =>
                        s["name"].toString().contains(_searchController.text))
                    .toList();
                print(AppCubit.get(context).search);
                Navigator.of(context).pop(false);
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const Search(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
                _searchController.clear();
              },
              style: TextStyle(fontSize: 16.sp),
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: "عن اي سورة تبحث ؟",
                hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Icon(
                    Icons.search,
                    size: 20.h,
                    color: const Color(0xff8789A3),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    borderSide: const BorderSide(color: AppColors.primary)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15.r))),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15.r))),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  AppCubit.get(context).search = AppCubit.get(context)
                      .surah
                      .where((s) =>
                          s["name"].toString().contains(_searchController.text))
                      .toList();
                  print(AppCubit.get(context).search);
                  Navigator.of(context).pop(false);
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const Search(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  _searchController.clear();
                },
                child: Text(
                  "بحث",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondray,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
