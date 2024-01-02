// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      email: json['email'] as String?,
      first_name: json['first_name'] as String?,
      id: json['id'] as int,
      iin: json['iin'] as String?,
      image: json['image'] as String?,
      last_name: json['last_name'] as String?,
      works: json['works'] as bool?,
      user: json['user'] as Map<String, dynamic>?,
      deliveries: json['deliveries'] as int?,
      earnings: json['earnings'] as int?,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'iin': instance.iin,
      'image': instance.image,
      'email': instance.email,
      'user': instance.user,
      'works': instance.works,
      'deliveries': instance.deliveries,
      'earnings': instance.earnings,
    };
