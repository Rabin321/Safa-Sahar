// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:finalyear/components/constants.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/addStaff/addStaffRepository/addStaffRepository.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:http/http.dart' as http;

class AdminAddStaff extends StatefulWidget {
  const AdminAddStaff({super.key});

  @override
  State<AdminAddStaff> createState() => _AdminAddStaffState();
}

class _AdminAddStaffState extends State<AdminAddStaff> {
  // List<AddStaff> addstaff = []; // Define addstaff list here

  TextEditingController locationController = TextEditingController();
  TextEditingController filterWardController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  TextEditingController housenoController = TextEditingController();
  TextEditingController wardnoController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeydrpdwn = GlobalKey<FormState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Map<String, String>> staffList = []; // Store staff details acc to ward

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    // addstaff = [];
    // _fetchStaffMembersok();
  }

  // Future<void> _fetchStaffMembersok() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     // Make API call to fetch staff members
  //     final List<AddStaff> staffMembers =
  //         // await StaffRepository().fetchStaffMembers();
  //         await StaffRepository()
  //             .fetchStaffMembers(page: _page, pageSize: _pageSize);

  //     setState(() {
  //       // addstaff = staffMembers;
  //       addstaff.addAll(staffMembers);
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error fetching staff members: $e');
  //     // Handle error
  //     // Handle error
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _loadMoreStaffMembers() async {
  //   // Increment the page number to fetch the next page of staff members
  //   _page++;
  //   await _fetchStaffMembersok();
  // }

  // Future<void> _refreshStaffMembers() async {
  //   setState(() {
  //     // addstaff.clear();
  //   });
  //   await _fetchStaffMembersok();
  // }

  // just to run
  Future<void> _refreshStaffMembers() async {
    //   setState(() {
    //     // addstaff.clear();
    //   });
    //   await _fetchStaffMembersok();
  }

  @override
  void dispose() {
    locationController.dispose();
    wardnoController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();

    super.dispose();
  }

// Create a method to validate the filter section
  // void _validateFilterSection() {
  //   if (formKeydrpdwn.currentState!.validate()) {
  //     // Filter section is valid, perform filtering logic here
  //   }
  // }

  _registerStaff() async {
    try {
      // int wardNumber = int.parse(wardnoController.text);
      // print("Parsed ward number: $wardNumber");
      StaffRepository staffRepository = StaffRepository();
      bool isRegister = await staffRepository.register(AddStaffModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: numberController.text,
        location: locationController.text,
        // houseno: 100, //test
        // wardno: 3, //test
        ward: int.parse(wardnoController.text),

        isAdmin: 0,
        isStaff: 1,
      ));

      if (isRegister) {
        print("Staff addded successfully");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Staff added successfully")),
        ); // AuthController.login();
      } else {
        throw Exception("Registration failed");
      }
    } catch (e) {
      MotionToast.error(
        height: 50.h,
        width: double.infinity,
        animationDuration: const Duration(milliseconds: 300),
        description: const Text("Something went wrong"),
      ).show(context);
    }
  }

  Future<void> fetchStaffByWard(int ward) async {
    try {
      staffList.clear(); //yo herna parchha

      final response = await http.get(
          Uri.parse('http://192.168.1.74:5000/api/get-staff-ward/?ward=$ward'));
      if (response.statusCode == 200) {
        print("staffbyward res");
        final data = jsonDecode(response.body);
        // Extract staff members' names, locations, and emails
        final List<dynamic> staffMembers = data['staffMembers'];

        staffList.clear(); //yo herna parchha

        staffMembers.forEach((staff) {
          final String name = staff['name'];
          final String location = staff['location'];
          final String email = staff['email'];
          print('Name: $name, Location: $location, Email: $email');
          // Add staff details to the staff list
          staffList.add({
            'Name': name,
            'Location': location,
            'Email': email,
          });
        });
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please try again")),
        );
        print('Failed to fetch staff members: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching staff members: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please try again")),
      );
    }
  }

  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: AdminAppBarWithDrawer(
        title: 'ADMIN',
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshStaffMembers,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "STAFFS",
                        style: kBodyText2.copyWith(
                            color: const Color(0xFF365307), letterSpacing: 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(82, 183, 136, 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select Ward no:", style: kHeadline),
                                MyTextField(
                                  hintText: 'Ward no...',
                                  controller: filterWardController,
                                  inputType: TextInputType.text,
                                  onDropdownPressed: () {
                                    wardno(context, filterWardController);
                                  },
                                  // formKey: formKeydrpdwn,
                                  showDropdownIcon: true,
                                  // validator: (name) => name!.isEmpty
                                  //     ? 'Please select your location'
                                  //     : null,
                                  isEditable: false,
                                  onChanged: (value) {
                                    // Update locationController when location is selected
                                    filterWardController.text = value;
                                    print(
                                        "filterwardController: ${filterWardController.text}");
                                  },
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        fetchStaffByWard(int.parse(
                                            filterWardController.text));
                                      },
                                      child: Text("Filter")),
                                )
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(height: 15.h),
                        const Row(
                          children: [
                            Text(
                              "Staff Details",
                              style: subhead,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Column(
                            children: [
                              Container(
                                height: 150.h,
                                //     .h, // Set a fixed height for the container

                                child: Scrollbar(
                                  thumbVisibility: true,
                                  trackVisibility: true,
                                  showTrackOnHover: true,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
                                      columnSpacing: 3.w,
                                      columns: const [
                                        DataColumn(label: Text('Name')),
                                        DataColumn(label: Text('Location')),
                                        DataColumn(label: Text('Email')),
                                        DataColumn(
                                            label: Text(
                                                'Actions')), // New column for actions
                                      ],
                                      rows: staffList
                                          .map(
                                            (staff) => DataRow(cells: [
                                              DataCell(
                                                  Text(staff['Name'] ?? '')),
                                              DataCell(Text(
                                                  staff['Location'] ?? '')),
                                              DataCell(
                                                  Text(staff['Email'] ?? '')),
                                              DataCell(Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      // Add your edit logic here
                                                      // For example, navigate to a new screen for editing staff details
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red[600],
                                                    ),
                                                    onPressed: () {
                                                      // Add your delete logic here
                                                      // For example, show a confirmation dialog before deleting the staff
                                                    },
                                                  ),
                                                ],
                                              )),
                                            ]),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 20),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: const Text("Add staff to this ward",
                              style: subhead),
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Name...',
                            hintStyle: kBodyText,
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter a name' : null,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: emailController,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Email...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an email';
                              } else if (!Validator.isValidEmail(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Password...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a password'
                                : null,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: locationController,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Location...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a location'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: TextFormField(
                            controller: wardnoController,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Ward Number...',
                              hintStyle: kBodyText,
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a ward number'
                                : null,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Number',
                            //   style: kBodyText,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: TextFormField(
                                controller: numberController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: "Phone Number...",
                                    hintStyle: kBodyText),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a phone number';
                                  } else if (!Validator.isValidPhoneNumber(
                                      value)) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        CustomAddButton(
                          name: "Add",
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            if (formKey.currentState!.validate()) {
                              _registerStaff();
                              nameController.clear();
                              numberController.clear();
                              locationController.clear();
                              wardnoController.clear();
                              emailController.clear();
                              passwordController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Validator {
  static bool isValidEmail(String email) {
    // Regular expression for validating email addresses
    // This regular expression checks for a basic email format with @ and .
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    // Regular expression for validating phone numbers
    // This regular expression checks for a basic phone number format with digits only
    final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }
}
