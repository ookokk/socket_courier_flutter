// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import 'socket_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final service = SocketService();

  @override
  void initState() {
    super.initState();
    service.connected();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Socket Costumer'),
        ),
        body: StreamBuilder(
          stream: service.streamController.stream,
          builder: (context, snapshot) {
            final item = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        center: LatLng(item!.lat!, item.lon!),
                        zoom: 16,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(item.lat!, item.lon!),
                              builder: (context) {
                                return const Icon(Icons.location_history,
                                    size: 36);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text("Lat: ${item.lat} Lon: ${item.lon}"),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Icon(Icons.error),
                );
              }
            }
          },
        ));
  }
}
