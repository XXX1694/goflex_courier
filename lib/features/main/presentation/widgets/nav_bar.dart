import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/autharization/presentation/bloc/autharization_bloc.dart';
import 'package:goflex_courier/features/orders/presentation/pages/orders_page.dart';
import 'package:goflex_courier/features/settings/presentation/pages/settings_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late AutharizationBloc authBloc;
  @override
  void initState() {
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
            UserAccountsDrawerHeader(
              arrowColor: mainColor,
              accountName: const Text('Асылбек'),
              accountEmail: const Text('asylbel@gmail.com'),
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
              onTap: () {},
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
