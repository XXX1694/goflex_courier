import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goflex_courier/common/widgets/main_button.dart';
import 'package:goflex_courier/features/deliveried/presentation/bloc/deliveried_bloc.dart';
import 'package:goflex_courier/features/deliveried/presentation/pages/kaspi_accept_page.dart';
import 'package:goflex_courier/features/delivery_accept/presentation/bloc/delivery_accept_bloc.dart';
import 'package:goflex_courier/features/orders/data/models/order_model.dart';
import 'package:goflex_courier/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:map_launcher/map_launcher.dart';

class OrderInfoPage extends StatefulWidget {
  const OrderInfoPage({
    super.key,
    required this.order,
  });
  final OrderModel order;
  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  late DeliveryAcceptBloc acceptBloc;
  late DeliveriedBloc deliviredBloc;
  late OrdersBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<OrdersBloc>(context);
    acceptBloc = BlocProvider.of<DeliveryAcceptBloc>(context);
    deliviredBloc = BlocProvider.of<DeliveriedBloc>(context);
    acceptBloc.add(Reset());
    deliviredBloc.add(ResetA());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.order.id.toString()),
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
          child: Column(
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    'От: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.order.from_where?['address'],
                    style: const TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'До: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.order.to_where?['address'],
                    style: const TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Тип: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.order.type.toString(),
                    style: const TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Номер: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.order.consumer.toString(),
                    style: const TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              BlocConsumer<DeliveryAcceptBloc, DeliveryAcceptState>(
                builder: (BuildContext context, state) {
                  if (state is DeliverAcepting) {
                    return const MainButtonLoading();
                  } else if (state is DeliverAcepted) {
                    return BlocConsumer<DeliveriedBloc, DeliveriedState>(
                      builder: (BuildContext context, state1) {
                        if (state1 is Deliviring) {
                          return const MainButtonLoading();
                        } else {
                          return MainButton(
                            text: 'Заказ доставлен',
                            onPressed: () {
                              if (widget.order.is_kaspi_order &&
                                  widget.order.type != 'ASSEMBLE') {
                                deliviredBloc
                                    .add(SendCode(id: widget.order.id ?? 0));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KaspiAccept(
                                      distance: 0,
                                      orderId: widget.order.id ?? 0,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KaspiAccept(
                                      distance: 0,
                                      orderId: widget.order.id ?? 0,
                                    ),
                                  ),
                                );
                                // deliviredBloc.add(
                                //   Delivered(
                                //     id: widget.order.id ?? 0,
                                //     distance: 0,
                                //     code: null,
                                //   ),
                                // );
                              }
                            },
                          );
                        }
                      },
                      listener: (BuildContext context, Object? state1) {
                        if (state1 is DelivirError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Заказ не доставлен'),
                            ),
                          );
                        } else if (state1 is Deliviringed) {
                          bloc.add(GetOrders());
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Заказ доставлен'),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return MainButton(
                      text: 'Принять заказ',
                      onPressed: () {
                        acceptBloc.add(
                          AcceptDelivery(
                            id: widget.order.id ?? 0,
                          ),
                        );
                      },
                    );
                  }
                },
                listener: (BuildContext context, Object? state) {
                  if (state is DeliverAcepted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Заказ принят'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  } else if (state is DeliverAceptError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Заказ не принят'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              MainButton(
                text: 'Построить маршрут',
                onPressed: () async {
                  openMapsSheet(context);
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  openMapsSheet(context) async {
    try {
      final coordsTo = Coords(double.parse(widget.order.to_where?['latitude']),
          double.parse(widget.order.to_where?['longitude']));
      final coordsFrom = Coords(
          double.parse(widget.order.from_where?['latitude']),
          double.parse(widget.order.from_where?['longitude']));
      final title = widget.order.type == 'ASSEMBLE'
          ? widget.order.from_where!['address']
          : widget.order.to_where!['address'];
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        backgroundColor: Colors.black,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: widget.order.type == 'ASSEMBLE'
                            ? coordsFrom
                            : coordsTo,
                        title: title,
                      ),
                      title: Text(
                        map.mapName,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
