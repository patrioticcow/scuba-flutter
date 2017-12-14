import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          const DrawerHeader(child: const Center(child: const Text('Scuba'))),
          const ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text('Stock List'),
            selected: true,
          ),
          const ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Account Balance'),
            enabled: false,
          ),
          new ListTile(
            leading: const Icon(Icons.dvr),
            title: const Text('Dump App to Console'),
            onTap: () {

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
