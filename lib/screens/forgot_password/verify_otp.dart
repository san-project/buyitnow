import 'dart:developer';

import 'package:buyitnow/screens/forgot_password/reset_password.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/loading_widget.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key, required this.email});
  final String email;

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final _formField = GlobalKey<FormState>();
  late final TextEditingController _otpController;

  @override
  void initState() {
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text('Verification Code'),
            const Text('We have sent the verification code to'),
            Text(widget.email),
            SizedBox(
              height: 50.h,
            ),
            Form(
                key: _formField,
                child: TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value?.length != 4) {
                      return "enter 4 digit code";
                    }
                    return null;
                  },
                )),
            SizedBox(
              height: 50.h,
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
                        .verifyOtp(_otpController.text, context);
                    if (isVerified && mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ResetPassword()));
                    }
                    // if (isOtpSent) {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) => VerifyOtp(email: _otpController.text)));
                    // }
                  }
                },
                child: context.watch<AuthProvider>().isLoading
                    ? const Center(
                        child: LoadingWidget(),
                      )
                    : const Text('Submit'))

            // OtpForm()
            // Form(
            //     child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SizedBox(
            //       height: 68,
            //       width: 64,
            //       child: TextFormField(
            //         onChanged: (value) {
            //           if (value.length == 1) {
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },
            //         onSaved: (newValue) {
            //           log(newValue ?? "null");
            //         },
            // keyboardType: TextInputType.number,
            // textAlign: TextAlign.center,
            // inputFormatters: [
            //   LengthLimitingTextInputFormatter(1),
            //   FilteringTextInputFormatter.digitsOnly
            // ],
            //       ),
            //     ),
            //     SizedBox(
            //       height: 68,
            //       width: 64,
            //       child: TextFormField(
            //         onSaved: (newValue) {
            //           log(newValue ?? "null");
            //         },
            //         onChanged: (value) {
            //           if (value.length == 1) {
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },
            //         keyboardType: TextInputType.number,
            //         textAlign: TextAlign.center,
            //         inputFormatters: [
            //           LengthLimitingTextInputFormatter(1),
            //           FilteringTextInputFormatter.digitsOnly
            //         ],
            //       ),
            //     ),
            //     SizedBox(
            //       height: 68,
            //       width: 64,
            //       child: TextFormField(
            //         onSaved: (newValue) {
            //           log(newValue ?? "null");
            //         },
            //         onChanged: (value) {
            //           if (value.length == 1) {
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },
            //         keyboardType: TextInputType.number,
            //         textAlign: TextAlign.center,
            //         inputFormatters: [
            //           LengthLimitingTextInputFormatter(1),
            //           FilteringTextInputFormatter.digitsOnly
            //         ],
            //       ),
            //     ),
            //     SizedBox(
            //       height: 68,
            //       width: 64,
            //       child: TextFormField(
            //         onSaved: (newValue) {
            //           log(newValue ?? "null");
            //         },
            //         onChanged: (value) {
            //           if (value.length == 1) {
            //             FocusScope.of(context).nextFocus();
            //           }
            //         },
            //         keyboardType: TextInputType.number,
            //         textAlign: TextAlign.center,
            //         inputFormatters: [
            //           LengthLimitingTextInputFormatter(1),
            //           FilteringTextInputFormatter.digitsOnly
            //         ],
            //       ),
            //     ),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }
}

// class OtpForm extends StatefulWidget {
//   const OtpForm({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _OtpFormState createState() => _OtpFormState();
// }

// class _OtpFormState extends State<OtpForm> {
//   late FocusNode pin2FocusNode;
//   late FocusNode pin3FocusNode;
//   late FocusNode pin4FocusNode;

//   @override
//   void initState() {
//     super.initState();
//     pin2FocusNode = FocusNode();
//     pin3FocusNode = FocusNode();
//     pin4FocusNode = FocusNode();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     pin2FocusNode.dispose();
//     pin3FocusNode.dispose();
//     pin4FocusNode.dispose();
//   }

//   void nextField(String value, FocusNode? focusNode) {
//     if (value.length == 1) {
//       focusNode!.requestFocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           SizedBox(height: SizeConfig.screenHeight * 0.15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 60.w,
//                 child: TextFormField(
//                   autofocus: true,
//                   obscureText: true,
//                   style: const TextStyle(fontSize: 24),
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   onChanged: (value) {
//                     nextField(value, pin2FocusNode);
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 60.w,
//                 child: TextFormField(
//                   focusNode: pin2FocusNode,
//                   obscureText: true,
//                   style: const TextStyle(fontSize: 24),
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   onChanged: (value) => nextField(value, pin3FocusNode),
//                 ),
//               ),
//               SizedBox(
//                 width: 60.w,
//                 child: TextFormField(
//                   focusNode: pin3FocusNode,
//                   obscureText: true,
//                   style: const TextStyle(fontSize: 24),
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   onChanged: (value) => nextField(value, pin4FocusNode),
//                 ),
//               ),
//               SizedBox(
//                 width: 60.w,
//                 child: TextFormField(
//                   focusNode: pin4FocusNode,
//                   obscureText: true,
//                   style: const TextStyle(fontSize: 24),
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.center,
//                   onChanged: (value) {
//                     if (value.length == 1) {
//                       pin4FocusNode.unfocus();
//                       // Then you need to check is the code is correct or not
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: SizeConfig.screenHeight * 0.15),
//           ElevatedButton(
//             child: const Text("Continue"),
//             onPressed: () {},
//           )
//         ],
//       ),
//     );
//   }
// }
