import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notbook/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:my_notbook/feature/presentation/cubit/note/note_cubit.dart';
import 'package:my_notbook/feature/presentation/cubit/user/user_cubit.dart';
import 'package:my_notbook/feature/presentation/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_notbook/feature/presentation/pages/sign_in_page.dart';
import 'package:my_notbook/on_generate_route.dart';
import 'injection_container.dart' as di;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<NoteCubit>()),
      ],
      child: MaterialApp(
        title: 'My Notes',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(primarySwatch: Colors.deepOrange
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: const Color(0xFFE65C4F),
          ),
        ),
          initialRoute: '/',
          onGenerateRoute: OnGenerateRoute.route,
          routes: {
            "/": (context) {
              return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                    if (authState is Authenticated) {
                      return HomePage(uid: authState.uid,);
                    }
                    if (authState is UnAuthenticated) {
                      return SignInPage();
                    }
                    return CircularProgressIndicator();
                  }
              );
            }
          },
      ),
    );
  }
}

