import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/adminside/admindashboard/widgets/activeuser_widget.dart';
import 'package:finalyear/presentation/screens/adminside/admindashboard/widgets/buildchart.dart';
import 'package:finalyear/presentation/screens/adminside/admindashboard/widgets/dustbinnumber.dart';
import 'package:finalyear/widgets/appbarwithdrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "DASHBOARD",
                  style: kBodyText2.copyWith(
                      color: const Color(0xFF365307), letterSpacing: 1),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: SizedBox(height: 180.h, child: buildChart()),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              child: SizedBox(
                height: 150.h,
                width: double.infinity,
                child: ResponsiveGridList(
                    horizontalGridSpacing: 10.w,
                    verticalGridSpacing: 10.h,
                    verticalGridMargin: 10.w,
                    minItemWidth: 10.w,
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
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 5.h),
              child: Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20.r), // Adjust the value as needed
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Text(
                            "STAFFS",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    buildActiveUsersWidget("ACTIVE USERS", 10),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    buildActiveUsersWidget("ACTIVE USERS", 10),
                    // const SizedBox(
                    //   height: 12,
                    // ),
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
