import 'package:flutter/material.dart';
import 'package:myapp/screens/tests.dart';
import 'package:myapp/screens/home.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          const DrawerHeader(child: const Center(child: const Text('Scuba'))),
          new ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, HomePage.routeName);
            },
          ),
          new ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Tests'),
            onTap: () {
              Navigator.pushNamed(context, TestsPage.routeName);
            },
          ),
          new ListTile(
            leading: const Icon(Icons.dvr),
            title: const Text('Notebook'),
            onTap: () {
              Navigator.pushNamed(context, TestsPage.routeName);
            },
          ),
          const Divider(),
          new ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
          new ListTile(
            leading: const Icon(Icons.help),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
