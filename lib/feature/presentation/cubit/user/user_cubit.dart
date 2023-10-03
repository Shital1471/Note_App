import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/domain/use_cases/get_current_user_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/sign_in_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  UserCubit({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.getCurrentUserUsecase,
}) : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user}) async{
    emit(UserLoading());
    try{
      await signInUseCase.call(user);
      emit(UserSuccess());
    }on SocketException catch(_){
      emit(UserFailure());
    }catch(_)
    {
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async{
    emit(UserLoading());
    try{
      await signUpUseCase.call(user);
      await getCurrentUserUsecase.call(user);
      emit(UserSuccess());
    }on SocketException catch(_){
      emit(UserFailure());
    }catch(_)
    {
      emit(UserFailure());
    }
  }
}
