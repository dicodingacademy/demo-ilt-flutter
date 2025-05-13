import 'package:declarative_navigation/controller/auth_controller.dart';
import 'package:declarative_navigation/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;
  final Function(String, String) onShowDialog;

  const LoginScreen({
    Key? key,
    required this.onLogin,
    required this.onRegister,
    required this.onShowDialog,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// TODO: Add explicit animation to the Login button
class _LoginScreenState extends State<LoginScreen>
        // setup the stateful widget
        // to handle the animation
        // with SingleTickerProviderStateMixin
        with
        SingleTickerProviderStateMixin {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool obscureText = true;

  // setup the animation
  // using AnimationController and Animation
  late final AnimationController animationController;
  late final Animation<AlignmentGeometry> animation;

  @override
  void initState() {
    super.initState();
    // define the animation controller
    // with the duration of 300 milliseconds
    // and the vsync of this widget
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // define the animation
    // with the AlignmentTween
    // to animate the alignment
    // from center left to center right
    animation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(animationController);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    // dispose the animation controller
    // to free up the resources
    // and prevent memory leaks
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed:
                () => widget.onShowDialog(
                  "Info",
                  "This is a message to Dialog Page.",
                ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed:
                          () => setState(() => obscureText = !obscureText),
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                context.watch<AuthController>().isLoadingLogin
                    ? const Center(child: CircularProgressIndicator())
                    // add animation to handle the button
                    // when user not fill the form
                    : AlignTransition(
                      alignment: animation,
                      child: ElevatedButton(
                        // when the user not fill the form and pointing the cursor 
                        // to the button, the animation will start
                        // and the button will move away from the cursor.
                        onHover: (value) {
                          if (animationController.isAnimating) return;

                          if (!formKey.currentState!.validate()) {
                            animationController.isCompleted
                                ? animationController.reverse()
                                : animationController.forward();
                          }
                        },
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final scaffoldMessenger = ScaffoldMessenger.of(
                              context,
                            );
                            final User user = User(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            final authRead = context.read<AuthController>();

                            if (user.email == "admin" &&
                                user.password == "admin") {
                              await authRead.saveUser(user);
                            }

                            final result = await authRead.login(user);
                            if (result) {
                              widget.onLogin();
                            } else {
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Your email or password is invalid",
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text("LOGIN"),
                      ),
                    ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => widget.onRegister(),
                  child: const Text("REGISTER"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
