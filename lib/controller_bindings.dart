import 'package:get/instance_manager.dart';
import 'package:note_app/controllers/notes_controller.dart';
import 'package:note_app/models/note_model.dart';

import 'controllers/auth_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.lazyPut<NotesController>(() => NotesController());
  }
}
