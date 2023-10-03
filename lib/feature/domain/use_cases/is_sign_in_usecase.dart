
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class IsSignInUseCase
{
  final FirebaseRepository repository;
  IsSignInUseCase({required this.repository});
  Future<bool> call() async{
    return repository.isSignIn();
  }
}