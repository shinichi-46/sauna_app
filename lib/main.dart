import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sauna_app/firebase_options/firebase_options_develop.dart'
    as develop;
import 'package:sauna_app/firebase_options/firebase_options_product.dart'
    as product;
import 'package:sauna_app/utils/environment_util.dart';
import 'package:sauna_app/view/app_component.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: getFirebaseOptions());
  //Todo: アプリのルートにProviderScopeを追加する(riverpod)
  initializeDateFormatting('ja')
      .then((_) => runApp(ProviderScope(child: const AppComponent())));
}

FirebaseOptions getFirebaseOptions() {
  switch (EnvironmentUtil.getBuildType()) {
    case BuildType.Develop:
      return develop.DefaultFirebaseOptions.currentPlatform;
    case BuildType.Product:
      return product.DefaultFirebaseOptions.currentPlatform;
    default:
      return develop.DefaultFirebaseOptions.currentPlatform;
  }
}
