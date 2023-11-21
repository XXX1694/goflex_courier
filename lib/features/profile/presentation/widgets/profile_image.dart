import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goflex_courier/common/colors.dart';

class ProfileImagePart extends StatelessWidget {
  const ProfileImagePart({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {},
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(100),
        ),
        child: CircleAvatar(
          radius: 100,
          foregroundColor: mainColor,
          backgroundImage: AssetImage(imageUrl),
        ),
      ),
    );
  }
}
