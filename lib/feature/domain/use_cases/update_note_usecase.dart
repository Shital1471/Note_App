
import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class UpdateNoteUseCase
{
  final FirebaseRepository repository;
  UpdateNoteUseCase({required this.repository});
  Future<void> call(NoteEntity note) async{
    return repository.updateNote(note);
  }
}