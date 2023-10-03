

 import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';

abstract class FirebaseRepository
 {
   Future<bool> isSignIn();
   Future<void> signIn(UserEntity user);
   Future<void> signOut();
   Future<String> getCurrentUId();
   Future<void> getCurrentUser(UserEntity user);
   Future<void> addNewNote(NoteEntity note);
   Future<void> updateNote(NoteEntity note);
   Future<void> deleteNote(NoteEntity note);
   Future<void> signUp(UserEntity user);
   Stream<List<NoteEntity>> getNotes(String uid);
 }