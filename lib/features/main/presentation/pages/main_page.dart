import 'dart:async';
import 'package:dgis_map_kit/dgis_map_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/main/presentation/bloc/main_bloc.dart';
import 'package:goflex_courier/features/main/presentation/widgets/bottom_part.dart';
import 'package:goflex_courier/features/main/presentation/widgets/nav_bar.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Position? _currentP;
  Location location = Location();

  String? address;
  late DGisMapController _controller;
  // final Completer<bool> _isMapReadyCompleter = Completer();

  @override
  void initState() {
    super.initState();
    mainBloc = BlocProvider.of<MainBloc>(context);
    _currentP = const Position(
      lat: 43.238949,
      long: 76.889709,
    );
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
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'flex',
                style: TextStyle(
                  color: mainColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          DGisMap(
            theme: MapTheme.DARK,
            token: "64cca5be-30f8-4772-8d5c-d64bab285c67",
            enableUserLocation: true,
            onUserLocationChanged: (position) {
              return Marker(
                position: position,
                icon: "assets/user_location.png",
                iconOptions: const MapIconOptions(size: 40.0),
              );
            },
            initialCameraPosition: CameraPosition(
              position: const Position(
                lat: 51.169392,
                long: 71.449074,
              ),
              zoom: 12,
            ),
            mapOnTap: (position) {
              _controller.moveCamera(
                CameraPosition(position: position, zoom: 18.0),
                duration: const Duration(milliseconds: 400),
                animationType: CameraAnimationType.SHOW_BOTH_POSITIONS,
              );
              _controller.markersController.addMarker(
                Marker(
                  id: "user_marker",
                  position: position,
                  icon: "assets/map_pin.png",
                ),
                "user_markers",
              );
            },
            mapOnReady: () {},
            mapOnCreated: (controller) {
              _controller = controller;
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

  final _storage = SharedPreferences.getInstance();
  Future<void> getCurrentLocation() async {
    final storage = await _storage;
    bool servideEnabled;
    PermissionStatus premissionGranted;

    servideEnabled = await location.serviceEnabled();

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
            _currentP = Position(
              lat: currentLocation.latitude!,
              long: currentLocation.longitude!,
            );
          });
          _controller.moveCamera(
            CameraPosition(
              position: Position(
                lat: currentLocation.latitude!,
                long: currentLocation.longitude!,
              ),
              zoom: 16,
            ),
          );

          if (kDebugMode) {
            print(_currentP);
          }
        }
      },
    );
    await storage.setDouble(
      'current_lat',
      _currentP!.lat,
    );
    await storage.setDouble(
      'current_lng',
      _currentP!.long,
    );
  }
}
