
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:my_notbook/feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'package:my_notbook/feature/data/remote/data_sources/firebase_remote_data_source_impl.dart';
import 'package:my_notbook/feature/data/repositories/firebase_repositories_impl.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';
import 'package:my_notbook/feature/domain/use_cases/add_new_notes_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/delete_notes_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/get_current_user_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/get_notes_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/is_sign_in_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/sign_in_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/sign_out_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/sign_up_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/update_note_usecase.dart';
import 'package:my_notbook/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:my_notbook/feature/presentation/cubit/note/note_cubit.dart';
import 'package:my_notbook/feature/presentation/cubit/user/user_cubit.dart';

import 'feature/domain/use_cases/get_current_uid_usecase.dart';
GetIt sl=GetIt.instance;

Future<void> init() async{
//Cubit/Bloc

sl.registerFactory<AuthCubit>(() => AuthCubit(
    isSignInUseCase: sl.call(),
    signOutUsecase: sl.call(),
    getCurrentIdUseCase: sl.call()));

sl.registerFactory<UserCubit>(() => UserCubit(
    signUpUseCase: sl.call(),
    signInUseCase: sl.call(),
    getCurrentUserUsecase: sl.call()));

sl.registerFactory<NoteCubit>(() => NoteCubit(
    getNotesusecase: sl.call(),
    deleteNotesUsecase: sl.call(),
    updateNoteUseCase: sl.call(),
    addNewNotesUsecase: sl.call()));

//UseCase
sl.registerLazySingleton<AddNewNotesUsecase>(
        () => AddNewNotesUsecase(repository: sl.call()));
sl.registerLazySingleton<DeleteNotesUsecase>(
        () => DeleteNotesUsecase(repository: sl.call()));
sl.registerLazySingleton<GetCurrentIdUsecase>(
        () => GetCurrentIdUsecase(repository: sl.call()));
sl.registerLazySingleton<GetCurrentUserUsecase>(
        () => GetCurrentUserUsecase(repository: sl.call()));
sl.registerLazySingleton<GetNotesusecase>(
        () => GetNotesusecase(repository: sl.call()));
sl.registerLazySingleton<IsSignInUseCase>(
        () => IsSignInUseCase(repository: sl.call()));
sl.registerLazySingleton<SignInUseCase>(
        () => SignInUseCase(repository: sl.call()));
sl.registerLazySingleton<SignOutUseCase>(
        () => SignOutUseCase(repository: sl.call()));
sl.registerLazySingleton<SignUpUseCase>(
        () => SignUpUseCase(repository: sl.call()));
sl.registerLazySingleton<UpdateNoteUseCase>(
        () => UpdateNoteUseCase(repository: sl.call()));


//repository

sl.registerLazySingleton<FirebaseRepository>(() =>FirebaseRepositoryImpl(remoteDataSource: sl.call()));

//data source

sl.registerLazySingleton<FirebaseRemoteDataSource>(
        () => FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));


// External
final auth=FirebaseAuth.instance;
final fireStore=FirebaseFirestore.instance;

sl.registerLazySingleton(() => auth);
sl.registerLazySingleton(() => fireStore);
}