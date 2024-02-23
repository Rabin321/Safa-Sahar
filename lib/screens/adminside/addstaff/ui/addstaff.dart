import 'package:finalyear/components/constants.dart';
import 'package:finalyear/screens/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/screens/signup/widgets/methods.dart';
import 'package:finalyear/widgets/appbarwithdrawer.dart';
import 'package:finalyear/widgets/my_text_button.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

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
            Align(
              alignment: Alignment.center,
              child: Text(
                "STAFFS",
                style: kBodyText2.copyWith(color: const Color(0xFF365307)),
              ),
            ),
            buildLocationSelectionWidget(
              context: context,
              locationController: TextEditingController(),
              wardnoController: TextEditingController(),
              formKey: GlobalKey<FormState>(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTable(
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
                  const SizedBox(height: 10),
                  const Text("Add staff to this ward", style: kBodyText),
                  const SizedBox(height: 15),
                  const StaffForm(),
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
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: [
        Container(
          height: 215,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(82, 183, 136, 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Location:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
                const Text(
                  "Select Ward:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              "Staff Details",
              style: kBodyText,
            )
          ],
        ),
      ],
    ),
  );
}
