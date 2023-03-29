import 'package:flutter/material.dart';

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
  bool passToggle = true;
  @override
  void initState() {
    passwordController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
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
                  "Let's sign In.",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "WelCome Back.",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "You've been missed!",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
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
                const SizedBox(height: 10),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Passord?",
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
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
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
                            "Sign In",
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