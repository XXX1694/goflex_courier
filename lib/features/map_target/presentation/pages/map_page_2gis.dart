// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:goflex_courier/common/widgets/main_button.dart';
// import 'package:goflex_courier/dgis_map_kit.dart';
// import 'package:goflex_courier/features/deliveried/presentation/bloc/deliveried_bloc.dart';
// import 'package:goflex_courier/features/delivery_accept/presentation/bloc/delivery_accept_bloc.dart';
// import 'package:goflex_courier/features/main/presentation/bloc/main_bloc.dart';
// import 'package:goflex_courier/features/orders/presentation/bloc/orders_bloc.dart';
// import 'package:location/location.dart';

// class MapPageDGis extends StatefulWidget {
//   const MapPageDGis({
//     super.key,
//     required this.to,
//     required this.id,
//     required this.type,
//   });
//   final Position to;
//   final int id;
//   final String type;
//   @override
//   State<MapPageDGis> createState() => _MapPageDGisState();
// }

// class _MapPageDGisState extends State<MapPageDGis> {
//   late DeliveryAcceptBloc acceptBloc;
//   late DeliveriedBloc deliviredBloc;
//   final Location _locationController = Location();
//   double totalDistance = 0;
//   late MainBloc mainBloc;
//   late TextEditingController controller;
//   late OrdersBloc bloc;
//   late DGisMapController _controller;
//   Location location = Location();
//   // ignore: unused_field
//   Position? _currentP;
//   String? address;
//   @override
//   void initState() {
//     super.initState();
//     mainBloc = BlocProvider.of<MainBloc>(context);
//     acceptBloc = BlocProvider.of<DeliveryAcceptBloc>(context);
//     deliviredBloc = BlocProvider.of<DeliveriedBloc>(context);
//     acceptBloc.add(Reset());
//     deliviredBloc.add(ResetA());
//     controller = TextEditingController();
//     _currentP = const Position(
//       lat: 43.238949,
//       long: 76.889709,
//     );
//     getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         title: widget.type == "SENDING"
//             ? const Text('Отправить заказ')
//             : const Text('Забрать заказ'),
//         centerTitle: true,
//       ),
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           DGisMap(
//             theme: MapTheme.DARK,
//             token: "2f6a54d7-25b5-4df0-8796-0e422cab77bd",
//             enableUserLocation: true,
//             onUserLocationChanged: (position) {
//               return Marker(
//                 position: position,
//                 icon: "assets/user_location.png",
//                 iconOptions: const MapIconOptions(size: 40.0),
//               );
//             },
//             initialCameraPosition: CameraPosition(
//               position: const Position(
//                 lat: 51.169392,
//                 long: 71.449074,
//               ),
//               zoom: 12,
//             ),
//             mapOnTap: (position) {
//               _controller.moveCamera(
//                 CameraPosition(position: position, zoom: 18.0),
//                 duration: const Duration(milliseconds: 400),
//                 animationType: CameraAnimationType.SHOW_BOTH_POSITIONS,
//               );
//               _controller.markersController.addMarker(
//                 Marker(
//                   id: "user_marker",
//                   position: position,
//                   icon: "assets/map_pin.png",
//                 ),
//                 "user_markers",
//               );
//             },
//             mapOnReady: () {},
//             mapOnCreated: (controller) {
//               _controller = controller;
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   const Spacer(),
//                   BlocConsumer<DeliveryAcceptBloc, DeliveryAcceptState>(
//                     builder: (BuildContext context, state) {
//                       if (state is DeliverAcepting) {
//                         return const MainButtonLoading();
//                       } else if (state is DeliverAcepted) {
//                         return BlocConsumer<DeliveriedBloc, DeliveriedState>(
//                           builder: (BuildContext context, state1) {
//                             if (state1 is Deliviring) {
//                               return const MainButtonLoading();
//                             } else {
//                               return MainButton(
//                                 text: 'Заказ доставлен',
//                                 onPressed: () {
//                                   totalDistance != 0
//                                       ? deliviredBloc.add(
//                                           Delivered(
//                                             id: widget.id,
//                                             distance: totalDistance.toInt(),
//                                             code: null,
//                                           ),
//                                         )
//                                       : null;
//                                 },
//                               );
//                             }
//                           },
//                           listener: (BuildContext context, Object? state1) {
//                             if (state1 is DelivirError) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Заказ не доставлен'),
//                                 ),
//                               );
//                             } else if (state1 is Deliviringed) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Заказ доставлен'),
//                                 ),
//                               );
//                               Navigator.pop(context);
//                               bloc.add(GetOrders());
//                             }
//                           },
//                         );
//                       } else {
//                         return MainButton(
//                           text: 'Принять заказ',
//                           onPressed: () {
//                             acceptBloc.add(AcceptDelivery(id: widget.id));
//                           },
//                         );
//                       }
//                     },
//                     listener: (BuildContext context, Object? state) {
//                       if (state is DeliverAcepted) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Заказ принят'),
//                           ),
//                         );
//                       } else if (state is DeliverAceptError) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Заказ не принят'),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 20)
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> getCurrentLocation() async {
//     bool servideEnabled;
//     PermissionStatus premissionGranted;

//     servideEnabled = await location.serviceEnabled();

//     if (servideEnabled) {
//       servideEnabled = await location.requestService();
//     } else {
//       return;
//     }

//     premissionGranted = await location.hasPermission();
//     if (premissionGranted == PermissionStatus.denied) {
//       premissionGranted = await location.requestPermission();
//       if (premissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _locationController.onLocationChanged.listen(
//       (LocationData currentLocation) {
//         if (currentLocation.longitude != null &&
//             currentLocation.latitude != null) {
//           setState(() {
//             _currentP = Position(
//               lat: currentLocation.latitude!,
//               long: currentLocation.longitude!,
//             );
//           });
//           _controller.moveCamera(
//             CameraPosition(
//               position: Position(
//                 lat: currentLocation.latitude!,
//                 long: currentLocation.longitude!,
//               ),
//               zoom: 16,
//             ),
//           );
//         }
//       },
//     );
//   }
// }
