import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_repair/cubits/app_cubits.dart';
import 'package:shoe_repair/routes/app_routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shoe_repair/services/preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isFirstLaunch = await PreferenceService().isFirstLaunch();
  runApp(
    DevicePreview(
      enabled: true, 
      builder: (context) => App(isFirstLaunch: isFirstLaunch,),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.isFirstLaunch,
  });

  final bool isFirstLaunch;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppCubits.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        //routes
        initialRoute: isFirstLaunch ? AppRoutes.introScreen : AppRoutes.homeScreen,
        routes: AppRoutes.routes,
        
      ),
    );
  }
}
