

import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class GetCurrentUserUsecase
{
  final FirebaseRepository repository;
  GetCurrentUserUsecase({required this.repository});

  Future<void> call(UserEntity user) async{
    return repository.getCurrentUser(user);
  }
}