import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:goflex_courier/features/orders/presentation/pages/order_info.dart';
import 'package:goflex_courier/features/orders/presentation/widgets/order_card.dart';

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
        backgroundColor: Colors.black,
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
              color: Colors.white24,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: state is GotOrders
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
                    child: ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderInfoPage(
                                order: state.orders[index],
                              ),
                            ),
                          );
                        },
                        child: OrderCard(
                          index: index,
                          order: state.orders[index],
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
    );
  }
}


// Container(
//                           padding: const EdgeInsets.all(12),
//                           width: double.infinity,
//                           margin: index == 0
//                               ? const EdgeInsets.symmetric(vertical: 20)
//                               : const EdgeInsets.only(bottom: 20),
//                           height: 165,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1E1E1E),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               OrderTopPart(
//                                 imageUrl: '',
//                                 orderNumber: state.orders[index].id.toString(),
//                                 to: state.orders[index].to_where?['address'],
//                                 from:
//                                     state.orders[index].from_where?['address'],
//                               ),
//                               const SizedBox(height: 12),
//                               // const OrderDetail(),
//                               // const SizedBox(height: 12),
//                               Text(
//                                 state.orders[index].description ??
//                                     'Нет описнаия',
//                                 style: const TextStyle(
//                                   color: Colors.white54,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               OrderButtons(
//                                 sender: state.orders[index].sender ??
//                                     '+77074462659',
//                                 resiver: state.orders[index].consumer ??
//                                     '+77074462659',
//                               ),
//                             ],
//                           ),
//                         ),