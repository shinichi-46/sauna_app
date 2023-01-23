import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/viewmodel/base/account_state_notifier.dart';

class AgainEditAccountPage extends ConsumerStatefulWidget {
  const AgainEditAccountPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AgainEditAccountPage> createState() => _AgainEditAccountPageState();
}

class _AgainEditAccountPageState extends ConsumerState<AgainEditAccountPage> {

  final _userNameController = TextEditingController();

  List<String> _testSaunaPlaceList = ['テルマー湯','サウナ北欧','ジートピア','かるまる','黄金湯','浅草橋NETU'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userNameController.text = ref.watch(accountNotifierProvider).userName;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
          ),
          body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     GestureDetector(
                       onTap: () {
                         print('unnko');
                       },
                       child: Container(
                         height: 100,
                         width: 100,
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.black),
                           shape: BoxShape.circle,
                         ),
                            child: Icon(
                              Icons.add_a_photo,
                              size: 50,
                            ),
                       ),
                     ),
                  Container(
                    height: 70,
                    child: Center(
                      child: Text(
                        'ユーザー名',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                      child: TextField(
                        controller: _userNameController,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'お気に入り施設',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  for (int index = 1 ; index<_testSaunaPlaceList.length+1; index++) Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Center(child: Text('${index.toString()}')),
                          height: 30,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Text('${_testSaunaPlaceList[index-1]}'),
                    ],
                  )
                ],
              ),
          ),
      ),
    );
  }
}