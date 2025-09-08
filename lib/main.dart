import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub_dashboard/core/di/get_it_service.dart';
import 'package:fruits_hub_dashboard/core/helper/on_generate_routes.dart';
import 'package:fruits_hub_dashboard/core/services/custom_bloc_observer.dart';
import 'package:fruits_hub_dashboard/core/services/supabase_storage.dart';
import 'package:fruits_hub_dashboard/features/dashboard/views/dashboard_view.dart';
import 'package:fruits_hub_dashboard/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();
  await SupabaseStorageServices.initSupabase();
  await SupabaseStorageServices.createBucket("fruits_images");
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupGetit();
  runApp(const FruitHubDashboard());
}

class FruitHubDashboard extends StatelessWidget {
  const FruitHubDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: DashboardView.routeName,
          onGenerateRoute: onGenerateRoutes,
        );
      },
    );
  }
}
