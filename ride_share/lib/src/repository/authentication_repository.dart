import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ride_share/src/features/home/screens/home_screen.dart';
import 'package:ride_share/src/repository/signup_failure.dart';
import 'package:ride_share/src/repository/user_repository.dart';

import '../features/authentication/screens/welcome/welcome_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  final _userRepo = Get.put(UserRepository());

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const HomeScreen());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
        // await _auth.currentUser?.linkWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-no') {
          Get.snackbar('Error', 'The phone number provided is invalid');
        } else {
          Get.snackbar('Error', 'Something went wrong');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
    // String? phone = credentials.user?.phoneNumber;
    // final snapshot = await FirebaseFirestore.instance
    //     .collection("Users")
    //     .where("Email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
    //     .get();
    // final userData = await snapshot.docs.map((e) => UserModel.fromSnapshotAdd(e, phone!)).single;
    // await FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(userData.id)
    //     .update(userData.toJson())
    //     .whenComplete(() => {
    //   Get.snackbar("Success", "Your phone number has been verified",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.green.withOpacity(0.1),
    //       colorText: Colors.green),
    // })
    //     .catchError((e) => print(e));

    // UserModel userData = await _userRepo.getUserDetails(FirebaseAuth.instance.currentUser?.email);
    // userData.phoneNo = credentials.user?.phoneNumber!;
    // userData.phoneVerified = true;
    // bool result = credentials.user != null ? true : false;
    // if(result == true){
    //   print(userData.toJson());
    //   await updatePhoneNumber(userData);
    //   return result;
    // }
    // return false;
  }

  // Future<void> updatePhoneNumber(UserModel user) async {
  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(user.id)
  //       .update(user.toJson())
  //       .whenComplete(() =>
  //   {
  //     Get.snackbar("Success", "Your phone number has been verified",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green.withOpacity(0.1),
  //         colorText: Colors.green),
  //   })
  //       .catchError((e) => print(e));
  // }

  Future<void> createUserWithEmailAndPassword(String email,
      String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.offAll(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpMailPasswordFailure.code(e.code);
      if (kDebugMode) {
        print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      }
      throw ex;
    } catch (_) {
      const ex = SignUpMailPasswordFailure();
      if (kDebugMode) {
        print('EXCEPTION - ${ex.message}');
      }
      throw ex;
    }
  }

  Future<bool> loginUserWithEmailAndPassword(String email,
      String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return firebaseUser.value != null ? true : false;
    } on FirebaseAuthException catch (e) {
      e.code;
    } catch (_) {}
    return false;
  }

  //
  // void signInWithFacebook() async{
  //
  //   try{
  //     final fbLoginResult = await FacebookAuth.instance.login();
  //     final userData = await FacebookAuth.instance.getUserData();
  //
  //     final fbCredential = FacebookAuthProvider.credential(fbLoginResult.accessToken!.token);
  //     await FirebaseAuth.instance.signInWithCredential(fbCredential);
  //
  //     await FirebaseFirestore.instance.collection("Users").add({
  //       'Email': userData['email'],
  //       'FullName': userData['name'],
  //     });
  //   } on FirebaseAuthException catch (e){
  //     var content = '';
  //     switch(e.code){
  //       case 'account-exists-with-different-credential':
  //         content = "This account exists with a different sign in provider";
  //         break;
  //
  //       case 'invalid-credential':
  //         content = "An unknown error has occurred";
  //         break;
  //       case 'operation-not-allowed':
  //         content = "This operation is not allowed";
  //         break;
  //       case 'user-disabled':
  //         content = "The account you tried to log in as is disabled";
  //         break;
  //       case 'user-not-found':
  //         content = "The account you tried to log in as does not exist";
  //         break;
  //     }
  //
  //     showDialog(context: context as BuildContext, builder: (context) => AlertDialog(
  //       title: const Text('log in with facebook failed'),
  //       content: Text(content),
  //       actions: [TextButton(onPressed: () {
  //         Navigator.of(context).pop();
  //       }, child: const Text('Ok'))],
  //     ));
  //
  //   } finally {
  //
  //   }
  // }

  Future<void> logout() async {
    await _auth.signOut();
  }
}