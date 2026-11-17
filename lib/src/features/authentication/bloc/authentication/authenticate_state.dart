import 'package:gl_mobile_app/src/features/authentication/model/authenticate/authenticate_rsp.dart';
import 'package:gl_mobile_app/src/features/authentication/model/login/login_rsp.dart';

abstract class AuthenticateState {}

class AuthenticateInitial extends AuthenticateState {}

class AuthenticateLoading extends AuthenticateState {}

// Existing Authenticate success
class AuthenticateSuccess extends AuthenticateState {
  final AuthResponse response;

  AuthenticateSuccess(this.response);
}

// New Login success
class LoginSuccess extends AuthenticateState {
  final LoginRsp response;

  LoginSuccess(this.response);
}

class AuthenticateFailure extends AuthenticateState {
  final String message;

  AuthenticateFailure(this.message);
}
