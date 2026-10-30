import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_depi2/home/controller/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart ';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
final fireAuth = FirebaseAuth.instance;
TextEditingController emailRegisterControl = TextEditingController();
  TextEditingController passwordRegisterControl = TextEditingController();

  get emailLoginControl => null;

  get passwordLoginControl => null;
  Future<void>signUP()async{
    emit(RegisterLoading());

    try {
      await fireAuth.createUserWithEmailAndPassword(
        email: emailRegisterControl.text,
        password: passwordRegisterControl.text ,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure('The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  Future<void> checkEmailVerification() async {}

  Future<void> resendVerificationEmail() async {}
}
