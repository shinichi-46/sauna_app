import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/view/widgets/custom_drawer_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {

  late DateTime _focused;
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _focused = DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          endDrawer: const CustomDrawer(),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'カレンダー',
                  style: TextStyle(fontSize: 30),
                ),
                Center(
                  child: TableCalendar(
                    firstDay: DateTime.utc(2022, 4, 1),
                    lastDay: DateTime.utc(2025, 12, 31),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selected, day);
                    },
                    onDaySelected: (selected, focused) {
                      if (!isSameDay(_selected, selected)) {
                        setState(() {
                          _selected = selected;
                          _focused = focused;
                        });
                      }
                    },
                    focusedDay: _focused,

                  ),
                ),
                const Text(
                  'CalenderPage',
                  style: TextStyle(fontSize: 50),
                ),
                const Text(
                  'ごきげんよう！',
                  style: TextStyle(fontSize: 20),
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SaunaPage.CREATE_POST.screenName,
                      );
                    },
                    child: const Text('サウナ記録の登録画面に遷移する')
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SaunaPage.UPDATE_POST.screenName,
                      );
                    },
                    child: const Text('サウナ記録の更新画面に遷移する')
                ),
              ],
            ),
          )
      ),
    );
  }
}



