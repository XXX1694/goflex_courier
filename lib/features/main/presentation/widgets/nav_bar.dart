import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/autharization/presentation/bloc/autharization_bloc.dart';
import 'package:goflex_courier/features/order_history/presentation/pages/order_history_page.dart';
import 'package:goflex_courier/features/orders/presentation/pages/orders_page.dart';
import 'package:goflex_courier/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:goflex_courier/features/settings/presentation/pages/settings_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late AutharizationBloc authBloc;
  late ProfileBloc profileBloc;
  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    authBloc = BlocProvider.of<AutharizationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutharizationBloc, AutharizationState>(
      builder: (BuildContext context, state) => Drawer(
        backgroundColor: const Color(0xFF141515),
        child: ListView(
          children: [
            BlocConsumer<ProfileBloc, ProfileState>(
              builder: (BuildContext context, ProfileState state) {
                if (state is GotProfile) {
                  return UserAccountsDrawerHeader(
                    arrowColor: mainColor,
                    accountName: Text(state.profile.first_name ?? ''),
                    accountEmail: Text(state.profile.user?['phone'] ?? ''),
                    currentAccountPicture: CircleAvatar(
                      radius: 100,
                      foregroundColor: mainColor,
                      backgroundImage: NetworkImage(
                        state.profile.user?['image'] ?? '',
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: mainColor,
                    ),
                  );
                } else {
                  return UserAccountsDrawerHeader(
                    arrowColor: mainColor,
                    accountName: const Text('Пусто'),
                    accountEmail: const Text('Пусто'),
                    currentAccountPicture: CircleAvatar(
                      foregroundColor: mainColor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: mainColor,
                    ),
                  );
                }
              },
              listener: (BuildContext context, ProfileState state) {
                if (state is ProfileInitial || state is GetProfileError) {
                  profileBloc.add(GetProfile());
                }
              },
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersPage(),
                  ),
                );
              },
              leading: const Icon(
                Icons.list,
                color: Colors.white,
              ),
              title: const Text(
                'Мои заказы',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Text(
                'Профиль',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/chat');
              },
              leading: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
              title: const Text(
                'Чат',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersHistoryPage(),
                  ),
                );
              },
              leading: const Icon(
                Icons.history,
                color: Colors.white,
              ),
              title: const Text(
                'История заказов',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/help');
              },
              leading: const Icon(
                Icons.help,
                color: Colors.white,
              ),
              title: const Text(
                'Помошь',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Divider(color: Colors.white12),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPages(),
                  ),
                );
              },
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: const Text(
                'Настройки',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                authBloc.add(LogOut());
              },
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: const Text(
                'Выйти',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
      listener: (BuildContext context, Object? state) {
        if (state is AutharizationInitial) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      },
    );
  }
}
