import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/home.dart';
import '../screens/login_screen.dart';

class AuthController extends GetxController {
  // Login
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  FocusNode loginEmailFocusNode = FocusNode();
  FocusNode loginPasswordFocusNode = FocusNode();

  // Register
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController =
      TextEditingController();
  FocusNode registerNameFocusNode = FocusNode();
  FocusNode registerEmailFocusNode = FocusNode();
  FocusNode registerPasswordFocusNode = FocusNode();
  FocusNode registerConfirmPasswordFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    loginEmailController = TextEditingController();
    loginPasswordController = TextEditingController();
    loginEmailFocusNode = FocusNode();
    loginPasswordFocusNode = FocusNode();

    registerNameController = TextEditingController();
    registerEmailController = TextEditingController();
    registerPasswordController = TextEditingController();
    registerConfirmPasswordController = TextEditingController();
    registerNameFocusNode = FocusNode();
    registerEmailFocusNode = FocusNode();
    registerPasswordFocusNode = FocusNode();
    registerConfirmPasswordFocusNode = FocusNode();
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    loginEmailFocusNode.dispose();
    loginPasswordFocusNode.dispose();

    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    registerNameFocusNode.dispose();
    registerEmailFocusNode.dispose();
    registerPasswordFocusNode.dispose();
    registerConfirmPasswordFocusNode.dispose();

    super.onClose();
  }

  var displayName = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  User? get userProfile => auth.currentUser;

  var loadingLogin = false.obs;
  var loadingRegister = false.obs;

  void signUp() async {
    try {
      loadingRegister.value = true;

      await auth
          .createUserWithEmailAndPassword(
              email: registerEmailController.text,
              password: registerPasswordController.text)
          .then((value) {
        displayName = registerNameController.text;
        auth.currentUser!.updateDisplayName(displayName);
      });
      update();

      clearRegisterFields();

      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = "La contraseña proporcionada es demasiado débil";
      } else if (e.code == "email-already-in-use") {
        message = "El correo electrónico ya está registrado";
      } else {
        message = e.message.toString();
      }
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("¡Se produjo un error!", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      loadingRegister.value = false;
    }
  }

  void signIn() async {
    String email = loginEmailController.text;
    String password = loginPasswordController.text;

    String message = '';

    try {
      loadingLogin.value = true;

      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => displayName = userProfile!.displayName!);

      auth.currentUser!.updateDisplayName(displayName);

      clearLoginFields();
      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        message = 'Invalid Password. Please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = 'Error al iniciar seión';
      }

      Get.snackbar('¡Se produjo un error!', message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar(
        '¡Se produjo un error!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      loadingLogin.value = false;
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
      displayName = '';
      update();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar('Error ocurred!', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void clearLoginFields() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  void clearRegisterFields() {
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
  }

  void clearLoginFocusNodes() {
    loginEmailFocusNode.unfocus();
    loginPasswordFocusNode.unfocus();
  }

  void clearRegisterFocusNodes() {
    registerNameFocusNode.unfocus();
    registerEmailFocusNode.unfocus();
    registerPasswordFocusNode.unfocus();
    registerConfirmPasswordFocusNode.unfocus();
  }
}
