import 'package:gl_mobile_app/src/features/authentication/model/authenticate/authenticate_req.dart';
import 'package:gl_mobile_app/src/features/authentication/model/login/login_req.dart';

abstract class AuthenticateEvent {}

//Authenticate first, then Login
class AuthenticateSubmitted extends AuthenticateEvent {
  final AuthenticateReq request;
  final String username;
  final String password;

  AuthenticateSubmitted({
    required this.request,
    required this.username,
    required this.password,
  });
}

//Keep this event for existing direct Login calls if needed.
class LoginSubmitted extends AuthenticateEvent {
  final LoginReq request;

  LoginSubmitted(this.request);
}
