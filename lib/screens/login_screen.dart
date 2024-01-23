import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/textfield/custom_textfield.dart';
import '../controllers/auth_controller.dart';
import '../theme/colors.dart';
import '../utils/responsive.dart';
import '../utils/validators.dart';
import '../widgets/button/custom_buttom.dart';
import '../widgets/clickable_text/navigation_text.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late var controller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = Get.put(AuthController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void submit() {
      if (formKey.currentState!.validate()) {
        controller.signIn();
      }
    }

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.buttonColors,
                  ),
                  child: Center(
                    child: Text(
                      "NEOSEG",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headlineLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                Text("Bienvenido de nuevo",
                    style: Theme.of(context).primaryTextTheme.titleLarge),
                const SizedBox(height: 10),
                Text("Inicia sesión",
                    style: Theme.of(context).primaryTextTheme.bodyLarge),
                const SizedBox(height: 25),
                Container(
                  width: Responsive.percentageWidth(context, 80,
                      maxWidth: (42 * 1024) / 100),
                  child: Column(
                    children: [
                      CustomTextField(
                          focusNode: controller.loginEmailFocusNode,
                          nextFocusNode: controller.loginPasswordFocusNode,
                          hintText: "Email",
                          textEditingController:
                              controller.loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.emailValidator),
                      const SizedBox(height: 10),
                      CustomTextField(
                          focusNode: controller.loginPasswordFocusNode,
                          hintText: "Contraseña",
                          isPassword: true,
                          onEditingComplete: submit,
                          textEditingController:
                              controller.loginPasswordController,
                          validator: Validators.passwordValidator),
                      const SizedBox(height: 20),
                      Obx(() => CustomButton(
                            loading: controller.loadingLogin.value,
                            text: "Inicia sesión",
                            onTap: () => submit(),
                          )),
                      const SizedBox(height: 20),
                      NavigationText(
                          normalText: '¿No tienes cuenta?',
                          linkText: 'Registrate',
                          onTap: () {
                            controller.clearLoginFields();

                            Get.off(() => const RegisterScreen());
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
