// import 'dart:developer';

// import 'package:buyitnow/screens/login/login_screen.dart';
// import 'package:buyitnow/services/api_services.dart';
import 'package:flutter/material.dart';

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
  bool passToggle = true;
  bool passToggle1 = true;
  @override
  void initState() {
    passwordController = TextEditingController();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    confPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    userNameController.dispose();
    confPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formField,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 120),
                Text(
                  "Create An Account",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SiginPage()));
                      },
                      child: Text(
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
                  keyboardType: TextInputType.emailAddress,
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: "Enter Name",
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: const Icon(
                      (Icons.email_outlined),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter UserName";
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: const Icon(
                      (Icons.email_outlined),
                    ),
                  ),
                  validator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return "Enter Email";
                    } else if (!emailValid) {
                      return "Enter Valid Email";
                    }
                  },
                ),
                TextFormField(
                  obscureText: passToggle,
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: "Password",
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
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
                      return "Enter Password";
                    } else if (passwordController.text.length < 6) {
                      return "Password length should be more then 6 characters";
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: passToggle1,
                  controller: confPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
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
                      return "Enter Password";
                    } else if (passwordController.text.length < 6) {
                      return "Password length should be more then 6 characters";
                    }
                  },
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_formField.currentState!.validate()) {
                          // final user = await _services.login(emailController.text, passwordController.text);
                          // log(user!.role.toString());
                          // if(user.role==0){

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => ButtomNavBar()));
                        }
                        emailController.clear();
                        passwordController.clear();
                        //   }
                        // },
                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context) => ButtomNavBar()));
                      },
                      child: Container(
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
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
