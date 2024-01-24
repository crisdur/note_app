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

  RxList<NoteModel> filteredNotes = RxList<NoteModel>([]);

  RxBool? createNoteNotifier = false.obs;

  @override
  void onInit() {
    super.onInit();

    notes = RxList<NoteModel>([]);

    accountStatus = Rx<AccountStatus>(AccountStatus.initial);

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
          filterNotes('');
        },
        onError: (dynamic error) {
          accountStatus.value = AccountStatus.error;
        },
      );
    }
  }

  @override
  void onClose() {
    notes.close();
    super.onClose();
  }

  void filterNotes(String searchTerm) {
    filteredNotes.assignAll(notes
        .where((note) =>
            note.title.toLowerCase().contains(searchTerm.toLowerCase()) ||
            note.content.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList());
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

  void createNote(NoteModel note) async {
    try {
      createNoteNotifier?.value = true;

      // Generate a unique ID if noteId is null
      note.noteId ??= FirebaseFirestore.instance.collection('notes').doc().id;

      await notesReference.add({
        'noteId': note.noteId,
        'userId': note.userId,
        'title': note.title,
        'content': note.content,
        'modifiedTime': note.modifiedTime,
        'completed': note.completed,
      });

      createNoteNotifier?.value = false;
      // showSnackBar('Nota creada exitosamente');
    } catch (e) {
      createNoteNotifier?.value = false;
      // showSnackBar('Error al crear la nota', isError: true);
      print('Error al crear la nota: $e');
    }
  }

  void updateNote(NoteModel note) async {
    try {
      await notesReference.doc(note.noteId).update({
        'userId': note.userId,
        'title': note.title,
        'content': note.content,
        'modifiedTime': note.modifiedTime,
        'completed': note.completed,
      });

      // showSnackBar('Nota actualizada exitosamente');
    } catch (e) {
      // showSnackBar('Error al actualizar la nota', isError: true);
      print('Error al actualizar la nota: $e');
    }
  }

// Delete Note
  void deleteNote(String noteId) async {
    try {
      await notesReference.doc(noteId).delete();
      // showSnackBar('Nota eliminada exitosamente');
    } catch (e) {
      // showSnackBar('Error al eliminar la nota', isError: true);
      print('Error al eliminar la nota: $e');
    }
  }

  void updateCompletedStatus(String noteId, bool completed) async {
    try {
      await notesReference.doc(noteId).update({'completed': completed});
      // showSnackBar('Estado completado actualizado exitosamente');
    } catch (e) {
      // showSnackBar('Error al actualizar el estado completado', isError: true);
      print('Error al actualizar el estado completado: $e');
    }
  }
}
