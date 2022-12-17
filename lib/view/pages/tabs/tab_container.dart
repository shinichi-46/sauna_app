import 'package:flutter/material.dart';
import 'package:sauna_app/view/pages/tabs/calendar_page.dart';
import 'package:sauna_app/view/pages/tabs/timeline_page.dart';

class TabContainer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _TabContainer();
}

class _TabContainer extends State<TabContainer> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    CalenderPage(),
    TimeLinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: SaunaColor.primary,
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
            iconSize: 20,
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.flag),
                label: 'カレンダー',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_list_numbered_sharp),
                label: 'タイムライン',
              ),
            ],
            // backgroundColor: SaunaColor.primary,
            // selectedItemColor: SaunaColor.tabSelectedText,
            // unselectedItemColor: SaunaColor.tabText,
          ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}