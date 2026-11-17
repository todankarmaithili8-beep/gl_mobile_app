import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gl_mobile_app/src/core/session/session_manager.dart';
import 'package:gl_mobile_app/src/core/network/api_repository.dart';

import 'package:gl_mobile_app/src/features/authentication/bloc/authentication/authenticate_event.dart';
import 'package:gl_mobile_app/src/features/authentication/bloc/authentication/authenticate_state.dart';
import 'package:gl_mobile_app/src/features/authentication/model/login/login_req.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  final ApiRepository repository;

  AuthenticateBloc(this.repository) : super(AuthenticateInitial()) {
    on<AuthenticateSubmitted>((event, emit) async {
      emit(AuthenticateLoading());

      try {
        final authResponse = await repository.authenticate(event.request);

        final authData = authResponse.data;

        print('AUTH STATUS: ${authResponse.status?.jStatusCode}');
        print('AUTH MESSAGE: ${authResponse.status?.sResponseText}');

        if (authData == null ||
            (authData.sAuthToken ?? '').isEmpty ||
            (authData.sClientAppID ?? '').isEmpty) {
          emit(
            AuthenticateFailure(
              'Authentication response is missing required details.',
            ),
          );
          return;
        }

        final passwordHash = sha512
            .convert(utf8.encode(event.password))
            .toString();

        final clientAppKey = authData.sClientAppKey ?? '';
        final salt = authData.sSalt ?? '';

        if (clientAppKey.isEmpty || salt.isEmpty) {
          emit(AuthenticateFailure('Client App Key or Salt is missing.'));
          return;
        }

        final clientAppHash = sha512
            .convert(utf8.encode('$clientAppKey$salt'))
            .toString();

        final loginResponse = await repository.login(
          LoginReq(
            sUsername: event.username,
            sTimeZone: DateTime.now().timeZoneName,
            sTag: '',
            sPasswordHash: passwordHash,
          ),
          authToken: authData.sAuthToken!,
          clientAppID: authData.sClientAppID!,
          clientAppHash: clientAppHash,
        );

        print('LOGIN STATUS: ${loginResponse?.status?.jStatusCode}');
        print('LOGIN MESSAGE: ${loginResponse?.status?.sResponseText}');

        if (loginResponse != null &&
            loginResponse.status?.jStatusCode == 0 &&
            loginResponse.suidSession.isNotEmpty) {
          //Save session for 24 hours
          await SessionManager.saveSession(
            loginResponse.suidSession,
            username: event.username,
            authToken: authData.sAuthToken!,
          );

          print('LOGIN SESSION SAVED SUCCESSFULLY');

          emit(LoginSuccess(loginResponse));
        } else {
          emit(
            AuthenticateFailure(
              loginResponse?.status?.sResponseText ??
                  'Login failed. Please check your credentials.',
            ),
          );
        }
      } catch (e, stackTrace) {
        print('AUTHENTICATION ERROR: $e');
        print('AUTHENTICATION STACKTRACE: $stackTrace');

        emit(AuthenticateFailure(e.toString().replaceFirst('Exception: ', '')));
      }
    });

    on<LoginSubmitted>((event, emit) async {
      emit(AuthenticateLoading());

      emit(
        AuthenticateFailure(
          'Please use AuthenticateSubmitted to run the complete login flow.',
        ),
      );
    });
  }
}
