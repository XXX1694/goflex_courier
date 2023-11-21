import 'package:flutter/material.dart';
import 'package:goflex_courier/common/widgets/main_button.dart';
import 'package:goflex_courier/features/orders/presentation/pages/orders_page.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF141515),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Spacer(),
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Алатауский район',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Асылбек Даниял',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white12),
            const SizedBox(height: 20),
            MainButtonBlack(
              text: 'Мой автивный заказы',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            MainButton(
              text: 'Начать работу',
              onPressed: () {},
            ),
            const SizedBox(height: 54),
          ],
        ),
      ),
    );
  }
}
