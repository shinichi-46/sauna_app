import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/view/widgets/custom_drawer_widget.dart';
import 'package:sauna_app/viewmodel/base/post_state_notifier.dart';

class TimeLinePage extends ConsumerStatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
ConsumerState<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends ConsumerState<TimeLinePage> {
//Consumerをつけることでriverpodでも対応できるようになる

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // String creatorId = ref.watch(accountNotifierProvider).id;
    ref.read(postNotifierProvider.notifier).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text ('タイムライン'),
          automaticallyImplyLeading: false,
        ),
        endDrawer: const CustomDrawer(),
        body: ref.watch(postNotifierProvider).isEmpty
        ? Text('loading')
        : ListView.builder(
            itemCount: ref.watch(postNotifierProvider).length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Visibility(
                    visible: index != 0,
                    child: const Divider(
                      height: 1,
                      thickness: 0.2,
                      indent: 0,
                      endIndent: 0,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${ref.watch(postNotifierProvider)[index].createdDate.year}/${ref.watch(postNotifierProvider)[index].createdDate.month}/${ref.watch(postNotifierProvider)[index].createdDate.day}　${ref.watch(postNotifierProvider)[index].createdDate.hour}：${ref.watch(postNotifierProvider)[index].createdDate.minute}',),
                            ],
                          ),
                          Text(ref.watch(postNotifierProvider)[index].creatorName),
                          evaluationWidget(ref.watch(postNotifierProvider)[index].evaluationStatus),
                          Text(ref.watch(postNotifierProvider)[index].placeName),
                          Visibility(
                            visible: ref.watch(postNotifierProvider)[index].imagePathList!.isNotEmpty,
                            child: Container(
                              height: 200,
                              child: ListView.builder( scrollDirection: Axis.horizontal,
                                itemCount: ref.watch(postNotifierProvider)[index].imagePathList!.length,
                                itemBuilder: (context, i) {
                                  return GestureDetector(
                                    onTap: () {
                                      showGeneralDialog(
                                        transitionDuration: Duration(milliseconds: 1000),
                                        barrierDismissible: true,
                                        barrierLabel: '',
                                        context: context,
                                        pageBuilder: (context, animation1, animation2) {
                                          return DefaultTextStyle(
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1!,
                                            child: Center(
                                              child: Container(
                                                child: SingleChildScrollView(
                                                    child: InteractiveViewer(
                                                      minScale: 0.1,
                                                      maxScale: 5,
                                                      child: Container(
                                                        child: Image.network(ref.watch(postNotifierProvider)[index].imagePathList![i]
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                        height: 200,width: 200,
                                        child: Image.network(ref.watch(postNotifierProvider)[index].imagePathList![i], fit: BoxFit.fill,)
                                ),
                                  );
                              }
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                ],
              );
            },
          ),
    );
  }//buildの中には関数は書いていけない。バグが起きる可能性があるため。
  //↓　Widgetの部分は使いたいデータ型で表す。今回の場合、Rowに適応させたいためWidget型で表している。極論Widgetの部分をRowと書いても問題ない。企業ではWidget型と書くことが多い。
  Widget evaluationWidget(int evaluationStatus) {//evaluationWidgetは自分で決めた名前で良い。データ型、関数名、引数の形で表す。
    switch(evaluationStatus){
      case 0:
        return  Row(
          children: [
            Icon(
              Icons.sentiment_very_satisfied,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('良い'),
            )
          ],
        );
      case 1:
        return  Row(
          children: [
            Icon(
              Icons.sentiment_neutral,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('普通'),
            )
          ],
        );
      case 2:
        return  Row(
          children: [
            Icon(
              Icons.sentiment_very_dissatisfied,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('悪い'),
            )
          ],
        );
      default:
        return  Row(
          children: [
            Icon(
              Icons.sentiment_neutral,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('普通'),
            )
          ],
        );
    }
  }
}
