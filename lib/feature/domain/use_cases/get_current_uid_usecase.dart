

import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class GetCurrentIdUsecase
{
  final FirebaseRepository repository;
  GetCurrentIdUsecase({required this.repository});

  Future<String> call() async{
    return repository.getCurrentUId();
  }
}