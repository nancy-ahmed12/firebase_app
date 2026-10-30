




import 'package:firebase_depi2/home/controller/home_cubit.dart';
import 'package:flutter/material.dart';

Future<bool?>showDeleteStudentDialog({
  required BuildContext context,
  required HomeCubit cubit,
  required String id
}){
  return showDialog<bool?>(
    context: context,
      builder: (dialogContext){
      return AlertDialog(
        title: Text('Delete Student'),
        content: Text('Are you sure you went to delete student?'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(dialogContext,false);
          },
              child: Text('Cancel')
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red
            ),
              onPressed: ()async{
            await cubit.deleteStudents(id);
            if(!dialogContext.mounted)return;
            if(cubit.state is DeleteStudentSuccess){
              Navigator.pop(dialogContext,true);
            }
          },
              child: Text('Delete',style: TextStyle(color: Colors.white),))
        ],
      );
      },);
}