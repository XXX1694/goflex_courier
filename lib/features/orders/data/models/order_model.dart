// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int? id;
  final String? sender;
  final Map<String, dynamic>? from_where;
  final Map<String, dynamic>? to_where;
  final String? term;
  final String? description;
  final int? delivery_service;
  final String? type;
  final String? consumer;
  final bool? delivered;
  final bool? accepted;
  final String? review;
  final int? order;
  final int? courier;
  final String? created_at;
  final bool is_kaspi_order;

  OrderModel({
    required this.id,
    required this.delivery_service,
    required this.description,
    required this.from_where,
    required this.sender,
    required this.term,
    required this.to_where,
    required this.consumer,
    required this.accepted,
    required this.courier,
    required this.delivered,
    required this.order,
    required this.review,
    required this.type,
    required this.created_at,
    required this.is_kaspi_order,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
