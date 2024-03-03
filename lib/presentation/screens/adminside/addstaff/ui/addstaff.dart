import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/adminside/addstaff/model/contents.dart';
import 'package:finalyear/presentation/screens/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';
import 'package:finalyear/widgets/appBarWithDrawer/admin_appbarWithDrawer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminAddStaff extends StatefulWidget {
  const AdminAddStaff({super.key});

  @override
  State<AdminAddStaff> createState() => _AdminAddStaffState();
}

class _AdminAddStaffState extends State<AdminAddStaff> {
  TextEditingController locationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  List<AddStaff> addstaff = List.empty(growable: true);
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> staffData = [
    //   {
    //     'id': '1',
    //     'name': 'John Doe',
    //     'number': '1234567890',
    //     'location': 'Maitdevi'
    //   },
    //   {
    //     'id': '2',
    //     'name': 'Jane Smith',
    //     'number': '9876543210',
    //     'location': 'Maitidevi'
    //   },
    //   // add more staff data as needed
    // ];
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
              wardnoController: TextEditingController(),
              formKey: GlobalKey<FormState>(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  addstaff.isEmpty
                      ? Text(
                          'No details yet.. add first',
                          style: kBodyText,
                        )
                      : Container(
                          height: 100,
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
                        hintText: 'Name...',
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location',
                        style: kBodyText,
                      ),
                      TextFormField(
                        controller: locationController,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Location...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                location(context, locationController);
                              },
                            )),
                        readOnly: false,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Number',
                        style: kBodyText,
                      ),
                      TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Number..."),
                        validator: Validator.requiredValidator,
                      ),
                    ],
                  ),

                  CustomAddButton(
                    name: "Add",
                    onPressed: () {
                      String name = nameController.text.trim();
                      String location = locationController.text.trim();
                      String number = numberController.text.trim();
                      if (name.isNotEmpty &&
                          location.isNotEmpty &&
                          number.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          locationController.text = '';
                          numberController.text = '';
                          addstaff.add(AddStaff(
                              name: name, location: location, number: number));
                        });
                      }
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
                TextField(
                  controller: locationController,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Location...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          location(context, locationController);
                        },
                      )),
                  readOnly: true,
                ),
                Text("Select Ward:", style: kHeadline),
                TextField(
                  controller: wardnoController,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Wardno...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          wardno(context, locationController);
                        },
                      )),
                  readOnly: true,
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
