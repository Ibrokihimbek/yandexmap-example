import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexAppPage extends StatefulWidget {
  const YandexAppPage({Key? key}) : super(key: key);

  @override
  State<YandexAppPage> createState() => _YandexAppPageState();
}

class _YandexAppPageState extends State<YandexAppPage> {
  late YandexMapController controller;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
  Future<bool> get locationPermissionNotGranted async => !(await Permission.location.request().isGranted);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        onMapCreated: (YandexMapController yandexMapController) async {
          controller = yandexMapController;
        },
        onUserLocationAdded: (UserLocationView view) async {
          return view.copyWith(
              pin: view.pin.copyWith(
                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                          'assets/user.jpg')))),
              arrow: view.arrow.copyWith(
                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                          'assets/arrow.png')))),
              accuracyCircle: view.accuracyCircle
                  .copyWith(fillColor: Colors.green.withOpacity(0.5)));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await controller.moveCamera(CameraUpdate.zoomIn(),
                  animation: animation);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              await controller.moveCamera(CameraUpdate.zoomOut(),
                  animation: animation);
            },
            child: Icon(Icons.remove),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              if (await locationPermissionNotGranted) {
                print('Location permission was NOT granted');
                return;
              }
              controller.getUserCameraPosition();
            },
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
