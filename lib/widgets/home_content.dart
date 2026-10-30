
import 'package:firebase_depi2/dialogs/delete_dialog.dart';
import 'package:firebase_depi2/dialogs/edit_dialog.dart';
import 'package:firebase_depi2/home/add_student_screen.dart';
import 'package:firebase_depi2/home/controller/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});
@override
Widget build(BuildContext context) {
  return Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: ()async{
       final result=await Navigator.of(
          context,
      ).push<bool>(
        MaterialPageRoute(builder: (_) => AddStudentScreen(),)
      );
       if(!context.mounted)return;
       if(result == true){
        await context.read<HomeCubit>().getStudentsFromServer();
       }
       if(!context.mounted)return;
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(backgroundColor: Colors.green, content: Text('Student Added Success')), );
    },
      backgroundColor: Colors.orange,
      child: Icon(Icons.add,color: Colors.white,),),
    appBar:
    AppBar(
      backgroundColor: Colors.deepOrange,
      title:
      const Text('All Students'), ),
    body: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddStudentSuccess) {
          }
if (state is UpdateStudentSuccess) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text("Student edit success"),
    ),
  );
}
if(state is DeleteStudentSuccess){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text("Student  deleted success"),
    ),
  );
}
},
  builder: (context, state) {
    if (state is HomeLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.orange),
      );
    }

    if (state is GetStudentSuccess) {
      if (state.students.isEmpty) {
        return const Center(child: Text('No Students yet'));
      }

      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: state.students.length,
        itemBuilder: (context, index) {
          final student = state.students[index];

          return ListTile(
            title: Text('Name  ${student['name']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Age  ${student['age']}'),
                Text('Grade  ${student['grade']}'),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) async {
                final cubit = BlocProvider.of<HomeCubit>(context);
                if (value == 'edit') {
                  final updated = await showEditDialog(
                    context: context,
                    cubit: cubit,
                    id: student.id,
                    student: student.data(),
                  );
                  if (updated == true) {
                    await cubit.getStudentsFromServer();
                  }
                }

                if (value == 'delete') {
                  if(!context.mounted)return;
                   final deleted= await showDeleteStudentDialog(
                      context: context,
                      cubit: cubit,
                      id: student.id);

                   if(deleted==true){
                     await cubit.getStudentsFromServer();
                   }
                }
              },

              itemBuilder: (_) => [
                PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          );
        },
      );
    }

    return const SizedBox();
  },
),
);
} }