import 'package:finalyear/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // dropdown value
  String dropdownValue = 'en';

  bool validEmail = false;
  bool validPassword = false;

  bool hasShownError = true;
  bool isSuccess = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final textControllerEmail = TextEditingController();
  final textControllerPassword = TextEditingController();

  void languageDropdownChanged(String? value) {
    if (value is String) {
      setState(() {
        dropdownValue = value;
      });
    }
  }

  // _forgotPassword() async {
  //   try {
  //     LoginRepository loginRepository = LoginRepository();
  //     bool isForgot =
  //         await loginRepository.forgotPassword(textControllerEmail.text);

  //     if (isForgot) {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return const SignInScreen();
  //       }));
  //     } else {
  //       MotionToast.error(
  //               description: const Text("Please provide a valid email"))
  //           .show(context);
  //     }
  //   } catch (e) {
  //     MotionToast.error(
  //       description: Text("Error:${e.toString()}"),
  //     ).show(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/arrow_left.svg',
                            width: 15.w,
                            height: 15.h,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Back",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                //sign in with facebook rounded button
                Icon(
                  Icons.lock_outline,
                  color: Colors.green,
                  size: 100.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Did you forgot your password?",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Some description",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                //email text field with svg icon and controller
                InputField(
                  hintText: "Email",
                  icon: validEmail
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : SvgPicture.asset(
                          color: Colors.green,
                          "assets/icons/email.svg",
                          width: 20.w,
                          height: 20.h,
                        ),
                  controller: textControllerEmail,
                  validator: validateEmail,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ElevatedButton(
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Submit",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2.sp),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 20.w),
                            SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: Semantics(
                                label: "Loading",
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2.sp),
                          textAlign: TextAlign.center,
                        ),
                  onPressed: () async {
                    if (!isLoading) {
                      setState(() {
                        isLoading = true;
                      });

                      if (_formKey.currentState!.validate()) {
                        // _forgotPassword();
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                      }
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size.fromHeight(40.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 20.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  String? validateEmail(String? value) {
    String regexEmailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(regexEmailPattern);
    if (!regex.hasMatch(value!)) {
      validEmail = false;
      return "Please enter a valid email";
    } else {
      validEmail = true;
      return null;
    }
  }
}
