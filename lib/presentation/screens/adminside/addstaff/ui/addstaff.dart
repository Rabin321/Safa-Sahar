import 'package:finalyear/components/constants.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/addStaff/addStaffRepository/addStaffRepository.dart';
import 'package:finalyear/presentation/screens/adminside/addstaff/model/contents.dart';
import 'package:finalyear/presentation/screens/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';

class AdminAddStaff extends StatefulWidget {
  const AdminAddStaff({super.key});

  @override
  State<AdminAddStaff> createState() => _AdminAddStaffState();
}

class _AdminAddStaffState extends State<AdminAddStaff> {
  TextEditingController locationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  TextEditingController housenoController = TextEditingController();
  TextEditingController wardnoController = TextEditingController();

  List<AddStaff> addstaff = List.empty(growable: true);
  int selectedIndex = -1;
  @override
  @override
  void dispose() {
    locationController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numberController.dispose();

    super.dispose();
  }

  _registerStaff() async {
    try {
      StaffRepository staffRepository = StaffRepository();
      bool isRegister = await staffRepository.register(AddStaffModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: numberController.text,
        location: locationController.text,
        houseno: 100, //test
        wardno: 3, //test
        isAdmin: 0,
        isStaff: 1,
      ));

      if (isRegister) {
        print("Staff addded successfully");
        // AuthController.login();
      }
      //  else {
      //   MotionToast.error(
      //           height: 50.h,
      //           animationDuration: const Duration(milliseconds: 300),
      //           description: const Text("Something went wrong"))
      //       .show(context);
      // }
    } catch (e) {
      MotionToast.error(
        height: 50.h,
        animationDuration: const Duration(milliseconds: 300),
        description: Text("Error:${e.toString()}"),
      ).show(context);
    }
  }

  Widget build(BuildContext context) {
    List<Map<String, dynamic>> staffData = [
      {
        'id': '1',
        'name': 'John Doe',
        'number': '1234567890',
        'location': 'Maitdevi'
      },
      {
        'id': '2',
        'name': 'Jane Smith',
        'number': '9876543210',
        'location': 'Maitidevi'
      },
      // add more staff data as needed
    ];
    //double screenHeight = MediaQuery.of(context).size.height;
    return AdminAppBarWithDrawer(
      title: 'ADMIN',
      body: SingleChildScrollView(
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
            buildLocationSelectionWidget(
              context: context,
              locationController: TextEditingController(),
              housenoController: TextEditingController(),
              wardnoController: TextEditingController(),
              formKey: GlobalKey<FormState>(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: addstaff.length,
                          itemBuilder: (context, index) => getRow(index)),
                    ),
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: DataTable(
                  //       dataTextStyle: const TextStyle(
                  //           fontSize: 16, fontWeight: FontWeight.w400),
                  //       columnSpacing: 50.w,
                  //       columns: const [
                  //         DataColumn(
                  //             label: Text(
                  //           'ID',
                  //           style: kBodyText2,
                  //         )),
                  //         DataColumn(
                  //             label: Text(
                  //           'Name',
                  //           style: kBodyText2,
                  //         )),
                  //         DataColumn(
                  //             label: Text(
                  //           'Number',
                  //           style: kBodyText2,
                  //         )),
                  //         DataColumn(
                  //             label: Text(
                  //           'Location',
                  //           style: kBodyText2,
                  //         )),
                  //         DataColumn(
                  //             label: Text(
                  //           'Actions',
                  //           style: kBodyText2,
                  //         )),
                  //       ],
                  //       rows: staffData
                  //           .map((staff) => DataRow(cells: [
                  //                 DataCell(Text(staff['id'])),
                  //                 DataCell(Text(staff['name'])),
                  //                 DataCell(Text(staff['number'])),
                  //                 DataCell(Text(staff['location'])),
                  //                 DataCell(Row(
                  //                   children: [
                  //                     IconButton(
                  //                       icon: const Icon(
                  //                         Icons.edit,
                  //                         color: Colors.green,
                  //                       ),
                  //                       onPressed: () {
                  //                         // Handle edit action
                  //                       },
                  //                     ),
                  //                     IconButton(
                  //                       icon: const Icon(
                  //                         Icons.delete,
                  //                         color: Colors.red,
                  //                       ),
                  //                       onPressed: () {
                  //                         // Handle delete action
                  //                       },
                  //                     ),
                  //                   ],
                  //                 ))
                  //               ]))
                  //           .toList()),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: const Text("Add staff to this ward", style: subhead),
                  ),
                  TextField(
                      controller: nameController,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Name...', hintStyle: kBodyText)),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: TextField(
                        controller: emailController,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Email...', hintStyle: kBodyText)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: TextField(
                        controller: passwordController,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Password...', hintStyle: kBodyText)),
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Location',
                  //       style: kBodyText,
                  //     ),
                  //     TextFormField(
                  //       controller: locationController,
                  //       decoration: kTextFieldDecoration.copyWith(
                  //           hintText: 'Location...',
                  //           hintStyle: kBodyText,
                  //           suffixIcon: IconButton(
                  //             icon: const Icon(Icons.arrow_drop_down),
                  //             onPressed: () {
                  //               location(context, locationController);
                  //             },
                  //           )),
                  //       readOnly: false,
                  //     ),
                  //   ],
                  // ),
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
                          validator: Validator.requiredValidator,
                        ),
                      ),
                    ],
                  ),
                  CustomAddButton(
                    name: "Add",
                    onPressed: () {
                      // if (nameController.text.isNotEmpty &&
                      //     locationController.text.isNotEmpty &&
                      //     numberController.text.isNotEmpty &&
                      //     emailController.text.isNotEmpty &&
                      //     passwordController.text.isNotEmpty) {
                      _registerStaff();

                      nameController.clear();
                      locationController.clear();
                      numberController.clear();
                      emailController.clear();
                      passwordController.clear();

                      // } else {
                      //   MotionToast.error(
                      //           height: 50.h,
                      //           animationDuration:
                      //               const Duration(milliseconds: 300),
                      //           description: const Text("Something went wrong"))
                      //       .show(context);
                      // }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2 == 0 ? Colors.green : Colors.lightGreen,
          foregroundColor: Colors.white,
          child: Text(
            addstaff[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(addstaff[index].name),
            Text(addstaff[index].location),
            Text(addstaff[index].number),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  //
                  nameController.text = addstaff[index].name;
                  locationController.text = addstaff[index].location;
                  numberController.text = addstaff[index].number;
                  setState(() {
                    selectedIndex = index;
                  });
                  //
                },
                child: const Icon(Icons.edit),
              ),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      addstaff.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildLocationSelectionWidget({
  required BuildContext context,
  required TextEditingController locationController,
  required TextEditingController wardnoController,
  required TextEditingController housenoController,
  required GlobalKey<FormState> formKey,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.h),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(82, 183, 136, 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
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
                  showDropdownIcon: true,
                  validator: (name) =>
                      name!.isEmpty ? 'Please enter your location' : null,
                  isEditable: false,
                  onChanged: (value) {},
                ),
                // Text("Select Ward:", style: kHeadline),
                // MyTextField(
                //   hintText: 'WardNo...',
                //   controller: wardnoController,
                //   inputType: TextInputType.text,
                //   onDropdownPressed: () {
                //     wardno(context, wardnoController);
                //   },
                //   formKey: formKey,
                //   showDropdownIcon: true,
                //   isEditable: false,
                //   onChanged: (value) {},
                // ),
                // Text("Select House no:", style: kHeadline),
                // MyTextField(
                //   hintText: 'Houseno...',
                //   controller: housenoController,
                //   inputType: TextInputType.text,
                //   onDropdownPressed: () {
                //     houseno(context, housenoController);
                //   },
                //   formKey: formKey,
                //   showDropdownIcon: true,
                //   isEditable: false,
                //   onChanged: (value) {},
                // ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        const Row(
          children: [
            Text(
              "Staff Details",
              style: subhead,
            )
          ],
        ),
      ],
    ),
  );
}
