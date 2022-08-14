import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../providers/dark_theme_provider.dart';
import '../providers/cart_provider.dart';
import 'widgets/text_widget.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  static Page page()=> const MaterialPage<void>(child: BottomBarScreen());
  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {
      'page':  Test(),
      'title': 'Home Screen',
    },
    {
      'page': Test(),
      'title': 'Categories Screen',
    },
    {
      'page':  Test(),
      'title': 'Cart Screen',
    },
    {
      'page':  Test(),
      'title': 'user Screen',
    },
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: _isDark ? Colors.white10 : Colors.black12,
        selectedItemColor: _isDark ? Colors.lightBlue.shade200 : Colors.black87,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? IconlyBold.category
                : IconlyLight.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartProvider>(builder: (_, myCart, ch) {
              return Badge(
                  toAnimate: true,
                  shape: BadgeShape.circle,
                  badgeColor: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                  position: BadgePosition.topEnd(top: -7, end: -7),
                  badgeContent: FittedBox(
                      child: TextWidget(
                          text: myCart.getCartItems.length.toString(),
                          color: Colors.white,
                          textSize: 15)),
                  child: Icon(
                      _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),);
            }),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
            label: "User",
          ),
        ],
      ),
    );
  }
}

class Test extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello Test" , style: TextStyle(fontSize:50, color:Colors.red),),
      ),
    );
  }
}
