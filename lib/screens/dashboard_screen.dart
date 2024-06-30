import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: FutureBuilder<String>(
          future: getUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error loading username');
            } else {
              String greeting = 'Good ';
              int hour = DateTime.now().hour;
              if (hour < 12) {
                greeting += 'Morning';
              } else if (hour < 17) {
                greeting += 'Afternoon';
              } else {
                greeting += 'Evening';
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('$greeting, ${snapshot.data}!'),
                  const SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      title: const Text('Humidity'),
                      subtitle: const Text('50%'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Temperature'),
                      subtitle: const Text('22°C'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Wind Pressure'),
                      subtitle: const Text('15 km/h'),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.deepPurple,
      ),
    );
  }
}
