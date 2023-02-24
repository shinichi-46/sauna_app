import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sauna_app/viewmodel/base/account_state_notifier.dart';
import 'package:sauna_app/viewmodel/base/post_state_notifier.dart';


class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({Key? key, required this.selectedDate}) : super(key: key);
  final DateTime selectedDate;

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {

  final _placeNameController = TextEditingController();
  int? evaluationStatus;
  bool _flag = false;
  bool canNotPressed = false;
  String memo = '';


  final ImagePicker _picker = ImagePicker();
  List<File> images = [];
  List<String> imagePathList = [];


  Future<void> uploadImage() async{
    for (File image in images){
      String path = image.path.substring(image.path.lastIndexOf('/') + 1);
      final ref = FirebaseStorage.instance.ref(path);
      final storedImage = await ref.putData(image.readAsBytesSync());
      String imagePath = await storedImage.ref.getDownloadURL();
      imagePathList.add(imagePath);
      setState(() {});//FireBaseストレージに登録
    }
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return Focus(
        focusNode: focusNode,
        child: GestureDetector(
        onTap: focusNode.requestFocus,
          child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red[900],
          ),
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10,top: 10),
                      child: Text(
                        '記録',
                        style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(
                      height: 1,
                      thickness: 0.2,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black,
                    ),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10,),
                          child: Text(
                            '日時',
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10,),
                          child: Text(
                            '${widget.selectedDate.year}年${widget.selectedDate.month}月${widget.selectedDate.day}日',
                            style: const TextStyle(fontSize: 15,)
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.2,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                        '評価',
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 30, bottom: 10, left: 30),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right:  70, bottom: 10, left: 0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  evaluationStatus = 0;
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: evaluationStatus == 0 ? Colors.blue : Colors.grey,
                                  size: 70,
                                ),
                              ),
                              const Text(
                                  '良い'
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 70, bottom: 10, left: 0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap:() {
                                  evaluationStatus = 1;
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.sentiment_neutral,
                                  color: evaluationStatus == 1 ? Colors.yellow : Colors.grey,
                                  size: 70,
                                ),
                              ),
                              const Text(
                                  '普通'
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 0, bottom: 10, left: 0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap:() {
                                  evaluationStatus = 2;
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: evaluationStatus == 2 ? Colors.red : Colors.grey,
                                  size: 70,
                                ),
                              ),
                              const Text(
                                  '悪い'
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.2,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          '施設名',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SizedBox(
                          width: 330,
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'サウナの施設名を入力',
                            ),
                            controller: _placeNameController,
                            onChanged: (text) {
                              if (ref.watch(accountNotifierProvider).favoritePlaceList!.contains(text)) {
                                canNotPressed = true;
                                _flag = false;
                              } else {
                                canNotPressed = false;
                                _placeNameController.text = text;
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                            '選択',
                          style: TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold, color: Colors.red[900],
                          ),),
                          onTapDown: (details) {
                            if (ref.watch(accountNotifierProvider).favoritePlaceList!.isEmpty) {
                              // 何もしない
                            } else {
                              final position = details.globalPosition;
                              showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                items: [
                                  for (int i = 0; i < ref.watch(accountNotifierProvider).favoritePlaceList!.length; i++)
                                    PopupMenuItem(
                                      value: i,
                                      child: Text(
                                        ref.watch(accountNotifierProvider).favoritePlaceList![i]!,
                                      ),
                                    )
                                ],
                                elevation: 8.0,
                              ).then((value) async {
                                _placeNameController.text = ref.watch(accountNotifierProvider).favoritePlaceList![value!]!;
                                canNotPressed = true;
                                _flag = false;
                                setState(() {});
                              });
                            }
                          }
                      ),
                    ],
                  ),
                  Container(
                    child: canNotPressed
                        ? Stack(
                          children: [
                            Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.red[900],
                                    value: _flag,
                                    onChanged: (bool? e) {
                                      _flag = e!;
                                      setState(() {});
                                    },// チェックボックスをタップした際のイベントハンドラ
                                  ),
                                  const Text('お気に入りに追加'),
                                ],
                              ),
                            Container(
                              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
                              height: 40,
                            ),
                          ],
                        )
                        : Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.red[900],
                                value: _flag,
                                onChanged: (bool? e) {
                                  _flag = e!;
                                  setState(() {});
                                },// チェックボックスをタップした際のイベントハンドラ
                              ),
                              const Text('お気に入りに追加'),
                            ],
                          )
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.2,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'メモ',
                      style: const TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      autofocus: true,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(border: const OutlineInputBorder()),
                      onChanged: (text) {
                        memo = text;
                        setState(() {});
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.2,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '写真',
                      style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold,
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () async {
                        List<XFile>? xFiles = await _picker.pickMultiImage();//写真が複数選択できるようになる
                        if(xFiles.isNotEmpty) {
                          images = [];//２回目以降写真を追加した時、前回に追加した写真が消えるようになっている。
                          for (var xFile in xFiles) {images.add(File(xFile.path));}
                          setState(() {});//ontap以下写真が選択されている時の処理。
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.collections,
                            size: 30,
                            color: Colors.red[900],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              '写真を選択',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: images.isNotEmpty,
                    child: Container(
                      height: 200,
                      child: ListView.builder( scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showGeneralDialog(
                                      transitionDuration: const Duration(milliseconds: 1000),
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
                                                      child: Image.file(images[index]),
                                                      ),
                                                    ),
                                                  )
                                            ),
                                            ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                      height: 200,width: 200,
                                      child: Image.file(images[index], fit: BoxFit.fill),
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  images.removeAt(index);
                                  setState(() {});//imagesがstatefulwidgetで管理されているため状態を保存するためにsetStateをつけなければならない
                                  }, icon: Icon(
                                  Icons.remove_circle,
                                  size: 35,
                                  color: Colors.red.withOpacity(0.7),
                                ),),
                              ],
                            );
                          }
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.2,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black,
                  ),
                  Center(
                    child: OutlinedButton(
                        onPressed: () async {
                          if (evaluationStatus == null) {
                            // バリデーションチェック
                            showDialog<void>(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('評価が未選択です。'),
                                    actions: <Widget>[
                                      GestureDetector(
                                        child: const Text('戻る', style: const TextStyle(fontSize: 18),),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                }
                            );
                          } else if (_placeNameController.text == '') {
                            // バリデーションチェック
                            showDialog<void>(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('施設名が未入力です。'),
                                    actions: <Widget>[
                                      GestureDetector(
                                        child: const Text('戻る', style: const TextStyle(fontSize: 18),),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                }
                            );
                          } else {
                            //Todo:ローディング　お気に入り施設登録
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return Center(
                                  // Default Indicator.
                                  child: CircularProgressIndicator(color: Colors.red[900]),
                                );
                              },
                            );
                            try {
                              // Storageに写真を登録
                              await uploadImage();
                              // FireStoreに登録する
                              ref.read(postNotifierProvider.notifier).create(
                                  placeName: _placeNameController.text,
                                  memo: memo,
                                  evaluationStatus: evaluationStatus!,
                                  imagePathList: imagePathList,
                                  creatorId: ref
                                      .watch(accountNotifierProvider)
                                      .id,
                                  creatorName: ref
                                      .watch(accountNotifierProvider)
                                      .userName,
                                  creatorIconImagePath: ref
                                      .watch(accountNotifierProvider)
                                      .iconImagePath!,
                                  visitedDate: widget.selectedDate,
                                  createdDate: DateTime.now(),
                                  updateDate: DateTime.now());
                              // お気に入りに追加にチェックがあったら、FireStoreのアカウントに施設名を反映させる
                              if (_flag) {
                                await ref.read(accountNotifierProvider.notifier)
                                    .update(
                                    newFavoritePlace: _placeNameController
                                        .text);
                                await ref.read(accountNotifierProvider.notifier)
                                    .canFetch(uid: ref
                                    .watch(accountNotifierProvider)
                                    .id);
                              }
                              // 前の画面に戻る//??は前のものがnullだったら後の値を入れるという意味
                              Navigator.pop(context);
                            } finally {
                              // Dismiss the indicator.
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text('記録する')
                    ),
                  ),
                ],
              ),
          ),
      ),
    )
    );
  }
}
