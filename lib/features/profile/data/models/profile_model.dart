// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final int id;
  final String? first_name;
  final String? last_name;
  final String? iin;
  final String? image;
  final String? email;
  final Map<String, dynamic>? user;
  final bool? works;
  final int? deliveries;
  final int? earnings;
  ProfileModel({
    required this.email,
    required this.first_name,
    required this.id,
    required this.iin,
    required this.image,
    required this.last_name,
    required this.works,
    required this.user,
    required this.deliveries,
    required this.earnings,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
