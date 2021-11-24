import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  final String? nameApp;
  final String? description;

  const DrawerComponent({Key? key, this.nameApp, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerDrawer = DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text('$nameApp',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
    
  
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          headerDrawer,
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Favoritos'),
            onTap: () {
              // Navigator.of(context).push(
              //       MaterialPageRoute(builder: (context) => Favourites()));
              // }),
            },
          )
        ],
      ),
    );
  }
}
