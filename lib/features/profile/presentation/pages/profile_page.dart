import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:goflex_courier/features/profile/presentation/widgets/profile_info_bloc.dart';
import 'package:goflex_courier/features/profile/presentation/widgets/profile_image.dart';
import 'package:goflex_courier/features/profile/presentation/widgets/profile_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc profileBloc;
  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        if (state is GotProfile) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const ProfileImagePart(
                        imageUrl: 'assets/images/profile.jpg'),
                    const SizedBox(height: 20),
                    Text(
                      state.profile.first_name ?? 'пусто',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      state.profile.user?['phone'] ?? 'пусто',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ProfileInfoPart(
                      raiting: 5.0,
                      earned: state.profile.earnings ?? 0,
                      orderCount: state.profile.deliveries ?? 0,
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: ProfileList(
                        profile: state.profile,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'goflex 1.0.0',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        } else if (state is GettingProfile) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Center(
                child: Platform.isAndroid
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      )
                    : const CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Center(
                child: Text('Error'),
              ),
            ),
          );
        }
      },
      listener: (BuildContext context, ProfileState state) {
        if (state is ProfileInitial || state is GetProfileError) {
          profileBloc.add(GetProfile());
        }
      },
    );
  }
}
