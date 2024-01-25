import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({super.key, this.error, this.callback});

  @override
  Widget build(BuildContext context) {
    const errorColor = Color(0xffb00020);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.location_off,
            size: 150.h,
            color: errorColor,
          ),
          SizedBox(height: 32.h),
          Text(
            error!,
            style:
                const TextStyle(color: errorColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 32.h),
          ElevatedButton(
            child: const Text("اعادة المحاولة"),
            onPressed: () {
              if (callback != null) callback!();
            },
          )
        ],
      ),
    );
  }
}
