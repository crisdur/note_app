import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/button/custom_buttom.dart';
import '../../widgets/textfield/custom_textfield.dart';
import '../utils/validators.dart';
import '../widgets/clickable_text/navigation_text.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthController controller;
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
        controller.signUp();
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: Responsive.percentageWidth(context, 80,
                    maxWidth: (42 * 1024) / 100),
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    Text("Registrate",
                        style: Theme.of(context).primaryTextTheme.titleLarge),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        CustomTextField(
                            focusNode: controller.registerNameFocusNode,
                            nextFocusNode: controller.registerEmailFocusNode,
                            validator: Validators.nameValidator,
                            hintText: "Nombre",
                            textEditingController:
                                controller.registerNameController),
                        const SizedBox(height: 10),
                        CustomTextField(
                            focusNode: controller.registerEmailFocusNode,
                            nextFocusNode: controller.registerPasswordFocusNode,
                            validator: Validators.emailValidator,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Email",
                            textEditingController:
                                controller.registerEmailController),
                        const SizedBox(height: 10),
                        CustomTextField(
                            focusNode: controller.registerPasswordFocusNode,
                            nextFocusNode:
                                controller.registerConfirmPasswordFocusNode,
                            validator: Validators.passwordValidator,
                            hintText: "Contraseña",
                            isPassword: true,
                            textEditingController:
                                controller.registerPasswordController),
                        const SizedBox(height: 10),
                        CustomTextField(
                            focusNode:
                                controller.registerConfirmPasswordFocusNode,
                            onEditingComplete: () => submit(),
                            validator: (password) =>
                                Validators.confirmPasswordValidator(
                                    controller.registerPasswordController.text,
                                    password),
                            hintText: "Confirmar contraseña",
                            isPassword: true,
                            textEditingController:
                                controller.registerConfirmPasswordController),
                        const SizedBox(height: 20),
                        Obx(
                          () => CustomButton(
                              loading: controller.loadingRegister.value,
                              text: "Registrarse",
                              onTap: () => {
                                    if (formKey.currentState!.validate())
                                      controller.signUp()
                                  }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    NavigationText(
                      normalText: '¿Ya estás registrado?',
                      linkText: 'Inicia sesión',
                      onTap: () {
                        controller.clearRegisterFields();
                        Get.off(() => const LoginScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
