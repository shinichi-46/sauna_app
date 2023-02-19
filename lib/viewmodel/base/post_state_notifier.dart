import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/viewmodel/model/post_model.dart';

//Todo: Providerの宣言(riverpod)
final postNotifierProvider =
StateNotifierProvider<PostStateNotifier, List<Post>>(
      (ref) => PostStateNotifier(),
);


//Todo: StateNotifierを継承したクラスを作成(riverpod)
class PostStateNotifier extends StateNotifier<List<Post>> {
  // `super([])` で、空のTODOリストを初期値として入れている。
  PostStateNotifier() : super([]);

  void logOut() {
    state = [];
  }

  Future<void> create(
      {required String placeName, String? memo, required int evaluationStatus, List<
          String>? imagePathList, required String creatorId, required String creatorName, required DateTime visitedDate, required DateTime createdDate, required DateTime updateDate}) async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('post');
      await collection.doc().set({
        'placeName': placeName,
        'memo': memo,
        'evaluationStatus': evaluationStatus,
        'imagePathList': imagePathList,
        'creatorId': creatorId,
        'creatorName': creatorName,
        'visitedDate': '${visitedDate.year}/${visitedDate.month}/${visitedDate.day}',
        'createdDate': createdDate,
        'updateDate': updateDate,
      });
    } catch (err) {
      print('error');
    }
  }

  Future<void> fetch({String? creatorId, DateTime? visitedDate}) async {
    try {
      late QuerySnapshot snapshot;
      final CollectionReference collection = FirebaseFirestore.instance.collection('post');
      if (creatorId == null || visitedDate == null) {
        snapshot = await collection.orderBy('createdDate', descending: true).get();//タイムラインの投稿順を投稿日の新しい順にソートしている。
      } else {
        snapshot = await collection.where('creatorId', isEqualTo: creatorId).where('visitedDate', isEqualTo: '${visitedDate.year}/${visitedDate.month}/${visitedDate.day}').orderBy('createdDate', descending: true).get();//カレンダーの投稿順を投稿日の新しい順にソートしている。
      }
      List<Post> postList = [];
      for (var doc in snapshot.docs) {
        postList.add(Post(
            id: doc.id,
            placeName: doc.get('placeName'),
            memo: doc.get('memo'),
            evaluationStatus: doc.get('evaluationStatus'),
            imagePathList: doc.get('imagePathList').cast<String>() ?? [],
            creatorId: doc.get('creatorId'),
            creatorName: doc.get('creatorName'),
            visitedDate: doc.get('visitedDate'),
            createdDate: doc.get('createdDate').toDate(),
            updateDate: doc.get('updateDate').toDate(),
        ));
      }
      state = postList;
    } catch (err) {
      print(err);
      print('error');
    }
  }
}