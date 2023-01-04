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
        return 'sauna_app-page-00';
      case SaunaPage.LOGIN:
        return 'sauna_app-page-01';
      case SaunaPage.FIRST_EDIT_ACCOUNT:
        return 'sauna_app-page-02';
      case SaunaPage.AGAIN_EDIT_ACCOUNT:
        return 'sauna_app-page-03';
      case SaunaPage.CREATE_POST:
        return 'sauna_app-page-04';
      case SaunaPage.UPDATE_POST:
        return 'sauna_app-page-05';
      case SaunaPage.LICENSE:
        return 'sauna_app-page-06';
    }
  }
}