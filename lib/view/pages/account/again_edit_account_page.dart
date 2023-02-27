import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sauna_app/viewmodel/base/account_state_notifier.dart';

// Todo: reiverpodを使うため、ConsumerWidgetまたはConsumerStatefulWidgetに変更する(riverpod)
class AgainEditAccountPage extends ConsumerStatefulWidget {
  const AgainEditAccountPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AgainEditAccountPage> createState() =>
      _AgainEditAccountPageState();
}

class _AgainEditAccountPageState extends ConsumerState<AgainEditAccountPage> {
  final _userNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Todo: Widgetで使用する(riverpod)
    _userNameController.text = ref.watch(accountNotifierProvider).userName;
  }

  File? image;
  String imagePath = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage() async {
    PickedFile? pickedImage =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      image = File(pickedImage.path);
    }); //写真を選んでいるだけの処理
  }

  Future<void> uploadImage() async {
    String path = image!.path.substring(image!.path.lastIndexOf('/') + 1);
    final ref = FirebaseStorage.instance.ref(path);
    final storedImage = await ref.putData(image!.readAsBytesSync());
    imagePath = await storedImage.ref.getDownloadURL();
    setState(() {}); //FireBaseストレージに登録
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        leading: BackButton(
          onPressed: () async {
            // Todo: ローディング 前mのページに戻った時にユーザー名やトプ画が変更される処理
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  // Default Indicator.
                  child: CircularProgressIndicator(color: Colors.red[900]),
                );
              },
            );
            try {
              if (image != null) {
                await uploadImage();
              }
              await ref.read(accountNotifierProvider.notifier).update(
                  newUserName: _userNameController.text, imagePath: imagePath);
            } finally {
              // Dismiss the indicator.
              Navigator.pop(context);
              Navigator.pop(context); //前のページに戻る
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () async {
                    await selectImage();
                  },
                  child: image == null
                      ? ref.watch(accountNotifierProvider).iconImagePath ==
                                  '' ||
                              ref
                                      .watch(accountNotifierProvider)
                                      .iconImagePath ==
                                  null
                          ? Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.add_a_photo, size: 50),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(ref
                                  .watch(accountNotifierProvider)
                                  .iconImagePath!))
                      : CircleAvatar(
                          radius: 50, backgroundImage: FileImage(image!))),
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
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
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
                    overflow: TextOverflow.clip,
                    'お気に入り施設',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              for (int index = 1;
                  index <
                      ref
                              .watch(accountNotifierProvider)
                              .favoritePlaceList!
                              .length +
                          1;
                  index++)
                Row(
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
                    SizedBox(
                        width: 200,
                        child: Text(
                          '${ref.watch(accountNotifierProvider).favoritePlaceList![index - 1]}',
                          overflow: TextOverflow.clip,
                        )),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
