
import 'package:firebase_depi2/home/add_student_screen.dart';
import 'package:firebase_depi2/home/controller/home_view.dart';
import 'package:firebase_depi2/register/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'auth_cubit/auth_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Authentication',
        home: Signup()
    );
  }
}

