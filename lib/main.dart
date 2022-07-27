import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/business_logic/cubit/cubit.dart';
import 'package:to_do_list/presentation/screens/board_screen.dart';
import 'package:to_do_list/services/notification_service.dart';

import 'business_logic/bloc_observe.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initializeNotification();
  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..initDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              )
            ),
          textTheme:  const TextTheme(
            bodyMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            bodySmall: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
          )
        ),
        home: const BoardScreen(),
      ),
    );
  }
}
