import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_losses/utils/firebase_notification_handler.dart';

import 'add_object.dart';
import 'my_objects.dart';
import 'profile_screen.dart';
import 'screen.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final navigatorKey = GlobalKey<NavigatorState>();

@override
void initState() {
  super.initState();
  new FirebaseNotifications().setUpFirebase();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  
    IndexedStack(

          index: currentIndex,
          children: <Widget>[
            AddObjectScreen(),
            MyObjects(),
       //     ProfileScreen(),
            Neumorphism()
            // Navigator(
            //   key: navigatorKey,
            //   onGenerateRoute: (route) =>
            //       SlideRightRoute(widget: CatalogScreen()),
            // ),
            // Navigator(
            //   key: navigatorKey,
            //   onGenerateRoute: (route) =>
            //       SlideRightRoute(widget: FavoriteItems()),
            // ),
           
            // Settings(),
          ],
        ),
         bottomNavigationBar: 
         BottomNavyBar(
          selectedIndex: currentIndex,
          showElevation: true, 
          onItemSelected: (index) => setState(() {
         
          
            currentIndex = index;
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Главная'),
              activeColor: Colors.blue,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.library_books),
                title: Text('Мои вещи'),
                activeColor: Colors.blue),
            // BottomNavyBarItem(
            //     icon: Icon(Icons.chat),
            //     title: Text('Чат'),
            //     activeColor: Colors.blue),
                 BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Профиль'),
                activeColor: Colors.blue)
          ],
        )
    
    );
  }
}
