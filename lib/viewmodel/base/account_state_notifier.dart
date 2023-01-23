import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/viewmodel/model/accout_model.dart';

final accountNotifierProvider =
StateNotifierProvider<AccountStateNotifier, Account>(
      (ref) => AccountStateNotifier(),
);

class AccountStateNotifier extends StateNotifier<Account> {
  // `super([])` で、空のTODOリストを初期値として入れている。
  AccountStateNotifier(): super(Account(id: '', userName: '', favoritePlaceList: [], iconImagePath: ''));

  /// 新しいTODOを追加するメソッド
  Future<bool>  canFetch({String? uid}) async {
    final CollectionReference collection = FirebaseFirestore.instance.collection('user');
    DocumentSnapshot<Object?> doc = await collection.doc(uid).get();
    if (doc.exists) {
      state = Account(id: doc.id, userName: doc.get('user_name'), favoritePlaceList: doc.get('favorite_place_list'), iconImagePath: doc.get('icon_image_path'));
      return true;
    } else {
      return false;
    }
  }
  Future<void>  post({String? uid,String? userName}) async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('user');
      await collection.doc(uid).set({
        'id': uid,
        'user_name': userName,
        'favorite_place_list': null,
        'icon_image_path': null,
      });
      state = Account(id: uid!, userName: userName!, favoritePlaceList: null, iconImagePath: null);
    } catch (err) {
      print('error');
    }
  }
}


