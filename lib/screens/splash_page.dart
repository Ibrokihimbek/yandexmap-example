import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapexample/bloc/lat_long_bloc/lat_long_bloc.dart';
import 'package:yandex_mapexample/screens/map_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LatLongBloc, GetLatLongState>(
        listener: (context, state) {
          if (state.latLongStatus.isLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.latLongStatus.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => YandexAppPage(
                  latLong: state.latLong!,
                ),
              ),
            );
          }
        },
        builder: (_, state) {
          return const Center(
            child: CircularProgressIndicator()
          );
        },
      ),
    );
  }
}
