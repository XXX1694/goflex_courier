// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      delivery_service: json['delivery_service'] as int?,
      description: json['description'] as String?,
      from_where: json['from_where'] as Map<String, dynamic>?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      sender: json['sender'] as String?,
      status: json['status'] as String?,
      term: json['term'] as String?,
      to_where: json['to_where'] as Map<String, dynamic>?,
      tracking_number: json['tracking_number'] as String?,
      consumer: json['consumer'] as String?,
      courier_arrival_time: json['courier_arrival_time'] == null
          ? null
          : DateTime.parse(json['courier_arrival_time'] as String),
      delivery_time: json['delivery_time'] == null
          ? null
          : DateTime.parse(json['delivery_time'] as String),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'from_where': instance.from_where,
      'to_where': instance.to_where,
      'term': instance.term,
      'description': instance.description,
      'delivery_service': instance.delivery_service,
      'status': instance.status,
      'products': instance.products,
      'tracking_number': instance.tracking_number,
      'consumer': instance.consumer,
      'courier_arrival_time': instance.courier_arrival_time?.toIso8601String(),
      'delivery_time': instance.delivery_time?.toIso8601String(),
    };
