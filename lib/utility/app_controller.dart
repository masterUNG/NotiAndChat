import 'dart:io';

import 'package:get/get.dart';

class AppController extends GetxController {
  RxBool redEye = true.obs;

  RxList<File> files = <File>[].obs;
  RxList<String> nameFiles = <String>[].obs;

  RxString urlImage = ''.obs;
  RxString token = ''.obs;
}
