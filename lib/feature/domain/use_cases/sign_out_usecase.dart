
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class SignOutUseCase
{
  final FirebaseRepository repository;
  SignOutUseCase({required this.repository});
  Future<void> call() async{
    return repository.signOut();
  }
}