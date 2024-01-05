import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/autharization/data/repositories/auth_repo.dart';
import 'package:goflex_courier/features/autharization/presentation/bloc/autharization_bloc.dart';
import 'package:goflex_courier/features/autharization/presentation/pages/login_page.dart';
import 'package:goflex_courier/features/deliveried/data/repositories/repo.dart';
import 'package:goflex_courier/features/deliveried/presentation/bloc/deliveried_bloc.dart';
import 'package:goflex_courier/features/delivery_accept/data/repositories/repo.dart';
import 'package:goflex_courier/features/delivery_accept/presentation/bloc/delivery_accept_bloc.dart';
import 'package:goflex_courier/features/help/presentation/pages/help_page.dart';
import 'package:goflex_courier/features/main/data/repositories/main_repo.dart';
import 'package:goflex_courier/features/main/presentation/bloc/main_bloc.dart';
import 'package:goflex_courier/features/main/presentation/pages/main_page.dart';
import 'package:goflex_courier/features/notification/presentation/pages/notification_page.dart';
import 'package:goflex_courier/features/order_history/data/repositories/repo.dart';
import 'package:goflex_courier/features/order_history/presentation/bloc/order_history_bloc.dart';
import 'package:goflex_courier/features/orders/data/repository/order_repository.dart';
import 'package:goflex_courier/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:goflex_courier/features/profile/data/repositories/profile_repo.dart';
import 'package:goflex_courier/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:goflex_courier/features/profile/presentation/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AutharizationBloc(
            repo: AutharizationRepository(),
            autharizationState: const AutharizationState(),
          ),
        ),
        BlocProvider(
          create: (context) => OrdersBloc(
            repo: OrderRepository(),
            ordersState: const OrdersState(),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            repo: ProfileRepository(),
            profileState: const ProfileState(),
          ),
        ),
        BlocProvider(
          create: (context) => MainBloc(
            repo: MainRepository(),
            mainState: const MainState(),
          ),
        ),
        BlocProvider(
          create: (context) => DeliveryAcceptBloc(
            repo: AcceptDeliveryRepo(),
            deliveryAcceptState: const DeliveryAcceptState(),
          ),
        ),
        BlocProvider(
          create: (context) => DeliveriedBloc(
            repo: DeliveriedRepo(),
            deliveriedState: const DeliveriedState(),
          ),
        ),
        BlocProvider(
          create: (context) => OrderHistoryBloc(
            repo: OrderArchiveRepository(),
            orderHistoryState: const OrderHistoryState(),
          ),
        ),
      ],
      child: MaterialApp(
        color: mainColor,
        theme: ThemeData(
          primaryColor: mainColor,
          primaryColorLight: mainColor,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const LoginPage(),
          '/main': (context) => const MainPage(),
          '/profile': (context) => const ProfilePage(),
          '/help': (context) => const HelpPage(),
          '/notification': (context) => const NotificationPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
