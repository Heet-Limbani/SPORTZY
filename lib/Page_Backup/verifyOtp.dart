// // ignore_for_file: unused_local_variable

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sportzy/Heet/HomePage.dart';
// // import 'package:sportzy/Heet/profile.dart';
// // import 'package:sportzy/Nitesh/loginPage.dart';
// import 'package:sportzy/Page_Backup/signUpPage.dart';

// // ignore: must_be_immutable
// class VerifyOtp extends StatefulWidget {
//   var unumber;
//   final String uname;
//   final String uemail;
//   final String uage;
//   final String ugender;
//   VerifyOtp({
//     Key? key,
//     required this.unumber,
//     required this.uname,
//     required this.uemail,
//     required this.uage,
//     required this.ugender,
//   }) : super(key: key);

//   @override
//   State<VerifyOtp> createState() => _VerifyOtp();
// }

// class _VerifyOtp extends State<VerifyOtp> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   var code = "";
//   late var userid;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: TextStyle(
//           fontSize: 20,
//           color: Color.fromRGBO(30, 60, 87, 1),
//           fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );

//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
//       borderRadius: BorderRadius.circular(8),
//     );

//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration!.copyWith(
//         color: Color.fromRGBO(234, 239, 243, 1),
//       ),
//     );
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             height: size.height,
//             width: size.width,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 colors: [
//                   Color.fromARGB(255, 17, 71, 234),
//                   Color.fromARGB(255, 50, 115, 228),
//                   Color.fromARGB(255, 88, 192, 233),
//                 ],
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.15,
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
//                   child: Text(
//                     "Phone Verification",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 34,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.06,
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     physics: NeverScrollableScrollPhysics(),
//                     child: Container(
//                       height: size.height,
//                       width: size.width,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(50),
//                             topRight: Radius.circular(50)),
//                       ),
//                       child: Container(
//                         margin: EdgeInsets.only(left: 25, right: 25),
//                         child: Column(
//                           children: <Widget>[
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.11,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(
//                                   left: MediaQuery.of(context).size.width * 0.0,
//                                   right:
//                                       MediaQuery.of(context).size.width * 0.44),
//                               child: Text(
//                                 "Enter OTP Below",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.06,
//                             ),
//                             Pinput(
//                               length: 6,
//                               showCursor: true,
//                               onChanged: (value) {
//                                 code = value;
//                               },
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.04,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(
//                                   left:
//                                       MediaQuery.of(context).size.width * 0.64,
//                                   right:
//                                       MediaQuery.of(context).size.width * 0.0),
//                               child: Text(
//                                 "Resend OTP",
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 2, 54, 133),
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height * 0.07,
//                             ),
//                             GestureDetector(
//                               child: Container(
//                                 height: 50,
//                                 width: size.width,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(30),
//                                   color: Color.fromARGB(255, 68, 167, 248),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "Let's Start",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                               onTap: () async {
//                                 try {
//                                   PhoneAuthCredential credential =
//                                       PhoneAuthProvider.credential(
//                                           verificationId: SignUpPage.verify,
//                                           smsCode: code);

//                                   // Sign the user in (or link) with the credential
//                                   await auth
//                                       .signInWithCredential(credential)
//                                       .then((value) {
//                                     FirebaseFirestore.instance
//                                         .collection('users')
//                                         .doc(value.user!.uid)
//                                         .set({
//                                       'number': widget.unumber,
//                                       'name': widget.uname,
//                                       'email': widget.uemail,
//                                       'age': widget.uage,
//                                       'gender': widget.ugender,
//                                     });
//                                   }).then((value) {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => HomePage()));
//                                   });
//                                 } catch (e) {
//                                   print("Wrong OTP!");
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           new Positioned(
//             top: 0.0,
//             left: 0.0,
//             right: 0.0,
//             child: AppBar(
//               leading: new IconButton(
//                 icon: new Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.white,
//                 ),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//               backgroundColor: Colors.transparent
//                   .withOpacity(0.0), //You can make this transparent
//               elevation: 0.0, //No shadow
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
