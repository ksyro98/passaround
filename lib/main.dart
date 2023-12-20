import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passaround/features/auth/data/auth_repository.dart';
import 'package:passaround/features/auth/data/firebase_authentication.dart';
import 'package:passaround/features/share/data/firebase/share_firebase.dart';
import 'package:passaround/navigation/main_go_router.dart';
import 'package:passaround/features/share/bloc/share_bloc.dart';
import 'package:passaround/features/share/data/share_repository.dart';
import 'package:passaround/utils/firebase_utils.dart';
import 'package:passaround/utils/constants.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/profile/bloc/profile_bloc.dart';
import 'features/profile/data/firebase_authentication_user_manager.dart';
import 'features/profile/data/profile_repository.dart';
import 'utils/configuration/configure_nonweb.dart' if (dart.library.html) 'utils/configuration/configure_web.dart';

Future<void> main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ShareRepository(ShareFirebase())),
        RepositoryProvider(create: (context) => AuthRepository(FirebaseAuthentication())),
        RepositoryProvider(create: (context) => ProfileRepository(FirebaseAuthenticationUserManager())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ShareBloc(context.read<ShareRepository>())),
          BlocProvider(create: (context) => AuthBloc(context.read<AuthRepository>())),
          BlocProvider(create: (context) => ProfileBloc(context.read<ProfileRepository>())),
        ],
        child: DynamicColorBuilder(builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return MaterialApp.router(
            title: 'PassAround',
            theme: ThemeData(colorScheme: _getLightColorScheme(lightDynamic), useMaterial3: true),
            darkTheme: ThemeData(colorScheme: _getDarkColorScheme(darkDynamic), useMaterial3: true),
            routerConfig: MainGoRouter().get(),
            debugShowCheckedModeBanner: false,
          );
        }),
      ),
    );
  }

  ColorScheme _getLightColorScheme(ColorScheme? lightDynamic) =>
      lightDynamic ?? ColorScheme.fromSeed(seedColor: ColorValues.mainColor);

  ColorScheme _getDarkColorScheme(ColorScheme? darkDynamic) =>
      darkDynamic ?? ColorScheme.fromSeed(seedColor: ColorValues.mainColor, brightness: Brightness.dark);
}
