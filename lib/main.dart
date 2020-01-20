import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_online/authentication_bloc/bloc.dart';
import 'package:sales_online/user/user_repository.dart';
import 'package:sales_online/pages/home_screen.dart';
import 'package:sales_online/login/login.dart';
import 'package:sales_online/pages/splash_screen.dart';
import 'package:sales_online/blocs/simple_bloc_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(name: state.displayName);
          }
          return SplashScreen();
        },
      ),
      theme: ThemeData(
                primaryColor: Colors.red[800],
                accentColor: Colors.deepOrange[200],
                textTheme: TextTheme(
                    headline:
                        TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                    title:
                        TextStyle(fontSize: 26.0, fontStyle: FontStyle.italic),
                    body1: TextStyle(fontSize: 18.0))),
    );
  }
}
