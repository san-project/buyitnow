import 'package:buyitnow/screens/forgot_password/forgot_password.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/bottom_navbar.dart';
import '../signup/signup_screen.dart';

class SiginPage extends StatefulWidget {
  const SiginPage({super.key});

  @override
  State<SiginPage> createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  // final bool _isObscure = true;
  final _formField = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode _passwordNode;
  bool passToggle = true;
  @override
  void initState() {
    _passwordNode = FocusNode();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordNode.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
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
                SizedBox(height: 200.h),
                const Text(
                  "Let's sign In.",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    Text(
                      "WelCome Back.",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      "You've been missed!",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_passwordNode),
                  textInputAction: TextInputAction.next,
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
                  focusNode: _passwordNode,
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
                    } else if (passwordController.text.length < 6) {
                      return "password should be minimum 8 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ));
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: SizeConfig.screenWidth,
                  height: 40.h,
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
                                    .signIn(emailController.text,
                                        passwordController.text, context)
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
                const SizedBox(height: 10),
                const Center(child: Text('or')),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ButtomNavBars(),
                        ));
                      },
                      child: const Text('Continue without sign in')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// PasswordFeild() {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5),
//         child: 
//       ),
//     ],
//   );
// }

// EmailField() {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5),
//         child: 
//       ),
//     ],
//   );
// }


// import 'dart:developer';

// import 'package:buyitnow/screens/signup/signup_screen.dart';
// import 'package:buyitnow/services/api_services.dart';
// import 'package:buyitnow/widgets/bottom_navbar.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formField = GlobalKey<FormState>();
//   late final  TextEditingController emailController;
//   late final TextEditingController passwordController;
//   bool passToggle = true;
//   ApiServices _services = ApiServices();
//   @override
//   void initState() {
//     passwordController = TextEditingController();
//     emailController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     passwordController.dispose();
//     super.dispose();
//   }
  


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 60),
//           child: Form(
//             key: _formField,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 50,),
//                 Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
//                 const SizedBox(height: 50,),
//                 TextFormField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     labelText: "Email",
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                   validator: (value){
//                     bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//       .hasMatch(value!);
//                     if(value.isEmpty){
//                       return "Enter Email";
//                     }
                    
//                     else if(!emailValid){
//                       return "Enter Valid Email";
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 20,),
//                  TextFormField(
//                   obscureText: passToggle,
//                   controller: passwordController,
//                   decoration:  InputDecoration(
//                     labelText: "Password",
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.lock),
//                     suffixIcon: InkWell(
//                       onTap: (){
//                         setState(() {
//                           passToggle = !passToggle;
//                         });
                        
//                       },
//                       child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
//                     )
//                   ),
//                   validator: (value){
//                     if(value!.isEmpty){
//                       return "Enter Password";
//                     }else if(passwordController.text.length < 6){
//                       return "Password length should be more then 6 characters";
//                     }
//                   },
//                 ),
//                 SizedBox(height: 60,),
//                 InkWell(
//                   onTap: ()async{
//                     if(_formField.currentState!.validate()){
//                       final user = await _services.login(emailController.text, passwordController.text);
//                       log(user!.role.toString());
//                       if(user.role==0){
                        
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ButtomNavBar()));
//                       }
//                       emailController.clear();
//                       passwordController.clear();
//                     }
//                   },
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.indigo,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Center(
//                       child: Text("Log In",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold
//                       ),),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Don't have an account?",style: TextStyle(
//                       fontSize: 16,
//                     ),),
//                     TextButton(onPressed: (){
//                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpScreen()));
//                     }, 
//                     child: Text("Sign Up",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold
//                     ),))
//                   ],
//                 )
//               ],
//                     )),
//         ),
//       ),
//     );
//   }
// }