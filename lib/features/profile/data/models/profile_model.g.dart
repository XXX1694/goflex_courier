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
      deliveries_last_30: json['deliveries_last_30'] as int?,
      deliveries_today: json['deliveries_today'] as int?,
      distance: json['distance'] as int?,
      distance_last_30: json['distance_last_30'] as int?,
      distance_today: json['distance_today'] as int?,
      earnings_last_30: json['earnings_last_30'] as int?,
      earnings_today: json['earnings_today'] as int?,
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
      'deliveries_last_30': instance.deliveries_last_30,
      'deliveries_today': instance.deliveries_today,
      'earnings': instance.earnings,
      'earnings_last_30': instance.earnings_last_30,
      'earnings_today': instance.earnings_today,
      'distance': instance.distance,
      'distance_last_30': instance.distance_last_30,
      'distance_today': instance.distance_today,
    };
