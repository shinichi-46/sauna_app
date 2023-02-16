import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/viewmodel/model/accout_model.dart';
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

  Future<void> create(
      {required String placeName, String? memo, required int evaluationStatus, List<
          String>? imagePathList, required String creatorId, required DateTime visitedDate, required DateTime createdDate, required DateTime updateDate}) async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('post');
      await collection.doc().set({
        'placeName': placeName,
        'memo': memo,
        'evaluationStatus': evaluationStatus,
        'imagePathList': imagePathList,
        'creatorId': creatorId,
        'visitedDate': visitedDate,
        'createdDate': createdDate,
        'updateDate': updateDate,
      });
    } catch (err) {
      print('error');
    }
  }

  Future<void> fetch({String? creatorId}) async {
    try {
      late QuerySnapshot snapshot;
      final CollectionReference collection = FirebaseFirestore.instance.collection('post');
      if (creatorId == null) {
        snapshot = await collection.get();
      } else {
        snapshot = await collection.where('creatorId', isEqualTo: creatorId).get();
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
            visitedDate: doc.get('visitedDate').toDate(),
            createdDate: doc.get('createdDate').toDate(),
            updateDate: doc.get('updateDate').toDate(),
        ));
      }
      state = postList;
    } catch (err) {
      print('error');
    }
  }
}