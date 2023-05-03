import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notiandchat/utility/app_controller.dart';
import 'package:notiandchat/utility/app_snackbar.dart';
import 'package:path/path.dart';

class AppService {
  AppController controller = Get.put(AppController());

  Future<void> aboutNoti() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var token = await messaging.getToken();
    print('token Login ---> $token');

    FirebaseMessaging.onMessage.listen((event) {
      print('onMessage Work');
      alertNoti(remoteMessage: event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('onOpenMessage Work');
      alertNoti(remoteMessage: event);
    });
  }

  void alertNoti({required RemoteMessage remoteMessage}) {
    AppSnackBar(
            title: remoteMessage.notification!.title!,
            message: remoteMessage.notification!.body!)
        .normalSnackBar();
  }

  Future<void> processUploadImage({required String pathStorage}) async {
    print('method processUpload Work');
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference =
        storage.ref().child('$pathStorage/${controller.nameFiles.last}');
    UploadTask uploadTask = reference.putFile(controller.files.last);
    await uploadTask.whenComplete(() async {
      print('upload Complete');
      await reference.getDownloadURL().then((value) {
        String urlAvatar = value;
        print('urlAvatar ----> $urlAvatar');
        controller.urlImage.value = urlAvatar;
      });
    });
  }

  Future<void> takePhoto({required ImageSource source}) async {
    var result = await ImagePicker()
        .pickImage(source: source, maxWidth: 800, maxHeight: 800);

    if (result != null) {
      File file = File(result.path);
      String nameFile = basename(file.path);
      print('nameFile ---> $nameFile');

      controller.files.add(file);
      controller.nameFiles.add(nameFile);
    }
  }
}
