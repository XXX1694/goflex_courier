import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/widgets/main_button.dart';
import 'package:goflex_courier/features/autharization/presentation/bloc/autharization_bloc.dart';
import 'package:goflex_courier/features/autharization/presentation/widgets/login_form_field.dart';
import 'package:goflex_courier/features/autharization/presentation/widgets/login_main_text.dart';
import 'package:goflex_courier/features/autharization/presentation/widgets/login_second_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _phoneController;
  late TextEditingController _passwordContrller;
  late AutharizationBloc authBloc;
  @override
  void initState() {
    authBloc = BlocProvider.of<AutharizationBloc>(context);
    _phoneController = TextEditingController();
    _passwordContrller = TextEditingController();
    authBloc.add(GetStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutharizationBloc, AutharizationState>(
      listener: (BuildContext context, Object? state) {
        if (state is LoggedIn) {
          Navigator.pushNamed(context, '/main');
        } else if (state is LogInError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (BuildContext context, state) => Scaffold(
        backgroundColor: const Color(0xFF252525),
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
                        onPressed: () {
                          authBloc.add(
                            LogIn(
                              phone: _passwordContrller.text,
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
