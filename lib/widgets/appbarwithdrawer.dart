import 'package:finalyear/screens/hamdrawerpages/mapview/mapviewpage.dart';
import 'package:flutter/material.dart';

class AppBarWithDrawer extends StatefulWidget {
  final String title;
  final Widget body;
  const AppBarWithDrawer({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<AppBarWithDrawer> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppBarWithDrawer> {
  final listTextStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 62, 31, 0.9),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(138, 201, 38, 1),
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                        height: 0.04,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 25,
                    backgroundImage:
                        AssetImage('assets/images/google_logo.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width *
              0.8, // Adjust the width as needed

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drawer items
              const SizedBox(
                height: 100,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/Eco.png'), // Replace with your actual photo path
                  // Adjust the radius as needed
                ),
                title: const Text(
                  'SAFA SAHAR',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 62, 31, 2),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      scaffoldKey.currentState?.closeDrawer();
                    }),
              ),
              const SizedBox(
                height: 80,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.location_on),
                title: Text(
                  'Map View',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapViewPage()),
                  );
                  // Handle Home Click
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapViewPage()),
                  );
                  // Handle Home Click
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.group),
                title: Text(
                  'Users',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapViewPage()),
                  );
                  // Handle Home Click
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.delete_outline),
                title: Text(
                  'Dustbin',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapViewPage()),
                  );
                  // Handle Home Click
                },
              ),
              const Divider(
                color: Colors.green,
              ),
              ListTile(
                textColor: Colors.white,
                leading: const Icon(Icons.notifications),
                title: Text(
                  'Notifications',
                  style: listTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapViewPage()),
                  );
                  // Handle Home Click
                },
              ),
              const Divider(
                color: Colors.green,
              ),
            ],
          ),
        ),
        body: widget.body);
  }
}
