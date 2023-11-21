import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/order_info/presentation/pages/order_info_page.dart';
import 'package:goflex_courier/features/orders/presentation/bloc/orders_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    bloc.add(GetOrders());
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    refreshController.loadComplete();
  }

  late OrdersBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<OrdersBloc>(context);
    bloc.add(GetOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (kDebugMode) {
          print(state);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: const Color(0xFF141515),
        appBar: AppBar(
          title: const Text(
            'Заказы',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.white12,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF141515),
          foregroundColor: Colors.white,
        ),
        body: SmartRefresher(
          header: CustomHeader(
            builder: (context, mode) => Platform.isAndroid
                ? CircularProgressIndicator(
                    color: mainColor,
                    strokeWidth: 3,
                  )
                : CupertinoActivityIndicator(
                    color: mainColor,
                  ),
          ),
          enablePullDown: true,
          enablePullUp: false,
          controller: refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: state is GotOrders
                  ? ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderInfoPage(
                                tracking_number:
                                    state.orders[index].tracking_number ?? '',
                                delete: false,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: index == 0
                              ? const EdgeInsets.symmetric(vertical: 20)
                              : const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state.orders[index].status ?? '',
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    state.orders[index].tracking_number ?? '',
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Отправитель: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          state.orders[index].sender.toString(),
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'От: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: state
                                          .orders[index].from_where?['address'],
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'До: ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: state
                                          .orders[index].to_where?['address'],
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : state is GettingOrders
                      ? Center(
                          child: Platform.isAndroid
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                )
                              : const CupertinoActivityIndicator(
                                  color: Colors.white,
                                ),
                        )
                      : const Center(
                          child: Text('Пусто'),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
