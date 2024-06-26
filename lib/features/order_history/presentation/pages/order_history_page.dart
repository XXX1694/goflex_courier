import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/order_history/presentation/bloc/order_history_bloc.dart';
import 'package:goflex_courier/features/orders/presentation/widgets/order_buttons.dart';
import 'package:goflex_courier/features/orders/presentation/widgets/order_top_part.dart';
import 'package:intl/intl.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrdersHistoryPage extends StatefulWidget {
  const OrdersHistoryPage({super.key});

  @override
  State<OrdersHistoryPage> createState() => _OrdersHistoryPageState();
}

class _OrdersHistoryPageState extends State<OrdersHistoryPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    bloc.add(GetOrderArchive());
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    refreshController.loadComplete();
  }

  late OrderHistoryBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<OrderHistoryBloc>(context);
    bloc.add(GetOrderArchive());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderHistoryBloc, OrderHistoryState>(
      listener: (context, state) {
        if (kDebugMode) {
          print(state);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'История заказов',
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
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: state is GotOrdersH
                ? SmartRefresher(
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
                    child: ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          margin: index == 0
                              ? const EdgeInsets.symmetric(vertical: 20)
                              : const EdgeInsets.only(bottom: 20),
                          height: 165,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderTopPart(
                                imageUrl: '',
                                orderNumber: state.orders[index].id.toString(),
                                to: state.orders[index].to_where?['address'],
                                from:
                                    state.orders[index].from_where?['address'],
                              ),
                              const SizedBox(height: 12),
                              // const OrderDetail(),
                              // const SizedBox(height: 12),
                              Text(
                                formatStringToDDMMYYYY(
                                    state.orders[index].created_at ?? ''),
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              OrderButtons(
                                sender: state.orders[index].sender ??
                                    '+77074462659',
                                resiver: state.orders[index].consumer ??
                                    '+77074462659',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : state is GettingOrdersH
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
    );
  }
}

String formatStringToDDMMYYYY(String dateString) {
  // Parse the string to a DateTime object
  DateTime dateTime = DateTime.parse(dateString);

  // Format the DateTime using the formatDateTimeToDDMMYYYY function
  return formatDateTimeToDDMMYYYY(dateTime);
}

String formatDateTimeToDDMMYYYY(DateTime dateTime) {
  // Format the DateTime using intl package
  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(dateTime);
}
