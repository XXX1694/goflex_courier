// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int?,
      delivery_service: json['delivery_service'] as int?,
      description: json['description'] as String?,
      from_where: json['from_where'] as Map<String, dynamic>?,
      sender: json['sender'] as String?,
      term: json['term'] as String?,
      to_where: json['to_where'] as Map<String, dynamic>?,
      consumer: json['consumer'] as String?,
      accepted: json['accepted'] as bool?,
      courier: json['courier'] as int?,
      delivered: json['delivered'] as bool?,
      order: json['order'] as int?,
      review: json['review'] as String?,
      type: json['type'] as String?,
      created_at: json['created_at'] as String?,
      is_kaspi_order: json['is_kaspi_order'] as bool,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'from_where': instance.from_where,
      'to_where': instance.to_where,
      'term': instance.term,
      'description': instance.description,
      'delivery_service': instance.delivery_service,
      'type': instance.type,
      'consumer': instance.consumer,
      'delivered': instance.delivered,
      'accepted': instance.accepted,
      'review': instance.review,
      'order': instance.order,
      'courier': instance.courier,
      'created_at': instance.created_at,
      'is_kaspi_order': instance.is_kaspi_order,
    };
