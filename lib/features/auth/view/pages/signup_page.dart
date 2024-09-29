import 'package:client/core/theme/color_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_text_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // appbar actually provides a back button
    final isLoading = ref.watch(authViewModelProvider.select((val) =>
        val?.isLoading ==
        true)); // rebuild only if authviewmodelprovider changes
    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showSnackBar(
              context,
              "Account has been created successfully! Please log in using the account.",
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ),
            );
          },
          error: (error, st) {
            showSnackBar(context, error.toString());
          },
          loading: () {},
        );
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: Loader())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      hint: "Name",
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      hint: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      hint: "Password",
                      controller: passwordController,
                      ObscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthGradientButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .signUpUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        } else {
                          showSnackBar(context, 'Missing fields.');
                        }
                      },
                      buttonText: "Sign Up",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: const [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: Pallete.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
