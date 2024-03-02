import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _locationController2 = TextEditingController();

class AdminNotificationPage extends StatelessWidget {
  const AdminNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> staffData = [
      {'did': '1', 'fillPercentage': '20%', 'assignedStaff': 'Ujjwal'},
      {'did': '2', 'fillPercentage': '40%', 'assignedStaff': 'Rohan'},
      // add more staff data as needed
    ];
    double screenHeight = MediaQuery.of(context).size.height;
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
                  "WASTE PICKUP",
                  style: kBodyText2.copyWith(
                      color: const Color(0xFF365307), letterSpacing: 1),
                ),
              ),
            ),
            buildLocationSelectionWidget2(
              name: "Add Schedule",
              context: context,
              locationController: TextEditingController(),
              wardnoController: TextEditingController(),
              formKey: GlobalKey<FormState>(),
            ),
            buildLocationSelectionWidget(
              name: "",
              formKey: GlobalKey<FormState>(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(82, 183, 136, 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                height: 130.h,
                width: double.maxFinite,
                // color: const Color.fromRGBO(82, 183, 136, 0.5),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 11.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),
                    height: double.infinity,
                    child: const TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Type here...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
              child: CustomAddButton(name: "Publish", onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildLocationSelectionWidget({
  BuildContext? context,
  TextEditingController? locationController,
  TextEditingController? wardnoController,
  GlobalKey<FormState>? formKey,
  final String? name,
  // CustomAddTextfield? customAddTextfield,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.h),
    child: Column(
      children: [
        Container(
          // height: 225.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(82, 183, 136, 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextField2(
                  hintText: 'Ward',
                  controller: locationController,
                  inputType: TextInputType.text,
                  formKey: formKey!,
                  validator: (name) =>
                      name!.isEmpty ? 'Please enter your ward' : null,
                  onChanged: (value) {},
                ),
                MyTextField2(
                  hintText: 'Street',
                  controller: locationController,
                  inputType: TextInputType.text,
                  formKey: formKey!,
                  validator: (name) =>
                      name!.isEmpty ? 'Please enter your street' : null,
                  onChanged: (value) {},
                ),
                MyTextField2(
                  hintText: 'Pickup time',
                  controller: locationController,
                  inputType: TextInputType.text,
                  formKey: formKey!,
                  validator: (name) =>
                      name!.isEmpty ? 'Please enter your pickup time' : null,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: 10.h,
        // ),
        Row(
          children: [
            Text(
              name!,
              style: subhead,
            )
          ],
        ),
      ],
    ),
  );
}

Widget buildLocationSelectionWidget2({
  BuildContext? context,
  TextEditingController? locationController,
  TextEditingController? wardnoController,
  required GlobalKey<FormState> formKey,
  required String name,
  CustomAddTextfield? customAddTextfield,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.h),
    child: Column(
      children: [
        Container(
          // height: 105.h,
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
                    location(context!, locationController!);
                  },
                  formKey: formKey,
                  showDropdownIcon: true,
                  validator: (name) =>
                      name!.isEmpty ? 'Please enter your location' : null,
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
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              Text(
                name,
                style: subhead,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
