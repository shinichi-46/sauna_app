import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<String> menuItems = [
      'アカウント情報の設定',
      '利用規約',
      'プライバシーポリシー',
      'ライセンス'
    ];

    final List<String> menuPages = [
      SaunaPage.AGAIN_EDIT_ACCOUNT.screenName,
      'https://harumich.github.io/Privacy_Policy_TurtleTask/terms_of_service',
      'https://harumich.github.io/Privacy_Policy_TurtleTask/privacy_policy',
      SaunaPage.LICENSE.screenName
    ];

    return SizedBox(
      width: 280,
      child: Drawer(
          child:Scaffold(
              appBar: AppBar(
                title: const Text(''),
                centerTitle: true,
                // backgroundColor: SaunaPage.primary,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              body: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (index == 1 || index == 2) {
                        /*
                        launchUrl(
                          Uri.parse(menuPages[index]),
                        );
                         */
                      } else {
                        Navigator.pushNamed(
                          context,
                          menuPages[index],
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      menuItems[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.navigate_next,
                                  size: 40,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1),
                      ],
                    ),
                  );
                },
              )
          )
      ),
    );
  }
}
