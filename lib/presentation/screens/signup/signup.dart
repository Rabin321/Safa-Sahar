import 'package:finalyear/domain/signup/signUp_repository.dart/signUP_repository.dart';
import 'package:finalyear/domain/signup/signupModel/signUpModel.dart';
import 'package:finalyear/presentation/screens/login/signin_page.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../widgets/widget.dart';
import '../../../components/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool passwordVisibility = true;

  // Define controllers for your text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _housenoController = TextEditingController();
  final TextEditingController _wardnoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _locationController.dispose();
    _housenoController.dispose();
    _wardnoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _registerUser() async {
    try {
      UserRepository userRepository = UserRepository();
      bool isRegister = await userRepository.register(SignUpModel(
        name: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ));

      if (isRegister) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignInPage()));
        // AuthController.login();
      } else {
        MotionToast.error(description: const Text("Something went wrong"))
            .show(context);
      }
    } catch (e) {
      MotionToast.error(
        description: Text("Error:${e.toString()}"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Image(
                              image: const AssetImage(
                                'assets/images/Eco.png',
                              ),
                              height: 100.h,
                            ),
                          ),
                          Text('SAFA SAHAR',
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          // const Text(
                          //   "Register",
                          //   style: kHeadline,
                          // ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                MyTextField(
                                  formKey: _formKey,
                                  hintText: 'Full Name',
                                  controller: _fullNameController,
                                  inputType: TextInputType.name,
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your full name'
                                      : null,
                                  isEditable: true,
                                  onChanged: (value) {},
                                ),
                                MyTextField(
                                  hintText: 'Location',
                                  controller: _locationController,
                                  inputType: TextInputType.text,
                                  onDropdownPressed: () {
                                    location(context,
                                        _locationController); // Call the _wardno method
                                  },
                                  formKey: _formKey,
                                  showDropdownIcon: true,
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your location'
                                      : null,
                                  isEditable: true,
                                  onChanged: (value) {},
                                ),
                                MyTextField(
                                  hintText: 'House No',
                                  showDropdownIcon: true,
                                  onDropdownPressed: () {
                                    houseno(context,
                                        _housenoController); // Call the _wardno method
                                  },
                                  controller: _housenoController,
                                  inputType: TextInputType.text,
                                  formKey: _formKey,
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your house no'
                                      : null,
                                  isEditable: false,
                                  onChanged: (value) {},
                                ),
                                MyTextField(
                                  hintText: 'Ward No',
                                  showDropdownIcon: true,
                                  onDropdownPressed: () {
                                    wardno(context,
                                        _wardnoController); // Call the _wardno method
                                  },
                                  controller: _wardnoController,
                                  inputType: TextInputType.text,
                                  formKey: _formKey,
                                  validator: (name) => name!.isEmpty
                                      ? 'Please enter your ward no'
                                      : null,
                                  isEditable: false,
                                  onChanged: (value) {},
                                ),
                                MyTextField(
                                  hintText: 'Email',
                                  controller: _emailController,
                                  inputType: TextInputType.emailAddress,
                                  validator: _validateEmail,
                                  formKey: _formKey,
                                  isEditable: true,
                                  onChanged: (value) {},
                                ),
                                MyPasswordField(
                                  controller: _passwordController,
                                  isPasswordVisible: passwordVisibility,
                                  onTap: () {
                                    setState(() {
                                      passwordVisibility = !passwordVisibility;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: kBodyText.copyWith(fontSize: 15.sp),
                        ),
                        GestureDetector(
                          child: Text.rich(
                            TextSpan(
                              text: "Sign In",
                              style: kBodyText.copyWith(
                                  color: Colors.red, fontSize: 15.sp),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to RegisterPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInPage()),
                                  );
                                },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
                      child: MyTextButton(
                        buttonName: 'Register',
                        bgColor: Colors.green,
                        textColor: Colors.black87,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Validation succeeded, proceed with registration
                            _registerUser();
                          } else {
                            print("Validation error");
                            // Validation failed, do not proceed
                            // You can optionally display an error message to the user
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? email) {
    RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
