import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:gl_mobile_app/src/core/network/api_rest_client.dart';
import 'package:gl_mobile_app/src/core/network/api_repository.dart';
import 'package:gl_mobile_app/src/core/session/auth_gate.dart';
import 'package:gl_mobile_app/src/features/authentication/bloc/authentication/authenticate_bloc.dart';
import 'package:gl_mobile_app/src/features/authentication/ui/login_screen.dart';

import 'package:gl_mobile_app/src/features/trip/bloc/update_trip_and_supplier_pickup/update_trip_and_supplier_pickup_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MilkRunApp());
}

class MilkRunApp extends StatelessWidget {
  const MilkRunApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://glplkmilkrun.giplapp.in',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(hours: 5),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    );

    final apiClient = ApiRestClient(dio);
    final apiRepository = ApiRepository(apiClient);

    return RepositoryProvider<ApiRepository>.value(
      value: apiRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticateBloc>(
            create: (_) => AuthenticateBloc(apiRepository),
          ),

          BlocProvider<UpdateTripAndSupplierPickupBloc>(
            create: (_) => UpdateTripAndSupplierPickupBloc(apiRepository),
          ),
        ],
        child: MaterialApp(
          title: 'Ghatge Logistics - Milk Run',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF10466B),
            ),
            scaffoldBackgroundColor: const Color(0xFFF4F7FA),
          ),
          home: const AuthGate(),
        ),
      ),
    );
  }
}
