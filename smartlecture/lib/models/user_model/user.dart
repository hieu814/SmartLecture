import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';

class User {
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  bool active;
  Timestamp lastOnlineTimestamp;
  String userID;
  String profilePictureURL;
  bool selected;
  String appIdentifier;
  String role;
  User(
      {this.email = '',
      this.firstName = '',
      this.phoneNumber = '',
      this.lastName = '',
      this.active = false,
      this.selected = false,
      lastOnlineTimestamp,
      this.userID = '',
      this.role = USER_ROLE_USER,
      this.profilePictureURL = ''})
      : this.lastOnlineTimestamp = lastOnlineTimestamp ?? Timestamp.now(),
        this.appIdentifier = 'Flutter Login Screen ${Platform.operatingSystem}';

  String fullName() {
    if (firstName == null || lastName == null) return "";
    return '${firstName ?? ""}  ${lastName ?? ""}';
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        active: parsedJson['active'] ?? false,
        lastOnlineTimestamp: parsedJson['lastOnlineTimestamp'],
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        role: parsedJson['role'] ?? USER_ROLE_USER,
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'phoneNumber': this.phoneNumber,
      'id': this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp,
      'profilePictureURL': this.profilePictureURL,
      'appIdentifier': this.appIdentifier,
      'role': this.role
    };
  }
}
