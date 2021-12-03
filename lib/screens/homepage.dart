import 'package:flutter/material.dart';
import 'package:shopping/screens/tabs/cart.dart';
import 'package:shopping/screens/tabs/favorite.dart';
import 'package:shopping/screens/tabs/home.dart';
import 'package:shopping/screens/tabs/profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var select = 0;
  final List<Widget> children = [
    const Home(),
    const Cart(),
    const Favorite(),
    const Profile()
  ];
  void selectindex(int index) {
    setState(() {
      select = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[select],
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectindex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          currentIndex: select,
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "Cart", icon: Icon(Icons.shopping_cart_outlined)),
            BottomNavigationBarItem(
                label: "Favorite", icon: Icon(Icons.favorite_border)),
            BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person))
          ]),
    );
  }
}
