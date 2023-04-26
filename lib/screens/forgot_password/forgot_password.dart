import 'package:buyitnow/providers/auth_provider.dart';
import 'package:buyitnow/screens/forgot_password/verify_otp.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:buyitnow/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final TextEditingController _emailController;
  final _formField = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formField,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Forgot \nPassword ?',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text(
                  'Don\'t worry! it happens. Please enter the email address associated with your account'),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);
                  if (value.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!emailValid) {
                    return "Please enter valid Email address";
                  }
                  return null;
                },
                decoration:
                    const InputDecoration(hintText: 'Enter Email Address'),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // maximumSize: Size(SizeConfig.screenWidth, 57),
                      fixedSize: Size(SizeConfig.screenWidth, 47.h),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () async {
                    if (_formField.currentState!.validate()) {
                      final isOtpSent = await context
                          .read<AuthProvider>()
                          .getOtp(_emailController.text, context);
                      if (isOtpSent && mounted) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                VerifyOtp(email: _emailController.text)));
                      }
                    }
                  },
                  child: context.watch<AuthProvider>().isLoading
                      ? const Center(
                          child: LoadingWidget(),
                        )
                      : const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
