import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/main/presentation/bloc/main_bloc.dart';
import 'package:goflex_courier/features/main/presentation/widgets/bottom_part.dart';
import 'package:goflex_courier/features/main/presentation/widgets/nav_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainBloc mainBloc;
  final Location _locationController = Location();
  LatLng? _currentP;
  late TextEditingController controller;
  Location location = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  String? address;

  @override
  void initState() {
    super.initState();
    mainBloc = BlocProvider.of<MainBloc>(context);
    controller = TextEditingController();
    _currentP = const LatLng(43.238949, 76.889709);
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141515),
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141515),
        foregroundColor: Colors.white,
        title: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'go',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'flex',
                style: TextStyle(
                  color: mainColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _currentP!,
              zoom: 16,
            ),
            mapType: MapType.normal,
            onCameraMove: (CameraPosition? position) {},
            onCameraIdle: () {},
            onTap: (latlng) {
              showBottom(context, '', '');
            },
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
          ),
        ],
      ),
    );
  }

  showBottom(
    BuildContext context,
    String name,
    String phone,
  ) {
    return showModalBottomSheet(
      backgroundColor: const Color(0xFF141515),
      context: context,
      builder: (context) => const BottomPart(),
      elevation: 0,
    );
  }

  Future<void> getCurrentLocation() async {
    bool servideEnabled;
    PermissionStatus premissionGranted;

    servideEnabled = await location.serviceEnabled();
    final GoogleMapController controller = await _mapController.future;

    if (servideEnabled) {
      servideEnabled = await location.requestService();
    } else {
      return;
    }

    premissionGranted = await location.hasPermission();
    if (premissionGranted == PermissionStatus.denied) {
      premissionGranted = await location.requestPermission();
      if (premissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen(
      (LocationData currentLocation) {
        if (currentLocation.longitude != null &&
            currentLocation.latitude != null) {
          setState(() {
            _currentP =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          });
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  currentLocation.latitude!,
                  currentLocation.longitude!,
                ),
                zoom: 16,
              ),
            ),
          );
          if (kDebugMode) {
            print(_currentP);
          }
        }
      },
    );
  }
}
