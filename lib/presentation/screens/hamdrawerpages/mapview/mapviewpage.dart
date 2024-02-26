import 'package:finalyear/components/constants.dart';
import 'package:finalyear/presentation/screens/adminside/admindashboard/widgets/dustbinnumber.dart';
//import 'package:finalyear/googlemapapi/googlemap.dart';
import 'package:finalyear/widgets/appbarwithdrawer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
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
                "MAP VIEW",
                style: kBodyText2.copyWith(color: const Color(0xFF365307)),
              ),
            ),
            // Container(
            //     height: 400,
            //     width: 300,
            //     color: Colors.red,
            //     child: const MapPage())
            const SizedBox(
              height: 100,
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
          ],
        ),
      ),
      // Other widget content
    );
  }
}
