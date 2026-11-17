import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gl_mobile_app/src/core/network/api_repository.dart';
import 'package:gl_mobile_app/src/core/session/session_manager.dart';

import 'package:gl_mobile_app/src/features/authentication/ui/login_screen.dart';
import 'package:gl_mobile_app/src/features/trip/ui/trip_list_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<Map<String, dynamic>?> _loadSession() async {
    final isValid = await SessionManager.isSessionValid();

    if (!isValid) {
      return null;
    }

    final session = await SessionManager.getSession();
    final username = await SessionManager.getUsername();
    final vehicleNumber = await SessionManager.getVehicleNumber();

    if (session == null || session.isEmpty) {
      return null;
    }

    return {
      'session': session,
      'username': username,
      'vehicleNumber': vehicleNumber,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _loadSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const LoginScreen();
        }

        final savedData = snapshot.data;

        if (savedData != null) {
          return TripListScreen(
            apiRepository: context.read<ApiRepository>(),
            suidSession: savedData['session'] as String,
            username: savedData['username'] as String,
            vehicleNumber: savedData['vehicleNumber'] as String,
          );
        }

        return const LoginScreen();
      },
    );
  }
}
