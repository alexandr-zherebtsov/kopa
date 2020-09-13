import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopa/resources/colors.dart';
import 'package:kopa/screens/auth.dart';
import 'package:kopa/screens/reg.dart';
import 'core/bloc/user_auth_bloc/user_auth_bloc.dart';
import 'core/bloc/user_auth_bloc/user_auth_event.dart';
import 'core/bloc/user_auth_bloc/user_auth_state.dart';
import 'data/repositories/user_repositories.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(KopaApp());
}

class KopaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Kopa',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: darkGray,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BlocProvider<AuthBloc>(
            create: (context) =>
            AuthBloc(userRepository: UserRepositories())..add(AppStartEvent()),
            child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  print(state);
                  if (state is AuthInitialState) {
                    return AuthenticationScreen();
                  } else if (state is AuthSuccess) {
                    return Registration();
                  } else if (state is NoAuth) {
                    return AuthenticationScreen();
                  } else if (state is AuthLoading)
                    return Container(
                      child: CircularProgressIndicator(),
                    );
                  return Container();
                }),
          ));
  }
}
