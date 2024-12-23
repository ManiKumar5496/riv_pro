import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riv_pro/modules/login/logic/login_controller.dart';
import '../../../common_widgets/common_textfield.dart';
import '../../../common_widgets/elevated_buttons.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _CounterViewState();
}

class _CounterViewState extends ConsumerState<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (loginState.isLoading==true)?const Center(child: CircularProgressIndicator()):Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Email TextField
                CommonTextField(
                  obscureText: false,
                  errorText: loginState.usernameError,
                  labelText: "Email",
                  textFieldController: emailController,
                ),
                const SizedBox(height: 16),

                // Password TextField
                CommonTextField(
                  obscureText: false,
                  errorText: loginState.passwordError,
                  labelText: "Password",
                  textFieldController: passwordController,
                ),

                const SizedBox(height: 32),

                // Login Button
                ElevatedButtonCommon(
                  onTap: () {
                    ref.read(loginProvider.notifier).login(
                      context,
                      emailController.text,
                      passwordController.text,
                    );
                  },
                  buttonColor: Colors.blueAccent,
                  buttonText: "Login",
                ),
                const SizedBox(height: 32),

                // Register Prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member? "),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                          fontFamily: "jasmine",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Image.asset("assets/images/png/google_icon.png"),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Image.asset("assets/images/png/Facebook_Logo.png"),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 40,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
                child: const Icon(
                  Icons.lock,
                  size: 60,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
