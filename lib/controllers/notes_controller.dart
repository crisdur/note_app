import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:note_app/models/note_model.dart';

import 'auth_controller.dart';

enum AccountStatus { initial, loading, loaded, error }

class NotesController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final AuthController _authController = Get.find<AuthController>();

  late CollectionReference notesReference;

  RxList<NoteModel> notes = RxList<NoteModel>([]);

  Rx<AccountStatus> accountStatus = Rx<AccountStatus>(AccountStatus.initial);

  RxBool? createAccountNotifier = false.obs;

  @override
  void onInit() {
    super.onInit();

    String currentUserId = _authController.auth.currentUser!.uid;

    notesReference = firebaseFirestore.collection("notes");

    if (_authController.auth.currentUser != null) {
      currentUserId = _authController.auth.currentUser!.uid;

      notesReference
          .where('userId', isEqualTo: currentUserId)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isEmpty) {}
      });

      accountStatus.value = AccountStatus.loading;

      notes.bindStream(getNotes(_authController.auth.currentUser!.uid));

      getNotes(currentUserId).listen(
        (List<NoteModel> _) {
          accountStatus.value = AccountStatus.loaded;
        },
        onError: (dynamic error) {
          accountStatus.value = AccountStatus.error;
        },
      );
    }
  }

  Stream<List<NoteModel>> getNotes(String userId) {
    return notesReference
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((query) {
      return query.docs.map((e) => NoteModel.fromDocumentSnapshot(e)).toList();
    }).handleError((error) {
      accountStatus.value = AccountStatus.error;
      print("Error al obtener cuentas: $error");
      return [];
    });
  }
}
