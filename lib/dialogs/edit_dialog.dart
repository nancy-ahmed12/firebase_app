
import 'package:firebase_depi2/home/controller/home_cubit.dart';
import 'package:flutter/material.dart%20';

Future<bool?>showEditDialog({
  required BuildContext context,
  required HomeCubit cubit,
  required String id ,
  required Map<String,dynamic>student
})

{
  return showDialog<bool>(
  context: context,
  builder: (dialogContext){
    cubit.nameControl.text=student['name'];
    cubit.ageControl.text=student['age'];
    cubit.gradeControl.text=student['grade'];


    return AlertDialog(
      title: Text('Edit Student'),
      content: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            TextField(
              controller: cubit.nameControl,
              decoration: InputDecoration(hintText: 'Name',border: OutlineInputBorder()),
            ),
            TextField(
              controller: cubit.ageControl,
              decoration: InputDecoration(hintText: 'Age',border: OutlineInputBorder()),
            ),
            TextField(
              controller: cubit.gradeControl,
              decoration: InputDecoration(hintText: 'Grade',border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(dialogContext,false);
        },
            child: Text('Cancel')),
        ElevatedButton( onPressed: () async {
          if (cubit.nameControl.text.trim().isEmpty ||
          cubit.ageControl.text.trim().isEmpty ||
          cubit.gradeControl.text.trim().isEmpty) {
            ScaffoldMessenger.of(dialogContext).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text("Please fill the fields"), ), );
            return; }
          await cubit.updateStudent(id);

          if (!dialogContext.mounted) return;

          if (cubit.state is UpdateStudentSuccess) {
          Navigator.pop(dialogContext, true);
          } else if (cubit.state is HomeFailure) {
          ScaffoldMessenger.of(dialogContext).showSnackBar(
          SnackBar(
          content: Text((cubit.state as HomeFailure).msg),
          ),
          );
          }
        }, child: const Text('Save'), )

      ],

    );
  },);
}
