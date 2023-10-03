

import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class GetNotesusecase
{
  final FirebaseRepository repository;
  GetNotesusecase({required this.repository});

  Stream<List<NoteEntity>> call(String uid) {
    return repository.getNotes(uid);
  }
}