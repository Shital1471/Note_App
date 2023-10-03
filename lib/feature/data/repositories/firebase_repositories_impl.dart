
import 'package:my_notbook/feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/domain/entities/user_enitity.dart';
import 'package:my_notbook/feature/domain/repositories/firebase_repositories.dart';

class FirebaseRepositoryImpl extends FirebaseRepository{
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({
    required this.remoteDataSource
});
  @override
  Future<void> addNewNote(NoteEntity note) async =>
      remoteDataSource.addNewNote(note);

  @override
  Future<void> deleteNote(NoteEntity note) async =>
      remoteDataSource.deleteNote(note);

  @override
  Future<String> getCurrentUId() async =>remoteDataSource.getCurrentUId();

  @override
  Future<void> getCurrentUser(UserEntity user) async =>
      remoteDataSource.getCurrentUser(user);

  @override
  Stream<List<NoteEntity>> getNotes(String uid)  =>
      remoteDataSource.getNotes(uid);

  @override
  Future<bool> isSignIn() async =>remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  @override
  Future<void> updateNote(NoteEntity note) async => remoteDataSource.updateNote(note);

}