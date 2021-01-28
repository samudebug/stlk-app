import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stlk/blocs/authentication/authentication_bloc.dart';
import 'package:influencer_repository/influencer_repository.dart';
import 'package:stlk/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stlk/pages/login_page.dart';
import 'package:stlk/pages/splash_page.dart';
import 'package:api_repository/api_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  const apiRepository = APIRepository();
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  InfluencerRepository influencerRepository = InfluencerRepository(
      apiRepository: apiRepository,
      authenticationRepository: authenticationRepository);
  runApp(App(
      authenticationRepository: authenticationRepository,
      userRepository: UserRepository(
        apiRepository: apiRepository,
      ),
      influencerRepository: influencerRepository));
}

class App extends StatelessWidget {
  const App(
      {Key key,
      @required this.authenticationRepository,
      @required this.userRepository,
      @required this.influencerRepository})
      : assert(authenticationRepository != null),
        assert(userRepository != null),
        assert(influencerRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final InfluencerRepository influencerRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => authenticationRepository,
        ),
        RepositoryProvider(
          create: (_) => userRepository,
        ),
        RepositoryProvider(
          create: (_) => influencerRepository,
        )
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Projet STLK",
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            } else if (state is AuthenticationUnauthenticated) {
              _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (context) => SplashPage()),
    );
  }
}
