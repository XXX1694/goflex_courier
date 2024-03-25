import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/widgets/main_button.dart';
import 'package:goflex_courier/features/autharization/presentation/bloc/autharization_bloc.dart';
import 'package:goflex_courier/features/autharization/presentation/widgets/login_form_field.dart';
import 'package:goflex_courier/features/autharization/presentation/widgets/login_main_text.dart';
import 'package:goflex_courier/features/autharization/presentation/widgets/login_second_text.dart';
import 'package:goflex_courier/features/profile/presentation/bloc/profile_bloc.dart';

import '../../../../utils/analytics/app_analytics.dart';
import '../../../../utils/permission_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _phoneController;
  late TextEditingController _passwordContrller;
  late AutharizationBloc authBloc;
  late ProfileBloc profileBloc;
  @override
  void initState() {
    initialization();
    authBloc = BlocProvider.of<AutharizationBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    _phoneController = TextEditingController();
    _passwordContrller = TextEditingController();
    authBloc.add(GetStatus());
    super.initState();
  }

  void initialization() async {
    await PermissionUtils.checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutharizationBloc, AutharizationState>(
      listener: (BuildContext context, Object? state) {
        if (state is LoggedIn) {
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     title: const Text('Местоположение'),
          //     content: const Text(
          //         'Чтобы обеспечивать работу выбора адреса доставки и отправки это приложение собирает данные о местоположении, даже когда закрыто или не используется'),
          //     actions: [
          //       TextButton(
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //         child: const Text('Да'),
          //       ),
          //       TextButton(
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //         child: const Text('Нет'),
          //       ),
          //     ],
          //   ),
          // );
          profileBloc.add(GetProfile());
        } else if (state is LogInError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (BuildContext context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Spacer(),
                const LoginMainText(),
                const SizedBox(height: 20),
                const LoginSecondText(),
                const SizedBox(height: 40),
                LoginFormField(
                  passwordController: _passwordContrller,
                  phoneController: _phoneController,
                ),
                const Spacer(),
                state is LogingIn
                    ? const MainButtonLoading()
                    : MainButton(
                        text: 'Войти',
                        onPressed: () async {
                          await AppAnalytics.requestTrackingAuthorization();
                          authBloc.add(
                            LogIn(
                              phone: _phoneController.text,
                              password: _passwordContrller.text,
                            ),
                          );
                        },
                      ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordContrller.dispose();
    super.dispose();
  }
}
