import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/common/widgets/main_button.dart';
import 'package:goflex_courier/features/deliveried/presentation/bloc/deliveried_bloc.dart';
import 'package:goflex_courier/features/delivery_accept/presentation/bloc/delivery_accept_bloc.dart';
import 'package:goflex_courier/features/main/presentation/bloc/main_bloc.dart';
import 'package:goflex_courier/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
    required this.to,
    required this.id,
    required this.type,
  });
  final LatLng to;
  final int id;
  final String type;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late DeliveryAcceptBloc acceptBloc;
  late DeliveriedBloc deliviredBloc;
  double totalDistance = 0;
  late MainBloc mainBloc;
  LatLng? _currentP;
  late TextEditingController controller;
  late OrdersBloc bloc;
  Location location = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  LocationData? _currentPos;
  String? address;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polilineCoordinates = [];
  @override
  void initState() {
    super.initState();
    mainBloc = BlocProvider.of<MainBloc>(context);
    acceptBloc = BlocProvider.of<DeliveryAcceptBloc>(context);
    deliviredBloc = BlocProvider.of<DeliveriedBloc>(context);
    acceptBloc.add(Reset());
    deliviredBloc.add(ResetA());
    controller = TextEditingController();
    _currentP = const LatLng(43.238949, 76.889709);
    getCurrentLocation().then(
      (_) => getPolyinePoints().then(
        (coordinates) {
          generatePolyLineFromPoints(coordinates);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: widget.type == "SENDING"
            ? const Text('Отправить заказ')
            : const Text('Забрать заказ'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: _currentP != null
          ? Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _currentP!,
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('from'),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _currentP!,
                    ),
                    Marker(
                      markerId: const MarkerId('to'),
                      icon: BitmapDescriptor.defaultMarker,
                      position: widget.to,
                    ),
                  },
                  mapType: MapType.normal,
                  onCameraMove: (CameraPosition? position) {},
                  onCameraIdle: () {},
                  onMapCreated: (GoogleMapController controller) async {
                    _mapController.complete(controller);
                  },
                  polylines: Set<Polyline>.of(polylines.values),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const Spacer(),
                        BlocConsumer<DeliveryAcceptBloc, DeliveryAcceptState>(
                          builder: (BuildContext context, state) {
                            if (state is DeliverAcepting) {
                              return const MainButtonLoading();
                            } else if (state is DeliverAcepted) {
                              return BlocConsumer<DeliveriedBloc,
                                  DeliveriedState>(
                                builder: (BuildContext context, state1) {
                                  if (state1 is Deliviring) {
                                    return const MainButtonLoading();
                                  } else {
                                    return MainButton(
                                      text: 'Заказ доставлен',
                                      onPressed: () {
                                        totalDistance != 0
                                            ? deliviredBloc.add(
                                                Delivered(
                                                  id: widget.id,
                                                  distance:
                                                      totalDistance.toInt(),
                                                ),
                                              )
                                            : null;
                                      },
                                    );
                                  }
                                },
                                listener:
                                    (BuildContext context, Object? state1) {
                                  if (state1 is DelivirError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Заказ не доставлен'),
                                      ),
                                    );
                                  } else if (state1 is Deliviringed) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Заказ доставлен'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    bloc.add(GetOrders());
                                  }
                                },
                              );
                            } else {
                              return MainButton(
                                text: 'Принять заказ',
                                onPressed: () {
                                  acceptBloc.add(AcceptDelivery(id: widget.id));
                                },
                              );
                            }
                          },
                          listener: (BuildContext context, Object? state) {
                            if (state is DeliverAcepted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Заказ принят'),
                                ),
                              );
                            } else if (state is DeliverAceptError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Заказ не принят'),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            ),
    );
  }

  Future<void> cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  // Future<void> getCurrentLocation() async {
  //   bool servideEnabled;
  //   PermissionStatus premissionGranted;

  //   servideEnabled = await location.serviceEnabled();
  //   final GoogleMapController controller = await _mapController.future;

  //   if (servideEnabled) {
  //     servideEnabled = await location.requestService();
  //   } else {
  //     return;
  //   }

  //   premissionGranted = await location.hasPermission();
  //   if (premissionGranted == PermissionStatus.denied) {
  //     premissionGranted = await location.requestPermission();
  //     if (premissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _locationController.onLocationChanged.listen(
  //     (LocationData currentLocation) {
  //       if (currentLocation.longitude != null &&
  //           currentLocation.latitude != null) {
  //         setState(() {
  //           _currentP =
  //               LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //         });
  //         controller.animateCamera(
  //           CameraUpdate.newCameraPosition(
  //             CameraPosition(
  //               target: LatLng(
  //                 currentLocation.latitude!,
  //                 currentLocation.longitude!,
  //               ),
  //               zoom: 16,
  //             ),
  //           ),
  //         );
  //         if (kDebugMode) {
  //           print(_currentP);
  //         }
  //       }
  //     },
  //   );
  // }
  final _storage = SharedPreferences.getInstance();

  getCurrentLocation() async {
    final storage = await _storage;
    bool servideEnabled;
    PermissionStatus premissionGranted;

    servideEnabled = await location.serviceEnabled();
    final GoogleMapController controller = await _mapController.future;

    if (!servideEnabled) {
      servideEnabled = await location.requestService();
      if (!servideEnabled) {
        return;
      }
    }

    premissionGranted = await location.hasPermission();
    if (premissionGranted == PermissionStatus.denied) {
      premissionGranted = await location.requestPermission();
      if (premissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (premissionGranted == PermissionStatus.granted) {
      location.changeSettings(accuracy: LocationAccuracy.high);

      _currentPos = await location.getLocation();
      await storage.setDouble(
        'current_lat',
        _currentPos!.latitude!,
      );
      await storage.setDouble(
        'current_lng',
        _currentPos!.longitude!,
      );
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentPos!.latitude!, _currentPos!.longitude!),
            zoom: 16,
          ),
        ),
      );
      setState(() {
        _currentP = LatLng(_currentPos!.latitude!, _currentPos!.longitude!);
      });
    }
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<List<LatLng>> getPolyinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBK8UODiBnpgbTS_0AaJIHMuo3gcmXfw-Y',
      PointLatLng(_currentP!.latitude, _currentP!.longitude),
      PointLatLng(widget.to.latitude, widget.to.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polilineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    } else {
      if (kDebugMode) {
        print(result.errorMessage);
      }
    }
    for (var i = 0; i < polilineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polilineCoordinates[i].latitude,
          polilineCoordinates[i].longitude,
          polilineCoordinates[i + 1].latitude,
          polilineCoordinates[i + 1].longitude);
    }
    if (kDebugMode) {
      print(totalDistance);
    }
    return polilineCoordinates;
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
