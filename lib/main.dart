import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web_app/firebase_options.dart';
import 'package:web_app/functions/firebase/firestore.dart';
import 'package:web_app/models/admin.dart';
import 'package:web_app/models/family.dart';
import 'package:web_app/models/user.dart';
import 'package:web_app/screens/auth/bloc/auth_bloc.dart';
import 'package:web_app/screens/auth/desktop.dart';
import 'package:web_app/screens/auth/mobile.dart';
import 'package:web_app/screens/home/bloc/home_bloc.dart';
import 'package:web_app/screens/home/desktop.dart';
import 'package:web_app/screens/home/mobile/bloc/tab_bar_bloc.dart';
import 'package:web_app/screens/home/mobile/mobile.dart';
import 'package:web_app/screens/settings/desktop.dart';
import 'package:web_app/screens/settings/mobile.dart';
import 'package:web_app/widgets/build_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await Hive.initFlutter();
    Hive
      ..registerAdapter(AdminModelAdapter())
      ..registerAdapter(UserModelAdapter())
      ..registerAdapter(FamilyModelAdapter());

    runApp(const MyApp());
  } catch (e) {
    print('Error during initialization: $e');
    runApp(const ErrorApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<FireStoreRepository>(
          create: (context) => FireStoreRepository(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            RepositoryProvider.of<FireStoreRepository>(context),
          ),
        ),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<TabBloc>(create: (context) => TabBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Admin Web App',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const BuildLayout(
          desktop: HomeScreenDesktop(),
          mobile: HomeScreenMobile(),
        );
      },
    ),
    GoRoute(
      path: '/homeScreen',
      builder: (BuildContext context, GoRouterState state) {
        return const BuildLayout(
          desktop: HomeScreenDesktop(),
          mobile: HomeScreenMobile(),
        );
      },
    ),
    GoRoute(
      path: '/settingsScreen',
      builder: (BuildContext context, GoRouterState state) {
        return const BuildLayout(
          desktop: SettingsScreenDesktop(),
          mobile: SettingsScreenMobile(),
        );
      },
    ),
    GoRoute(
      path: '/authScreen',
      builder: (BuildContext context, GoRouterState state) {
        return const BuildLayout(
          desktop: AuthDesktop(),
          mobile: AuthMobile(),
        );
      },
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    final bool goingToAuth = state.uri.toString() == '/authScreen';

    if (!loggedIn && !goingToAuth) {
      return '/authScreen';
    }
    if (loggedIn && goingToAuth) {
      return '/';
    }
    return null;
  },
);

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('An error occurred during initialization.'),
        ),
      ),
    );
  }
}
