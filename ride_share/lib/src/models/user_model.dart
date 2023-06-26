import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  late final String password;
  bool? emailVerified;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNo,
    this.emailVerified
  });

  toJsonInitial() {
    return {
      "FullName": fullName,
      "Email": email,
      "Password": password,
      "EmailVerified": false,
      "Phone": phoneNo,
    };
  }

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Password": password,
      "EmailVerified": emailVerified,
      "Phone": phoneNo,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
        id: document.id,
        email: data["Email"],
        password: data["Password"],
        fullName: data["FullName"],
        emailVerified: data["EmailVerified"],
        phoneNo: data["Phone"],
    );


  }

  factory UserModel.fromSnapshotVerify(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
        id: document.id,
        email: data["Email"],
        password: data["Password"],
        fullName: data["FullName"],
        emailVerified: true,
        phoneNo: data["Phone"],
    );
  }
}