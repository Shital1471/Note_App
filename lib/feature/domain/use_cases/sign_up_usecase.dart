
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class SignUpUseCase
{
  final FirebaseRepository repository;
  SignUpUseCase({required this.repository});
  Future<void> call(UserEntity user) async{
    return repository.signUp(user);
  }
}