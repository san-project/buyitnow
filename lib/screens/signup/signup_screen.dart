// import 'dart:developer';

// import 'package:buyitnow/screens/login/login_screen.dart';
// import 'package:buyitnow/services/api_services.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/bottom_navbar.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formField = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confPassword;
  late final TextEditingController userNameController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  bool passToggle = true;
  bool passToggle1 = true;
  @override
  void initState() {
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    confPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    passwordController.dispose();
    emailController.dispose();
    userNameController.dispose();
    confPassword.dispose();
    super.dispose();
  }

  signUp() {
    if (_formField.currentState!.validate()) {
      context
          .read<AuthProvider>()
          .signUp(userNameController.text, emailController.text,
              passwordController.text, context)
          .then((value) {
        if (value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const ButtomNavBars()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formField,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 120),
                const Text(
                  "Create An Account",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      "Already a member?",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SiginPage()));
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_emailFocusNode),
                  focusNode: _nameFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  controller: userNameController,
                  decoration: const InputDecoration(
                    labelText: "Enter Name",
                    suffixIcon: Icon(
                      (Icons.email_outlined),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_passwordFocusNode),
                  textInputAction: TextInputAction.next,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    suffixIcon: Icon(
                      (Icons.email_outlined),
                    ),
                  ),
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
                ),
                const SizedBox(height: 10),
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
                        child: Icon(passToggle
                            ? Icons.visibility_off
                            : Icons.visibility),
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
                const SizedBox(height: 10),
                TextFormField(
                  onFieldSubmitted: (value) {
                    signUp();
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
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: SizeConfig.screenWidth,
                    height: 50.h,
                    child: Consumer<AuthProvider>(
                      builder: (context, provider, child) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: provider.isLoading
                            ? null
                            : () {
                                if (_formField.currentState!.validate()) {
                                  provider
                                      .signUp(
                                          userNameController.text,
                                          emailController.text,
                                          passwordController.text,
                                          context)
                                      .then((value) {
                                    if (value) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const ButtomNavBars()));
                                    }
                                  });
                                }
                                // final isValid = _formKey.currentState!.validate();
                                // if (!isValid) {
                                //   return;
                                // }
                              },
                        child: Visibility(
                          visible: !provider.isLoading,
                          replacement: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formfield = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confPassword = TextEditingController();
//   final userNameController = TextEditingController();
//   bool passToggle = true;
//   ApiServices _services = ApiServices();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
//           child: Form(
//               key: _formfield,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   Text(
//                     'Sign Up',
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   TextFormField(
//                     controller: userNameController,
//                     keyboardType: TextInputType.text,
//                     decoration: const InputDecoration(
//                       labelText: "UserName",
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.person),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Enter UserName";
//                       }
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: const InputDecoration(
//                       labelText: "Email",
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.email),
//                     ),
//                     validator: (value) {
//                       bool emailValid = RegExp(
//                               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                           .hasMatch(value!);
//                       if (value.isEmpty) {
//                         return "Enter Email";
//                       } else if (!emailValid) {
//                         return "Enter Valid Email";
//                       }
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     obscureText: passToggle,
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                         labelText: "Password",
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: InkWell(
//                           onTap: () {
//                             setState(() {
//                               passToggle = !passToggle;
//                             });
//                           },
//                           child: Icon(passToggle
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                         )),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Enter Password";
//                       } else if (passwordController.text.length < 6) {
//                         return "Password length should be more then 6 characters";
//                       }
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     obscureText: passToggle,
//                     controller: confPassword,
//                     decoration: InputDecoration(
//                         labelText: "Confirm Password",
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: InkWell(
//                           onTap: () {
//                             setState(() {
//                               passToggle = !passToggle;
//                             });
//                           },
//                           child: Icon(passToggle
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                         )),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Enter Password";
//                       } else if (passwordController.text.length < 6) {
//                         return "Password length should be more then 6 characters";
//                       }
//                     },
//                   ),
//                   SizedBox(
//                     height: 60,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       if (_formfield.currentState!.validate()) {
//                         final user = await _services.register(
//                             userNameController.text,
//                             emailController.text,
//                             passwordController.text);

//                         log(user!.token);
//                         emailController.clear();
//                         passwordController.clear();
//                       }
//                     },
//                     child: Container(
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.indigo,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Sign Up",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already have an account?",
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => SiginPage()));
//                           },
//                           child: Text(
//                             "Sign In",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ))
//                     ],
//                   )
//                 ],
//               )),
//         ),
//       ),
//     );
//     ;
//   }
// }
