
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class SignInUseCase
{
  final FirebaseRepository repository;
  SignInUseCase({required this.repository});
  Future<void> call(UserEntity user) async{
    return repository.signIn(user);
  }
}