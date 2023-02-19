class Post {
  String id;
  String placeName;
  String? memo;
  int evaluationStatus;
  List<String>? imagePathList;
  String creatorId;
  String creatorName;
  DateTime visitedDate;
  DateTime createdDate;
  DateTime updateDate;

  Post({
    required this.id,
    required this.placeName,
    this.memo,
    required this.evaluationStatus,
    this.imagePathList,
    required this.creatorId,
    required this.creatorName,
    required this.visitedDate,
    required this.createdDate,
    required this.updateDate,
  });
}
