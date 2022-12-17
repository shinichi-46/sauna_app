enum SaunaPage {
  TAB,
  LOGIN,
  FIRST_EDIT_ACCOUNT,
  AGAIN_EDIT_ACCOUNT,
  CREATE_POST,
  UPDATE_POST,
  LICENSE,
}

extension SaunaPageExtension on SaunaPage {
  String get screenName {
    switch (this) {
      case SaunaPage.TAB:
        return 'sauna-app-page-00';
      case SaunaPage.LOGIN:
        return 'sauna-app-page-01';
      case SaunaPage.FIRST_EDIT_ACCOUNT:
        return 'sauna-app-page-02';
      case SaunaPage.AGAIN_EDIT_ACCOUNT:
        return 'sauna-app-page-03';
      case SaunaPage.CREATE_POST:
        return 'sauna-app-page-04';
      case SaunaPage.UPDATE_POST:
        return 'sauna-app-page-05';
      case SaunaPage.LICENSE:
        return 'sauna-app-page-06';
    }
  }
}