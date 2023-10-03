

import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class AddNewNotesUsecase
{
  final FirebaseRepository repository;
  AddNewNotesUsecase({required this.repository});

  Future<void> call(NoteEntity note) async{
    return repository.addNewNote(note);
  }
}