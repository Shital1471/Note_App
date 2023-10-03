import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notbook/app_const.dart';
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:my_notbook/feature/presentation/cubit/user/user_cubit.dart';
import 'package:my_notbook/feature/presentation/pages/home_page.dart';
import 'package:my_notbook/feature/presentation/widgets/common.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  GlobalKey<ScaffoldState>_scaffoldGlobalKey=GlobalKey<ScaffoldState>();

  void dispose()
  {
    _emailController.dispose();
    _passwordController.dispose();
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldGlobalKey,
      body: BlocConsumer<UserCubit,UserState>(
        builder: (context,userState)
        {
          if(userState is UserSuccess)
            {
              return BlocBuilder<AuthCubit,AuthState>(builder:(context,authState){
                if(authState is Authenticated)
                  {
                    return HomePage(uid: authState.uid);
                  }
                else{
                  return _bodyWidget();
                }
              });
            }
          return _bodyWidget();
        },
        listener: (context,userState){
          if(userState is UserSuccess)
            {
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
          if(userState is UserFailure)
            {
              snackBarError(msg: "Invalid email",scaffoldState: _scaffoldGlobalKey);
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: 120,
              child: Image.asset("asset/notebook.png"),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child:TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter Your email',
                border:InputBorder.none
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration:InputDecoration(
                hintText: 'Enter your Password',
                border: InputBorder.none
              ),
            ),
          ),
          SizedBox(
            height: 20,
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
                color: Color(0xFFE65C4F).withOpacity(0.8),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(context, PageConst.signUpPage, (route) => false);
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(10),
                ),
              ),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



  void submitSignIn()
  {
    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty)
      {
        BlocProvider.of<UserCubit>(context).submitSignIn(user: UserEntity(
          email: _emailController.text,
          password: _passwordController.text,
        ));
      }
  }
}
