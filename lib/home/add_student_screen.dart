
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/home_cubit.dart';
class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});
@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => HomeCubit(),
    child: const AddStudentForm(),
  ); } }
class AddStudentForm extends StatelessWidget {
  const AddStudentForm({super.key});
@override
Widget build(BuildContext context) {
  final cubit = context.read<HomeCubit>();
return Scaffold(
  backgroundColor: Colors.white,
  appBar: AppBar(
    title: const Text('Add Your Data'),
    backgroundColor: Colors.white,
    foregroundColor: Colors.orange,
    centerTitle: true,
  ),
  body: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please Enter Your Data',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: cubit.nameControl,
          decoration: const InputDecoration(
            hintText: 'Name',
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: cubit.ageControl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Age',
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: cubit.gradeControl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Grade',
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () async {
              if (cubit.nameControl.text.trim().isEmpty ||
                  cubit.ageControl.text.trim().isEmpty ||
                  cubit.gradeControl.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Please enter all student data'),
                  ),
                );
                return;
              }

              await cubit.addStudentToServer();

              if (!context.mounted) return;

              if (cubit.state is AddStudentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Student added successfully'),
                  ),
                );
                cubit.nameControl.clear();
                cubit.ageControl.clear();
                cubit.gradeControl.clear();
                Navigator.pop(context,true);
              } else if (cubit.state is HomeFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((cubit.state as HomeFailure).msg),
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ),
      ],
    ),
  ),
);
} }