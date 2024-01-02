import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/widgets/main_button.dart';
import 'package:goflex_courier/features/main/presentation/bloc/main_bloc.dart';
import 'package:goflex_courier/features/orders/presentation/pages/orders_page.dart';

class BottomPart extends StatefulWidget {
  const BottomPart({
    super.key,
  });

  @override
  State<BottomPart> createState() => _BottomPartState();
}

class _BottomPartState extends State<BottomPart> {
  late MainBloc mainBloc;
  @override
  void initState() {
    mainBloc = BlocProvider.of<MainBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      builder: (BuildContext context, MainState state) => Container(
        height: 206,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF141515),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 32),
              MainButtonBlack(
                text: 'Мой автивный заказы',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              state is WorkEnding || state is WorkStarting
                  ? const MainButtonLoading()
                  : state is WorkStarted
                      ? MainButtonOutlined(
                          text: 'Завершить работу',
                          onPressed: () {
                            mainBloc.add(EndWork());
                          },
                        )
                      : MainButton(
                          text: 'Начать работу',
                          onPressed: () {
                            mainBloc.add(StartWork());
                          },
                        ),
              const SizedBox(height: 54),
            ],
          ),
        ),
      ),
      listener: (BuildContext context, MainState state) {
        if (state is WorkEndError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        } else if (state is WorkStartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        } else if (state is WorkEnded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Вы завершили работу'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Вы начели работу'),
            ),
          );
        }
      },
    );
  }
}
