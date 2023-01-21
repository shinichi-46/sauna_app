import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sauna_app/utils/environment_util.dart';
import 'package:sauna_app/view/app_component.dart';
import 'package:sauna_app/firebase_options/firebase_options_develop.dart' as develop;
import 'package:sauna_app/firebase_options/firebase_options_product.dart' as product;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: getFirebaseOptions());
  runApp(const AppComponent());
  FirebaseFirestore.instance
      .collection('test')
      .doc()
      .set({'time': DateTime.now().toString()});
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