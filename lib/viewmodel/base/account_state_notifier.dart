import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/viewmodel/model/accout_model.dart';

//Todo: Providerの宣言(riverpod)
final accountNotifierProvider =
    StateNotifierProvider<AccountStateNotifier, Account>(
  (ref) => AccountStateNotifier(),
);

//Todo: StateNotifierを継承したクラスを作成(riverpod)
class AccountStateNotifier extends StateNotifier<Account> {
  // `super([])` で、空のTODOリストを初期値として入れている。
  AccountStateNotifier()
      : super(Account(
            id: '', userName: '', favoritePlaceList: [], iconImagePath: ''));

  void logOut() {
    state =
        Account(id: '', userName: '', favoritePlaceList: [], iconImagePath: '');
  }

  /// 新しいTODOを追加するメソッド
  Future<bool> canFetch({String? uid}) async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('user');
    DocumentSnapshot<Object?> doc = await collection.doc(uid).get();
    if (doc.exists) {
      state = Account(
          id: doc.id,
          userName: doc.get('user_name'),
          favoritePlaceList:
              doc.get('favorite_place_list').cast<String?>() ?? [],
          iconImagePath: doc.get('icon_image_path'));
      return true;
    } else {
      return false;
    }
  }

  Future<void> post({String? uid, String? userName}) async {
    try {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection('user');
      await collection.doc(uid).set({
        'id': uid,
        'user_name': userName,
        'favorite_place_list': [],
        'icon_image_path': '',
      });
      state = Account(
          id: uid!,
          userName: userName!,
          favoritePlaceList: null,
          iconImagePath: null);
    } catch (err) {
      print('error');
    }
  }

  Future<void> update(
      {String? newUserName,
      String? imagePath,
      String? newFavoritePlace}) async {
    try {
      if (newUserName != null && newUserName != state.userName) {
        print('1');
        state = Account(
            id: state.id,
            userName: newUserName,
            favoritePlaceList: state.favoritePlaceList,
            iconImagePath: state.iconImagePath); //viewmodel②の部分
      }
      if (imagePath != null && imagePath != '') {
        state = Account(
            id: state.id,
            userName: state.userName,
            favoritePlaceList: state.favoritePlaceList,
            iconImagePath: imagePath);
      }
      if (newFavoritePlace != null) {
        List<String?> list = state.favoritePlaceList!;
        list.add(newFavoritePlace);
        state = Account(
          id: state.id,
          userName: state.userName,
          favoritePlaceList: list,
          iconImagePath: state.iconImagePath,
        );
      }
      if (newUserName != '' || imagePath != '' || newFavoritePlace != null) {
        FirebaseFirestore.instance.collection('user').doc(state.id).update({
          'user_name': state.userName,
          'icon_image_path': state.iconImagePath,
          'favorite_place_list': state.favoritePlaceList
        }); //repository③ の部分
      }
    } catch (err) {
      print(err);
      print('error');
    }
  }
}
