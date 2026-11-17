import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gl_mobile_app/src/features/authentication/bloc/authentication/authenticate_event.dart';
import 'package:gl_mobile_app/src/features/authentication/bloc/authentication/authenticate_state.dart';
import 'package:gl_mobile_app/src/core/network/api_repository.dart';
import 'package:gl_mobile_app/src/features/authentication/model/login/login_req.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  final ApiRepository repository;

  AuthenticateBloc(this.repository) : super(AuthenticateInitial()) {
    on<AuthenticateSubmitted>((event, emit) async {
      emit(AuthenticateLoading());

      try {
        // Step 1: Authenticate API
        final authResponse = await repository.authenticate(event.request);
        final authData = authResponse.data;

        print('AUTH STATUS: ${authResponse.status?.jStatusCode}');
        print('AUTH MESSAGE: ${authResponse.status?.sResponseText}');
        print('AUTH DATA NULL: ${authData == null}');
        print('AUTH TOKEN EMPTY: ${(authData?.sAuthToken ?? '').isEmpty}');
        print('CLIENT ID EMPTY: ${(authData?.sClientAppID ?? '').isEmpty}');

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

        // Step 2: Generate password hash
        final passwordHash = sha512
            .convert(utf8.encode(event.password))
            .toString();

        // Step 3: Generate client app hash
        final clientAppKey = authData.sClientAppKey ?? '';
        final salt = authData.sSalt ?? '';

        if (clientAppKey.isEmpty || salt.isEmpty) {
          emit(
            AuthenticateFailure(
              'Client App Key or Salt is missing from authentication response.',
            ),
          );
          return;
        }

        final clientAppHash = sha512
            .convert(utf8.encode('$clientAppKey$salt'))
            .toString();

        print('LOGIN USERNAME: ${event.username}');
        print('PASSWORD HASH LENGTH: ${passwordHash.length}');
        print('CLIENT ID EMPTY: ${(authData.sClientAppID ?? '').isEmpty}');
        print('AUTH TOKEN EMPTY: ${(authData.sAuthToken ?? '').isEmpty}');

        // Step 4: Login API
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
        print(
          'LOGIN SESSION EMPTY: ${(loginResponse?.suidSession ?? '').isEmpty}',
        );

        // Step 5: Only accept a successful login with a session
        if (loginResponse != null &&
            loginResponse.status?.jStatusCode == 0 &&
            loginResponse.suidSession.isNotEmpty) {
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
