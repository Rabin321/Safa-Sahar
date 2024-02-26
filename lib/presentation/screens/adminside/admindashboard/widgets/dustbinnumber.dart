import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget builddustbinbox(
    {required String title, required VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        color: const Color(0xFF52B788),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              'Total: ',
              style: TextStyle(fontSize: 12.sp),
            )
          ],
        ),
      ),
    ),
  );
}
