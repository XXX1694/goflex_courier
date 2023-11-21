import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/autharization/presentation/bloc/autharization_bloc.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({super.key});

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  late AutharizationBloc authBloc;
  @override
  void initState() {
    authBloc = BlocProvider.of<AutharizationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutharizationBloc, AutharizationState>(
      builder: (BuildContext context, AutharizationState state) => ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              onTap: () {},
              leading: Icon(
                Icons.notifications,
                color: mainColor,
              ),
              title: const Text(
                'Уведомление',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              onTap: () {},
              leading: Icon(
                Icons.phone,
                color: mainColor,
              ),
              title: const Text(
                'Сменить номер',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              onTap: () {},
              leading: Icon(
                Icons.receipt,
                color: mainColor,
              ),
              title: const Text(
                'Правила использования',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              onTap: () {
                authBloc.add(LogOut());
              },
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: const Text(
                'Выйти',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
      listener: (BuildContext context, AutharizationState state) {
        if (state is AutharizationInitial) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      },
    );
  }
}
