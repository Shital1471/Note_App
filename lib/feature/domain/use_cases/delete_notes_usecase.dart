

import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class DeleteNotesUsecase
{
  final FirebaseRepository repository;
  DeleteNotesUsecase({required this.repository});

  Future<void> call(NoteEntity note) async{
    return repository.deleteNote(note);
  }
}