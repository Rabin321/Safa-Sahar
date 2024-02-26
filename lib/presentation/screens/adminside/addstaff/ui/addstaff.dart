import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/widgets/appbarwithdrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _locationController2 = TextEditingController();

class AdminAddStaff extends StatelessWidget {
  const AdminAddStaff({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> staffData = [
      {'id': '1', 'name': 'John Doe', 'number': '1234567890'},
      {'id': '2', 'name': 'Jane Smith', 'number': '9876543210'},
      // add more staff data as needed
    ];
    double screenHeight = MediaQuery.of(context).size.height;
    return AppBarWithDrawer(
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
              wardnoController: TextEditingController(),
              formKey: GlobalKey<FormState>(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTable(
                      columnSpacing: 80.w,
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Number')),
                      ],
                      rows: staffData
                          .map((staff) => DataRow(cells: [
                                DataCell(Text(staff['id'])),
                                DataCell(Text(staff['name'])),
                                DataCell(Text(staff['number'])),
                              ]))
                          .toList()),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: const Text("Add staff to this ward", style: subhead),
                  ),
                  CustomAddTextfield(
                    name: "Name",
                    hintTextName: "Name...",
                    validatorText: "Please enter a valid name",
                  ),
                  CustomAddTextfield(
                    name: "Location",
                    hintTextName: "Location...",
                    validatorText: "Please enter a valid location",
                  ),
                  CustomAddTextfield(
                    name: "Number",
                    hintTextName: "Number...",
                    validatorText: "Please enter a valid number",
                  ),
                  CustomAddButton(
                    name: "Add",
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildLocationSelectionWidget({
  required BuildContext context,
  required TextEditingController locationController,
  required TextEditingController wardnoController,
  required GlobalKey<FormState> formKey,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.h),
    child: Column(
      children: [
        Container(
          height: 195.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(82, 183, 136, 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Location:",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
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
                Text(
                  "Select Ward:",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                MyTextField(
                  hintText: 'WardNo...',
                  controller: wardnoController,
                  inputType: TextInputType.text,
                  onDropdownPressed: () {
                    wardno(context, wardnoController);
                  },
                  formKey: formKey,
                  showDropdownIcon: true,
                  isEditable: false,
                  onChanged: (value) {},
                ),
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
