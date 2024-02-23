import 'package:finalyear/components/constants.dart';
import 'package:finalyear/screens/adminside/admindashboard/widgets/activeuser_widget.dart';
import 'package:finalyear/screens/adminside/admindashboard/widgets/buildchart.dart';
import 'package:finalyear/screens/adminside/admindashboard/widgets/dustbinnumber.dart';
import 'package:finalyear/widgets/appbarwithdrawer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarWithDrawer(
      title: 'ADMIN',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "DASHBOARD",
                style: kBodyText2.copyWith(color: const Color(0xFF365307)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(height: 200, child: buildChart()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: ResponsiveGridList(
                    horizontalGridSpacing: 10,
                    verticalGridSpacing: 15,
                    verticalGridMargin: 10,
                    minItemWidth: 10,
                    minItemsPerRow: 2,
                    maxItemsPerRow: 2,
                    listViewBuilderOptions: ListViewBuilderOptions(),
                    children: [
                      builddustbinbox(title: 'Full Dustbin', onPressed: () {}),
                      builddustbinbox(title: 'Half Dustbin', onPressed: () {}),
                      builddustbinbox(title: 'Empty Dustbin', onPressed: () {}),
                      builddustbinbox(title: 'Damage Dustbin', onPressed: () {})
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20), // Adjust the value as needed
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("STAFFS"),
                      ],
                    ),
                    buildActiveUsersWidget("ACTIVE USERS", 10),
                    const SizedBox(
                      height: 12,
                    ),
                    buildActiveUsersWidget("ACTIVE USERS", 10),
                    const SizedBox(
                      height: 12,
                    ),
                    buildActiveUsersWidget("INACTIVE USERS", 10),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DustbinData {
  String year;
  int y;
  int y1;
  int y2;

  DustbinData(
    this.year,
    this.y,
    this.y1,
    this.y2,
  );
}

dynamic getColumnData() {
  List<DustbinData> columnData = <DustbinData>[
    DustbinData(
      '2023-12-14',
      20,
      50,
      100,
    ),
    DustbinData(
      "2023-12-15",
      30,
      20,
      80,
    ),
    DustbinData(
      "2023-12-16",
      40,
      10,
      30,
    ),
    DustbinData(
      "2023-12-20",
      50,
      20,
      30,
    )
  ];
  return columnData;
}
