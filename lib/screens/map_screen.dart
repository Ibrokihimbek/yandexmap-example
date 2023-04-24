import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapexample/bloc/lat_long_bloc/lat_long_bloc.dart';
import 'package:yandex_mapexample/models/lat_long.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexAppPage extends StatefulWidget {
  final LatLong latLong;

  const YandexAppPage({
    Key? key,
    required this.latLong,
  }) : super(key: key);

  @override
  State<YandexAppPage> createState() => _YandexAppPageState();
}

class _YandexAppPageState extends State<YandexAppPage> {
  GlobalKey mapKey = GlobalKey();
  late YandexMapController controller;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);

  late List<MapObject> mapObjects;

  late MapObjectId mapObjectId =
      mapObjectId = const MapObjectId('normal_icon_placemark');
  late PlacemarkMapObject mapIcon;

  @override
  void initState() {
    mapIcon = PlacemarkMapObject(
      mapId: mapObjectId,
      point: Point(
        latitude: widget.latLong.lat,
        longitude: widget.latLong.long,
      ),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            'assets/location.png',
          ),
          scale: 1.5,
        ),
      ),
      opacity: 1,
    );
    mapObjects = [mapIcon];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatLongBloc, GetLatLongState>(
      builder: (context, state) {
        return Scaffold(
          key: mapKey,
          body: YandexMap(
            // mapObjects: mapObjects,
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
              // controller.moveCamera(
              //   animation: animation,
              //   CameraUpdate.newCameraPosition(
              //     CameraPosition(
              //       zoom: 18,
              //       target: Point(
              //         latitude: widget.latLong.lat,
              //         longitude: widget.latLong.long,
              //       ),
              //     ),
              //   ),
              // );
              onUserLocationAdded:
              (UserLocationView view) async {
                return view.copyWith(
                    pin: view.pin.copyWith(
                        icon: PlacemarkIcon.single(PlacemarkIconStyle(
                            image: BitmapDescriptor.fromAssetImage(
                                'assets/location.png')))),
                    arrow: view.arrow.copyWith(
                        icon: PlacemarkIcon.single(PlacemarkIconStyle(
                            image: BitmapDescriptor.fromAssetImage(
                                'assets/location.png')))),
                    accuracyCircle: view.accuracyCircle
                        .copyWith(fillColor: Colors.blue.withOpacity(0.5)));
              };
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
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () async {
                  await controller.moveCamera(CameraUpdate.zoomOut(),
                      animation: animation);
                },
                child: const Icon(Icons.remove),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: state.latLongStatus.isLoading ? null : ()async {
                  final mediaQuery = MediaQuery.of(context);
                  final height = mapKey.currentContext!.size!.height *
                      mediaQuery.devicePixelRatio;
                  final width = mapKey.currentContext!.size!.width *
                      mediaQuery.devicePixelRatio;

                  await controller.toggleUserLayer(
                      visible: true,
                      anchor: UserLocationAnchor(
                          course: Offset(0.5 * width, 0.5 * height),
                          normal: Offset(0.5 * width, 0.5 * height)));
                  controller.moveCamera(
                    animation: animation,
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 18,
                        target: Point(
                          latitude: widget.latLong.lat,
                          longitude: widget.latLong.long,
                        ),
                      ),
                    ),
                  );

                },
                child: const Icon(Icons.my_location),
              ),
            ],
          ),
        );
      },
    );
  }
}
