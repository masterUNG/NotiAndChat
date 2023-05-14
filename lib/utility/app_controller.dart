import 'dart:io';

import 'package:get/get.dart';
import 'package:notiandchat/models/chat_model.dart';
import 'package:notiandchat/models/user_model.dart';

class AppController extends GetxController {
  RxBool redEye = true.obs;

  RxList<File> files = <File>[].obs;
  RxList<String> nameFiles = <String>[].obs;

  RxString urlImage = ''.obs;
  RxString token = ''.obs;
  RxList<UserModel> userModels = <UserModel>[].obs;
  RxList<ChatModel> chatModels = <ChatModel>[].obs;
}
