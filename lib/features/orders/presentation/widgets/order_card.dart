// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.index,
    required this.order,
  });
  final int index;
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      margin: index == 0
          ? const EdgeInsets.symmetric(vertical: 20)
          : const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ДОСТАВКА: №${order.id}',
            style: TextStyle(
              color: mainColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'От: ${order.from_where?['address']}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'До: ${order.to_where?['address']}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () async {
                      final String phoneNumber = 'tel:${order.sender}';
                      try {
                        if (await canLaunch(phoneNumber)) {
                          await launch(phoneNumber);
                        } else {
                          throw 'Could not launch $phoneNumber';
                        }
                      } catch (e) {
                        if (kDebugMode) {
                          print('Error: $e');
                        }
                      }
                    },
                    child: Container(
                      height: 32,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Отправитель',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () async {
                      final String phoneNumber = 'tel:${order.consumer}';
                      try {
                        if (await canLaunch(phoneNumber)) {
                          await launch(phoneNumber);
                        } else {
                          throw 'Could not launch $phoneNumber';
                        }
                      } catch (e) {
                        if (kDebugMode) {
                          print('Error: $e');
                        }
                      }
                    },
                    child: Container(
                      height: 32,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Получатель',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
