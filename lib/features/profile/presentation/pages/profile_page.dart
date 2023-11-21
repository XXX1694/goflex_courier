import 'package:flutter/material.dart';
import 'package:goflex_courier/features/profile/presentation/widgets/profile_info_bloc.dart';
import 'package:goflex_courier/features/profile/presentation/widgets/profile_image.dart';
import 'package:goflex_courier/features/profile/presentation/widgets/profile_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF141515),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 54),
              ProfileImagePart(imageUrl: 'assets/images/profile.jpg'),
              SizedBox(height: 20),
              Text(
                'Асылбек Даниял',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Алатауский район',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              ProfileInfoPart(
                raiting: 4.6,
                earned: 112,
                orderCount: 98786,
              ),
              SizedBox(height: 40),
              Expanded(
                child: ProfileList(),
              ),
              Text(
                'goflex 1.0.0',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
