import 'package:events_app/widgets/customtext.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            // currentAccountPicture: Image.asset(
            //   'images/1.jpg',
            // ),
            accountEmail: CustomText(
              text: "Huzaifashakeel778@gmail.com",
              color: Colors.white,
              size: 16,
            ),
            accountName:
                CustomText(text: "Huzaifa", color: Colors.white, size: 20),
          ),
          ListTile(
            title: Text(
              "Home",
              style: TextStyle(fontSize: 20),
            ),
            leading: Icon(
              Icons.home,
              size: 35,
            ),
            onTap: () => {},
          ),
          ListTile(
            title: Text(
              "Food I like",
              style: TextStyle(fontSize: 20),
            ),
            leading: Icon(
              Icons.food_bank_outlined,
              size: 35,
            ),
            onTap: () => {},
          ),
          ListTile(
            title: Text(
              "Cart",
              style: TextStyle(fontSize: 20),
            ),
            leading: Icon(
              Icons.shopping_cart,
              size: 35,
            ),
            onTap: () => {},
          ),
          ListTile(
            title: Text(
              "My orders",
              style: TextStyle(fontSize: 20),
            ),
            leading: Icon(
              Icons.bookmark_border,
              size: 35,
            ),
            onTap: () => {},
          ),
          ListTile(
            title: Text(
              "Settings",
              style: TextStyle(fontSize: 20),
            ),
            leading: Icon(
              Icons.settings,
              size: 35,
            ),
            onTap: () => {},
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.exit_to_app,
              size: 35,
            ),
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
