// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:yandex_mapexample/bloc/lat_long_bloc/lat_long_bloc.dart';
// import 'package:yandex_mapexample/screens/splash_page.dart';

// void main() {
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => LatLongBloc()..add(const GetLatLongEvent()),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashPage(),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyLinearProgressIndicator extends StatefulWidget {
  @override
  _MyLinearProgressIndicatorState createState() =>
      _MyLinearProgressIndicatorState();
}

class _MyLinearProgressIndicatorState extends State<MyLinearProgressIndicator> {
  double _progressValue = 0.5; // Example: Set the progress value here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linear Progress Indicator'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MyLinearProgressIndicator()));
}
