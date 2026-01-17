import 'package:flutter/material.dart';

class ProfileModel extends ChangeNotifier {
  final int id;
  String firstName;
  String lastName;
  String phone;
  DateTime createdAt;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.createdAt,
  });

  
}
