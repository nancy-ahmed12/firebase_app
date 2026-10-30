

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_cubit/auth_cubit.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {

            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Login Success")),
              );
            }

            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.msg),
                ),
              );
            }
          },
          builder: (context, state) {
            final loadingState = state is RegisterLoading;
            final cubit = BlocProvider.of<AuthCubit>(context);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset('assets/images/signup.jpg',
                    height: 300,
                      width:200 ,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 100,),
                    Text(
                      'Enter your Email Add\nPassword to create your account',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF25264F)
                      ),
                    ),
                    SizedBox(height: 20,),

                    TextFormField(
                      controller: cubit.emailRegisterControl,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF3F3F3),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF3F3F3)),
                        ),
                        hintText: 'Email',
                      ),
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      controller: cubit.passwordRegisterControl,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF3F3F3),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF3F3F3)),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(height: 40,),

                    ElevatedButton(
                      onPressed: () {
                        cubit.signUP();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromHeight(50),
                        backgroundColor: Colors.indigo,
                      ),
                      child:
                      loadingState?Center(child: CircularProgressIndicator(
                        color: Colors.white,
                      ),):
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}