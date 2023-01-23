class Account {
  String id;
  String userName;
  List<String>? favoritePlaceList;
  String? iconImagePath;

  Account({
    required this.id,
    required this.userName,
    this.favoritePlaceList,
    this.iconImagePath
});
}
