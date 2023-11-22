import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goflex_courier/common/colors.dart';

class OrderTopPart extends StatelessWidget {
  const OrderTopPart({
    super.key,
    required this.imageUrl,
    required this.orderNumber,
    required this.from,
    required this.to,
  });
  final String imageUrl;
  final String orderNumber;
  final String from;
  final String to;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageUrl.isEmpty
                ? Image.asset(
                    'assets/images/profile.jpg',
                    height: 64,
                    width: 64,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imageUrl,
                    height: 64,
                    width: 64,
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Заказ №',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      orderNumber,
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/custom.svg'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              from,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: const Color(0xFF595959),
                            ),
                            Text(
                              from,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
