// ignore_for_file: use_build_context_synchronously

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAwareness extends StatefulWidget {
  const UserAwareness({super.key});

  @override
  State<UserAwareness> createState() => _UserAwarenessState();
}

class _UserAwarenessState extends State<UserAwareness> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: UserAppBarWithDrawer(
        title: 'USER',
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Today's Awareness",
                      style: kBodyText2.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF365307),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                // Add some text here
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum ultricies felis, et blandit nisi fermentum in.",
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                Image.asset(
                  'assets/images/awareness.jpeg',
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 25.h),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum ultricies felis, et blandit nisi fermentum in.",
                  style: TextStyle(fontSize: 16.sp),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum ultricies felis, et blandit nisi fermentum in.",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
