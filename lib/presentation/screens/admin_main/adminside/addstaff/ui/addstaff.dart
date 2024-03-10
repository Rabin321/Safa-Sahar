import 'package:dio/dio.dart';
import 'package:finalyear/components/constants.dart';
// import 'package:finalyear/domain/addStaff/addStaffApi/addStaffApi.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/addStaff/addStaffRepository/addStaffRepository.dart';
import 'package:finalyear/domain/signup/http_services.dart';
// import 'package:finalyear/presentation/screens/adminside/addstaff/model/contents.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

class AdminAddStaff extends StatefulWidget {
  const AdminAddStaff({super.key});

  @override
  State<AdminAddStaff> createState() => _AdminAddStaffState();
}

class _AdminAddStaffState extends State<AdminAddStaff> {
  List<AddStaff> addstaff = []; // Define addstaff list here

  TextEditingController locationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  TextEditingController housenoController = TextEditingController();
  TextEditingController wardnoController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool _isLoading = false;
  int _page = 1;
  int _pageSize = 10;

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    addstaff = [];
    _fetchStaffMembersok();
  }

  Future<void> _fetchStaffMembersok() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Make API call to fetch staff members
      final List<AddStaff> staffMembers =
          // await StaffRepository().fetchStaffMembers();
          await StaffRepository()
              .fetchStaffMembers(page: _page, pageSize: _pageSize);

      setState(() {
        // addstaff = staffMembers;
        addstaff.addAll(staffMembers);
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching staff members: $e');
      // Handle error
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreStaffMembers() async {
    // Increment the page number to fetch the next page of staff members
    _page++;
    await _fetchStaffMembersok();
  }

  Future<void> _refreshStaffMembers() async {
    setState(() {
      // addstaff.clear();
    });
    await _fetchStaffMembersok();
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
        houseno: 100, //test
        // wardno: 3, //test
        wardno: int.parse(wardnoController.text),
        isAdmin: 0,
        isStaff: 1,
      ));

      if (isRegister) {
        print("Staff addded successfully");

        // Add the newly registered staff to the addstaff list
        addstaff.add(AddStaff(
          name: nameController.text,
          location: locationController.text,
          number: numberController.text,
        ));

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

  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    return AdminAppBarWithDrawer(
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
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Select Location:", style: kHeadline),
                              MyTextField(
                                hintText: 'Location...',
                                controller: locationController,
                                inputType: TextInputType.text,
                                onDropdownPressed: () {
                                  location(context, locationController);
                                },
                                formKey: formKey,
                                showDropdownIcon: false,
                                validator: (name) => name!.isEmpty
                                    ? 'Please enter your location'
                                    : null,
                                isEditable: true,
                                onChanged: (value) {
                                  // Update locationController when location is selected
                                  locationController.text = value.toString();
                                  print(
                                      "locationController: ${locationController.text}");
                                },
                              ),
                              Text("Select Ward:", style: kHeadline),
                              MyTextField(
                                inputType: TextInputType
                                    .number, // Set inputType to TextInputType.number

                                hintText: 'WardNo...',
                                controller: wardnoController,
                                onDropdownPressed: () {
                                  wardno(context, wardnoController);
                                },
                                formKey: formKey,
                                showDropdownIcon: false,
                                validator: (name) => name!.isEmpty
                                    ? 'Please enter your ward number'
                                    : null,
                                isEditable: true,
                                onChanged: (value) {
                                  // Update wardnoController when ward number is selected
                                  wardnoController.text = value.toString();
                                  print("ward no: ${wardnoController.text}");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
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
                              height:
                                  200.h, // Set a fixed height for the container

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
                                      DataColumn(label: Text('Phone')),
                                      DataColumn(
                                          label: Text(
                                              'Actions')), // New column for actions
                                    ],
                                    rows: addstaff
                                        .map(
                                          (staff) => DataRow(cells: [
                                            DataCell(Text(staff.name)),
                                            DataCell(Text(staff.location)),
                                            DataCell(Text(staff.number)),
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
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter a password' : null,
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
                                  hintText: "Number...", hintStyle: kBodyText),
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
                          if (formKey.currentState!.validate()) {
                            _registerStaff();
                            nameController.clear();
                            numberController.clear();
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
