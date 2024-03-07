import 'dart:async';
import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran/core/colors.dart';
import '../../../core/widgets/custom_appbar.dart';
import 'location_error_widget.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  _QiblahCompassState createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => _locationStreamController.stream;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    super.dispose();
  }

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
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: const CustomAppBar(),
                ),
                SizedBox(height: 100.h),
                Container(
                  height: 430.h,
                  alignment: Alignment.center,
                  child: StreamBuilder(
                    stream: stream,
                    builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: 350.h,
                          child: const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.secondray),
                          ),
                        );
                      }
                      if (snapshot.data!.enabled == true) {
                        switch (snapshot.data!.status) {
                          case LocationPermission.always:
                          case LocationPermission.whileInUse:
                            return StreamBuilder(
                              stream: FlutterQiblah.qiblahStream,
                              builder:
                                  (_, AsyncSnapshot<QiblahDirection> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: 350.h,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.secondray,
                                      ),
                                    ),
                                  );
                                }

                                final qiblahDirection = snapshot.data!;

                                return Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Transform.rotate(
                                      angle: (qiblahDirection.direction *
                                          (pi / 180) *
                                          -1),
                                      child: SvgPicture.asset(
                                        'assets/svg/compass.svg',
                                        height: 380.h,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: (qiblahDirection.qiblah *
                                          (pi / 180) *
                                          -1),
                                      child: SvgPicture.asset(
                                        'assets/svg/needle.svg',
                                        height: 380.h,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                          case LocationPermission.denied:
                            return LocationErrorWidget(
                              error: "Location service permission denied",
                              callback: _checkLocationStatus,
                            );
                          case LocationPermission.deniedForever:
                            return LocationErrorWidget(
                              error: "Location service Denied Forever !",
                              callback: _checkLocationStatus,
                            );
                          default:
                            return const SizedBox();
                        }
                      } else {
                        return LocationErrorWidget(
                          error: "Please enable Location service",
                          callback: _checkLocationStatus,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }
}
