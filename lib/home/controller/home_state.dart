

part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String msg;
  HomeFailure(this.msg);
}

class GetStudentSuccess extends HomeState {
  final List<QueryDocumentSnapshot<Map<String,dynamic>>>students;
  GetStudentSuccess(this.students);
}

class AddStudentSuccess extends HomeState{}

class UpdateStudentSuccess extends HomeState{}

class DeleteStudentSuccess extends HomeState{}
