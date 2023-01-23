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
      print(state.id);
      print(state.userName);
      print(state.favoritePlaceList);
      print(state.iconImagePath);
      return true;
    } else {
      return false;
    }
  }
}