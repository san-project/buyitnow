import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../utils/size_config.dart';
import '../../widgets/bottom_navbar.dart';
import '../../widgets/loading_widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late final TextEditingController confPassword;
  late final TextEditingController passwordController;
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool passToggle = true;
  bool passToggle1 = true;
  final _formField = GlobalKey<FormState>();
  @override
  void initState() {
    confPassword = TextEditingController();
    passwordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.watch<AuthProvider>().isLoading == true) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            content: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formField,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change\nPassword.',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: 56.h,
              ),
              TextFormField(
                onFieldSubmitted: (value) => FocusScope.of(context)
                    .requestFocus(_confirmPasswordFocusNode),
                textInputAction: TextInputAction.next,
                focusNode: _passwordFocusNode,
                obscureText: passToggle,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility_off : Icons.visibility),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  } else if (passwordController.text.length < 8) {
                    return "password should be minimum 8 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 26.h),
              TextFormField(
                onFieldSubmitted: (value) {
                  // signUp();
                },
                textInputAction: TextInputAction.done,
                focusNode: _confirmPasswordFocusNode,
                obscureText: passToggle1,
                controller: confPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle1 = !passToggle1;
                        });
                      },
                      child: Icon(passToggle1
                          ? Icons.visibility_off
                          : Icons.visibility),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  } else if (confPassword.text.length < 8) {
                    return "password should be minimum 8 characters";
                  } else if (confPassword.text != passwordController.text) {
                    return "Both are not same";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 26.h,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(SizeConfig.screenWidth, 47.h),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () async {
                    if (_formField.currentState!.validate()) {
                      final isVerified = await context
                          .read<AuthProvider>()
                          .resetPassword(passwordController.text, context);
                      if (isVerified && mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ButtomNavBars()),
                          (route) => false,
                        );
                      }
                      // if (isOtpSent) {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (_) => VerifyOtp(email: _otpController.text)));
                      // }
                    }
                  },
                  child: context.watch<AuthProvider>().isLoading
                      ? const Center(
                          child: LoadingWidget(),
                        )
                      : const Text('Change Password'))
            ],
          ),
        ),
      ),
    );
  }
}
