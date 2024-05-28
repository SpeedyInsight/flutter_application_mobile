// import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:flutter/material.dart';
// import 'package:responsi_praktpm_129/service/database_helper.dart';
// import 'package:responsi_praktpm_129/view/home_page.dart';
// import 'package:responsi_praktpm_129/view/signup.dart';


// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final username_controller = TextEditingController();
//   final password_controller = TextEditingController();
//   bool isLogin = true;
//   bool isHidden = true;

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: ListView(
//         key: _formKey,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: 50, left: 60),
//             child: Text(
//               'Login',
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 0, left: 60, bottom: 30),
//             child: Text(
//               'Login to your account!',
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Card(
//             shadowColor: Colors.black,
//             color: Colors.white,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
//                     child: Center(
//                       child: usernameField(),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
//                     child: Center(
//                       child: passwordField(),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         bottom: 0, left: 100, right: 100, top: 20),
//                     child: Center(
//                       child: loginButton(),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Belum punya akun?"),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const RegisterPage(),
//                             ),
//                           );
//                         },
//                         child: const Text('Daftar'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget usernameField() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//       child: TextFormField(
//         enabled: true,
//         controller: username_controller,
//         decoration: InputDecoration(
//           fillColor: Colors.black,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(40),
//             borderSide: BorderSide(
//               color: Colors.black,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: const BorderRadius.all(Radius.circular(50)),
//             borderSide: BorderSide(color: (isLogin) ? Colors.black : Colors.red),
//           ),
//           labelText: "Username",
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return "Username tidak boleh kosong";
//           }
//         },
//       ),
//     );
//   }

//   Widget passwordField() {
//     return Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: TextFormField(
//           enabled: true,
//           controller: password_controller,
//           obscureText: isHidden,
//           decoration: InputDecoration(
//             border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(50)),
//               borderSide: BorderSide(color: Colors.black),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: const BorderRadius.all(Radius.circular(50)),
//               borderSide:
//                   BorderSide(color: (isLogin) ? Colors.black : Colors.red),
//             ),
//             suffixIcon: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isHidden = !isHidden;
//                 });
//               },
//               child: Icon(
//                 isHidden ? Icons.visibility_off : Icons.visibility,
//                 color: isHidden ? Colors.grey : Colors.black,
//               ),
//             ),
//             labelText: 'Password',
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return "Password tidak boleh kosong";
//             }
//             return null;
//           },
//         ));
//   }

//   Widget loginButton() {
//     return _submitButton(
//       labelButton: "Login",
//       submitCallback: (value) {
//         String currentUsername = username_controller.value.text;
//         String currentPassword = password_controller.value.text;

//         prosesLogin(currentUsername, currentPassword);
//       },
//     );
//   }

//   Widget _submitButton({
//     required String labelButton,
//     required Function(String) submitCallback,
//   }) {
//     return Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         width: MediaQuery.of(context).size.width,
//         child: ElevatedButton(
//           onPressed: () {
//             submitCallback(labelButton);
//           }, //prosesLogin,
//           child: const Text('Login'),
//           style: ElevatedButton.styleFrom(
//               minimumSize: const Size.fromHeight(40),
//               primary: (isLogin) ? Colors.black : Colors.red,
//               onPrimary: Colors.white,
//               shape: StadiumBorder()),
//         ));
//   }

//   void prosesLogin(String username, String password) async {
//     final DatabaseHelper databaseHive = DatabaseHelper();
//     final enkripPassword = sha256.convert(utf8.encode(password)).toString();
//     bool found = false;

//     found = databaseHive.cekLogin(username, password);

//     String? hashedPassword = databaseHive.getHashedPassword(username);

//     if (hashedPassword != null) {
//       if (enkripPassword == hashedPassword) {
//         found = true;
//       }
//     }

//     if (!found) {
//       String text = "Login Gagal";

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(text),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 2),
//         ),
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: Container(
//             padding: EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.check_circle,
//                   size: 80,
//                   color: Colors.green,
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Login Berhasil',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return DashboardPage();
//                         },
//                       ),
//                     );
//                   },
//                   child: Text('OK'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size.fromHeight(40),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }
