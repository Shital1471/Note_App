import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:my_notbook/feature/presentation/cubit/user/user_cubit.dart';
import 'package:my_notbook/feature/presentation/pages/home_page.dart';
import 'package:my_notbook/feature/presentation/widgets/common.dart';
 class SignUpPage extends StatefulWidget {
   const SignUpPage({Key? key}) : super(key: key);

   @override
   State<SignUpPage> createState() => _SignUpPageState();
 }

 class _SignUpPageState extends State<SignUpPage> {
   TextEditingController _usernameController=TextEditingController();
   TextEditingController _emailController=TextEditingController();
   TextEditingController _passwordController=TextEditingController();

   GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();


   void dispose()
   {
     _usernameController.dispose();
     _emailController.dispose();
     _passwordController.dispose();
     super.dispose();
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       key:_globalKey,
       body: BlocConsumer<UserCubit,UserState>(
         builder: (context,userState)
         {
            if(userState is UserSuccess)
              {
                return BlocBuilder<AuthCubit,AuthState>(
                  builder: (context,authState){
                    if(authState is Authenticated)
                      {
                        return HomePage(uid:authState.uid,);
                      }
                    else
                      {
                        return _bodyWidget();
                      }
                  },
                );
              }
            return _bodyWidget();
         },
         listener: (context,userState){
           if(userState is UserState)
             {
               BlocProvider.of<AuthCubit>(context).loggedIn();
             }
           if(userState is UserFailure)
             {
               snackBarError(msg:"Invalid email",
               scaffoldState:_globalKey);
             }
         },
       ),
     );
   }

   _bodyWidget()
   {
     return Container(
       padding: EdgeInsets.all(25),
       child: Column(
         mainAxisAlignment:MainAxisAlignment.center,
         children: [
           SizedBox(
             height: 10,
           ),
           Container(
             height:50,
             padding: EdgeInsets.symmetric(horizontal: 10),
             decoration: BoxDecoration(
               color: Colors.black.withOpacity(0.1),
               borderRadius: BorderRadius.all(Radius.circular(10)),
             ),
             child: TextField(
               controller: _usernameController,
               decoration: InputDecoration(
                 hintText: 'Entre your Username',
                 border: InputBorder.none
               ),
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Container(
             height: 50,
             padding:EdgeInsets.symmetric(horizontal: 10),
             decoration: BoxDecoration(
               color: Colors.black.withOpacity(0.1),
               borderRadius:BorderRadius.all(Radius.circular(10)),
             ),
             child: TextField(
               controller: _emailController,
               decoration: InputDecoration(
                 hintText: 'Enter your email',
                 border: InputBorder.none,
               ),
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Container(
             height: 50,
             padding:EdgeInsets.symmetric(horizontal: 10),
             decoration: BoxDecoration(
               color: Colors.black.withOpacity(0.1),
               borderRadius:BorderRadius.all(Radius.circular(10)),
             ),
             child: TextField(
               obscureText: true,
               controller: _passwordController,
               decoration: InputDecoration(
                 hintText: 'Enter your password',
                 border: InputBorder.none,
               ),
             ),
           ),
           SizedBox(
             height: 15,
           ),
           GestureDetector(
             onTap: (){
               submitSignIn();
             },
             child: Container(
               height: 45,
               alignment: Alignment.center,
               width: MediaQuery.of(context).size.width/2,
               decoration: BoxDecoration(
                 color: Color(0xFFE65C4F),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
               ),
               child:Text(
                  "Create New Account",
                 style:TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                 ),
               ),
             ),
           ),
           SizedBox(
             height: 10,
           )
         ],
       ),
     );
   }


   void submitSignIn()
   {
     if(_usernameController.text.isNotEmpty && _emailController.text.isNotEmpty
     && _passwordController.text.isNotEmpty)
       {
         BlocProvider.of<UserCubit>(context).submitSignUp(user: UserEntity(
           email: _emailController.text,
           password: _passwordController.text,
         ));
       }
   }
 }
