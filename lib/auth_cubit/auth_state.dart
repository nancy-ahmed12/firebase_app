part of 'auth_cubit.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}
 class RegisterLoading extends AuthState{}
class RegisterSuccess extends AuthState{}
class RegisterFailure extends AuthState{
  final String msg;
  RegisterFailure(this.msg);
}

class GetStudentSuccess extends HomeState{
  final List<QueryDocumentSnapshot<Map<String,dynamic>>>students;
  GetStudentSuccess(this.students);

}

class AddStudentSuccess extends HomeState{}
class EditStudentSuccess extends HomeState{}
class DeleteStudentSuccess extends HomeState{}
