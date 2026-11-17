import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gl_mobile_app/src/features/authentication/model/authenticate/authenticate_req.dart';
import 'package:gl_mobile_app/src/core/network/api_repository.dart';
import 'package:gl_mobile_app/src/features/authentication/bloc/authentication/authenticate_bloc.dart';
import 'package:gl_mobile_app/src/features/authentication/bloc/authentication/authenticate_event.dart';
import 'package:gl_mobile_app/src/features/authentication/bloc/authentication/authenticate_state.dart';
import 'package:gl_mobile_app/src/features/trip/ui/trip_list_screen.dart';
import 'package:gl_mobile_app/src/core/session/session_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  static const Color primaryBlue = Color(0xFF10466B);
  static const Color secondaryBlue = Color(0xFF4A9FE3);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (!_formKey.currentState!.validate()) return;

    final request = AuthenticateReq(
      sAuthKey: '08fada2d-eb9c-47d2-9087-25858d5d89bc',
    );

    context.read<AuthenticateBloc>().add(
      AuthenticateSubmitted(
        request: request,
        username: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticateBloc, AuthenticateState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          final session = state.response.suidSession;
          final username = state.response.objUser?.sUsername ?? '';

          print('LOGIN SESSION EMPTY: ${session.isEmpty}');
          print('LOGIN SESSION LENGTH: ${session.length}');

          if (session.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Session is missing from login response.'),
              ),
            );
            return;
          }

          final apiRepository = context.read<ApiRepository>();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => TripListScreen(
                apiRepository: apiRepository,
                suidSession: session,
                username: username,
                vehicleNumber: '',
              ),
            ),
            (route) => false,
          );
        } else if (state is AuthenticateFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FA),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/GLKolhapurMilkRun.png',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Ghatge Logistics',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Milk Run',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: secondaryBlue),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthenticateBloc, AuthenticateState>(
                      builder: (context, state) {
                        final isLoading = state is AuthenticateLoading;

                        return SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _submitLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              foregroundColor: Colors.white,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'SUBMIT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
