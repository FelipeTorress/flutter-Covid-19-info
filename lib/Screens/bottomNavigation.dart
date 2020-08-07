import 'package:covidapp/Screens/homeScreen.dart';
import 'package:covidapp/Screens/info_screen.dart';
import 'package:covidapp/Screens/statistic_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List _screens = [
    HomeScreen(),
    StatisticScreen(),
    InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index)=>setState(()=>_currentIndex  = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          elevation:0.0,
          currentIndex: _currentIndex,
          items: [Icons.home, Icons.insert_chart, Icons.info]
              .asMap()
              .map((key, value) =>
              MapEntry(
                  key,
                  BottomNavigationBarItem(
                    title: Text(''),
                    icon:
                    Container(
                      child: Icon(value),
                      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: _currentIndex == key ? Colors.purple : Colors
                            .transparent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                    ),
                  )
              )).values.toList()
      ),
    );
  }
}

