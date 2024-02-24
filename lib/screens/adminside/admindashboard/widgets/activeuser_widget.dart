import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildActiveUsersWidget(String activeUsersText, int totalUsers) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 14.w),
    child: Container(
      height: 35.h,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(45.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              activeUsersText,
              style: const TextStyle(
                color: Color(0xFF003E1F),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "TOTAL: $totalUsers",
              style: const TextStyle(
                color: Color(0xFF003E1F),
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
