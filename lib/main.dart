import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/local/local_wiki_bloc.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/remote/remote_wiki_bloc.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/web/web_bloc.dart';
import 'package:freo_assignment/features/wiki/presentation/pages/splash/splash_screen.dart';
import 'package:freo_assignment/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteWikiBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<LocalPageBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<WebBloc>(
          create: (context) => sl(),
        ),
      ],
      child: MaterialApp(
          title: 'Freo Assignment',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen()),
    );
  }
}
