import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _locationController2 = TextEditingController();

class AdminAddDustbin extends StatelessWidget {
  const AdminAddDustbin({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> staffData = [
      {'did': '1', 'fillPercentage': '20%', 'assignedStaff': 'Ujjwal'},
      {'did': '2', 'fillPercentage': '40%', 'assignedStaff': 'Rohan'},
      // add more staff data as needed
    ];
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
                  "DUSTBIN",
                  style: kBodyText2.copyWith(
                      color: const Color(0xFF365307), letterSpacing: 1),
                ),
              ),
            ),
            buildLocationSelectionWidget(
              name: "Dustbin Details",
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 50.w,
                      columns: const [
                        DataColumn(label: Text('Dustbin ID')),
                        DataColumn(label: Text('Fill Percentage')),
                        DataColumn(label: Text('Assigned Staff')),
                      ],
                      rows: staffData
                          .map((staff) => DataRow(cells: [
                                DataCell(Text(staff['did'])),
                                DataCell(Text(staff['fillPercentage'])),
                                DataCell(Text(staff['assignedStaff'])),
                              ]))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child:
                        const Text("Add Dustbin to this ward", style: subhead),
                  ),
                  CustomAddTextfield(
                    name: "Dustbin ID",
                    hintTextName: "Dustbin id...",
                    validatorText: "Please enter a valid dustbin id",
                    controller: null,
                  ),
                  CustomAddTextfield(
                    name: "Location",
                    hintTextName: "Location...",
                    validatorText: "Please enter a valid location",
                    controller: null,
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
  required final String name,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.h),
    child: Column(
      children: [
        Container(
          // height: 195.h,
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
                Text("Select Ward:", style: kHeadline),
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
        Row(
          children: [
            Text(
              name,
              style: subhead,
            )
          ],
        ),
      ],
    ),
  );
}
