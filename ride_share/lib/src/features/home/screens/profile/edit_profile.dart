// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//
// import '../../../../constants/sizes.dart';
// import '../../../../constants/text_strings.dart';
//
// class EditProfileScreen extends StatelessWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.put(ProfileController());
//     // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: const Icon(LineAwesomeIcons.angle_left)),
//         title: Text(tEditProfile,
//             style: Theme.of(context).textTheme.headlineMedium),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(tDefaultSize),
//           child: FutureBuilder(
//             future: controller.getUserData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   UserModel userModel = snapshot.data as UserModel;
//
//                   final fullName =
//                       TextEditingController(text: userModel.fullName);
//                   final email = TextEditingController(text: userModel.email);
//                   final phoneNo =
//                       TextEditingController(text: userModel.phoneNo);
//                   final password =
//                       TextEditingController(text: userModel.password);
//
//                   return Column(
//                     children: [
//                       Stack(
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 120,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(100),
//                               child:
//                                   const Image(image: AssetImage(tProfilePic)),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: Container(
//                               width: 35,
//                               height: 35,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(100),
//                                 color: tSecondaryColor,
//                               ),
//                               child: const Icon(LineAwesomeIcons.camera,
//                                   size: 20.0, color: Colors.black),
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 50),
//                       Form(
//                           child: Column(
//                         children: [
//                           TextFormField(
//                             controller: fullName,
//                             decoration: const InputDecoration(
//                               label: Text(tFullName),
//                               prefixIcon: Icon(LineAwesomeIcons.user),
//                             ),
//                           ),
//                           const SizedBox(height: tFormHeight - 20),
//                           TextFormField(
//                             controller: email,
//                             decoration: const InputDecoration(
//                               label: Text(tEmail),
//                               prefixIcon: Icon(LineAwesomeIcons.envelope_1),
//                             ),
//                           ),
//                           const SizedBox(height: tFormHeight - 20),
//                           TextFormField(
//                             controller: phoneNo,
//                             decoration: const InputDecoration(
//                               label: Text(tPhoneNo),
//                               prefixIcon: Icon(LineAwesomeIcons.phone),
//                             ),
//                           ),
//                           const SizedBox(height: tFormHeight - 20),
//                           TextFormField(
//                             controller: password,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                                 label: const Text(tPassword),
//                                 prefixIcon:
//                                     const Icon(Icons.fingerprint_outlined),
//                                 suffixIcon: IconButton(
//                                     icon:
//                                         const Icon(LineAwesomeIcons.eye_slash),
//                                     onPressed: () {})),
//                           ),
//                           const SizedBox(height: tFormHeight),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 final userData = UserModel(
//                                   email: email.text.trim(),
//                                   password: password.text.trim(),
//                                   fullName: fullName.text.trim(),
//                                   phoneNo: phoneNo.text.trim(),
//                                   phoneVerified: false,
//                                   joinedOn: '',
//                                 );
//
//                                 await controller.updateRecord(userModel);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: tPrimaryColor,
//                                   side: BorderSide.none,
//                                   shape: const StadiumBorder()),
//                               child: const Text(tEditProfile,
//                                   style: TextStyle(color: tDarkColor)),
//                             ),
//                           ),
//                           const SizedBox(height: tFormHeight),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text.rich(
//                                 TextSpan(
//                                   text: tJoined,
//                                   style: TextStyle(fontSize: 12),
//                                   children: [
//                                     TextSpan(
//                                         text: tJoinedAt,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12))
//                                   ],
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {},
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         Colors.redAccent.withOpacity(0.1),
//                                     elevation: 0,
//                                     foregroundColor: Colors.red,
//                                     shape: const StadiumBorder(),
//                                     side: BorderSide.none),
//                                 child: const Text(tDelete),
//                               ),
//                             ],
//                           )
//                         ],
//                       ))
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text(snapshot.error.toString()));
//                 } else {
//                   return const Center(child: Text("Something went wrong"));
//                 }
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
