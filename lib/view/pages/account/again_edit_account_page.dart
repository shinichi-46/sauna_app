import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sauna_app/viewmodel/base/account_state_notifier.dart';

// Todo: reiverpodを使うため、ConsumerWidgetまたはConsumerStatefulWidgetに変更する(riverpod)
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
    //Todo: Widgetで使用する(riverpod)
    _userNameController.text = ref.watch(accountNotifierProvider).userName;
  }

  File? image;
  String imagePath = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage() async{
    PickedFile? pickedImage = await _picker. getImage(source:ImageSource.gallery);
    if(pickedImage == null) return;
    setState((){
      image = File(pickedImage.path);
    });
  }

  Future<void> uploadImage() async{
    String path = image!.path.substring(image!.path.lastIndexOf('/') + 1);
    final ref = FirebaseStorage.instance.ref(path);
    final storedImage = await ref.putData(image!.readAsBytesSync());
    imagePath = await storedImage.ref.getDownloadURL();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () async {
                if (image != null) {
                  await uploadImage();
                }
                await ref.read(accountNotifierProvider.notifier).update(newUserName: _userNameController.text,imagePath: imagePath);
                Navigator.pop(context);//前のページに戻る
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     GestureDetector(
                       onTap: () async {
                         await selectImage();
                       },
                       child: image == null
                           ? ref.watch(accountNotifierProvider).iconImagePath == '' ? Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add_a_photo,
                                size: 50),
                            ) : CircleAvatar(
                             radius: 50,
                             backgroundImage: NetworkImage(ref.watch(accountNotifierProvider).iconImagePath!))
                          : CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(image!))
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