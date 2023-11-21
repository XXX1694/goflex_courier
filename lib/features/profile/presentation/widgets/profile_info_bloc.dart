import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileInfoPart extends StatelessWidget {
  const ProfileInfoPart({
    super.key,
    required this.raiting,
    required this.earned,
    required this.orderCount,
  });
  final double raiting;
  final int orderCount;
  final int earned;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset('assets/icons/star.svg'),
            const SizedBox(height: 8),
            Text(
              '$raiting',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(
              width: 55,
              child: Text(
                'Общий рейтинг',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        const SizedBox(width: 20),
        Container(
          height: 82,
          width: 1,
          color: Colors.white,
        ),
        const SizedBox(width: 40),
        Column(
          children: [
            SvgPicture.asset('assets/icons/crown.svg'),
            const SizedBox(height: 8),
            Text(
              '$orderCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(
              width: 55,
              child: Text(
                'Заказы за все время',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        const SizedBox(width: 40),
        Container(
          height: 82,
          width: 1,
          color: Colors.white,
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            SvgPicture.asset('assets/icons/wallet.svg'),
            const SizedBox(height: 8),
            Text(
              '$earned₸',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(
              width: 75,
              child: Text(
                'Заработано за все время',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
}
