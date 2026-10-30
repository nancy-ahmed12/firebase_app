
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final cloud = FirebaseFirestore.instance;
  final String docName = 'students';

  final nameControl=TextEditingController();
  final ageControl=TextEditingController();
  final gradeControl=TextEditingController();

  Future<void>addStudentToServer()async{
    emit(HomeLoading());
    try{
      await cloud.collection(docName).add({
       'name':nameControl.text,
       'age':ageControl.text,
       'grade': gradeControl.text
      });
      emit(AddStudentSuccess());
    }
    catch(E){
      emit(HomeFailure(E.toString()));
    }
  }

  Future<void>getStudentsFromServer()async{
    emit(HomeLoading());
    try{
       final response= await cloud.collection(docName).get();
      emit(GetStudentSuccess(response.docs));
    }
    catch(e){
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void>deleteStudents(String id)async{
    emit(HomeLoading());
    try{
      await cloud.collection(docName ).doc(id).delete();
      emit(DeleteStudentSuccess());
    }
    catch(e){
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void>updateStudent(String id)async{
    emit(HomeLoading());
    try{
      await cloud.collection(docName).doc(id).update({
        'name':nameControl.text,
        'age':ageControl.text,
        'grade': gradeControl.text
      });
      emit(UpdateStudentSuccess());
    }
    catch(E){
      emit(HomeFailure(E.toString()));
    }
  }





  @override
  Future<void> close() {
    nameControl.dispose();
    ageControl.dispose();
    gradeControl.dispose();

    return super.close();
  }
}


  /*final nameControl = TextEditingController();
  final ageControl = TextEditingController();
  final gradeControl = TextEditingController();

  Future<void> addStudentToServer() async {
    emit(HomeLoading());

    try {
      await cloud.collection(collectionName).add({
        'name': nameControl.text,
        'age': ageControl.text,
        'grade': gradeControl.text,
      });
      emit(AddStudentSuccess());
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> getStudentsFromServer() async {
    emit(HomeLoading());

    try {
      final response= await cloud.collection(collectionName).get();
      emit(GetStudentSuccess(response.docs));

    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> deleteStudents(String id) async {
    emit(HomeLoading());

    try {
      await cloud.collection(collectionName).doc(id).delete();
      emit(DeleteStudentSuccess());
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> updateStudent(String id) async {
    emit(HomeLoading());

    try {
      await cloud.collection(collectionName).doc(id).update({

        'name': nameControl.text,
        'age': ageControl.text,
        'grade': gradeControl.text,
      });
      emit(UpdateStudentSuccess());

    } catch (E) {
      emit(HomeFailure(E.toString()));
    }
  }

  @override
  Future<void> close() {
    nameControl.dispose();
    ageControl.dispose();
    gradeControl.dispose();

    return super.close();
  }
}*/




