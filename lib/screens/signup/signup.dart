import 'package:finalyear/screens/login/signin_page.dart';
import 'package:finalyear/screens/signup/widgets/methods.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widgets/widget.dart';
import '../../components/constants.dart';

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage(
                              'assets/images/Eco.png',
                            ),
                            height: 100.0,
                          ),
                          const Text('SAFA SAHAR',
                              style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const Text(
                            "Register",
                            style: kHeadline,
                          ),
                          const SizedBox(
                            height: 20,
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
                                      ? 'Please enter your full name'
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
                                      ? 'Please enter your full name'
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
                        const Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          child: Text.rich(
                            TextSpan(
                              text: "Sign In",
                              style: kBodyText.copyWith(
                                color: Colors.black,
                              ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: MyTextButton(
                        buttonName: 'Register',
                        bgColor: Colors.blueGrey,
                        textColor: Colors.black87,
                        onPressed: () {
                          _formKey.currentState!.validate();
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
