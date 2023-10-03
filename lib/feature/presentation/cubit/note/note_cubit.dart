import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_notbook/feature/domain/entities/note_entitie.dart';
import 'package:my_notbook/feature/domain/use_cases/add_new_notes_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/delete_notes_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/get_notes_usecase.dart';
import 'package:my_notbook/feature/domain/use_cases/update_note_usecase.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNotesUsecase deleteNotesUsecase;
  final GetNotesusecase getNotesusecase;
  final  AddNewNotesUsecase addNewNotesUsecase;
  NoteCubit({
    required this.getNotesusecase,
    required this.deleteNotesUsecase,
    required this.updateNoteUseCase,
    required this.addNewNotesUsecase,
}) : super(NoteInitial());

  Future<void> addNote({required NoteEntity note}) async{
    try{
      await addNewNotesUsecase.call(note);
    }on SocketException catch(_)
    {
      emit(NoteFailure());
    }catch(_)
    {
      emit(NoteFailure());
    }
  }
  Future<void> deleteNote({required NoteEntity note}) async{
    try{
      await deleteNotesUsecase.call(note);
    }on SocketException catch(_)
    {
      emit(NoteFailure());
    }catch(_)
    {
      emit(NoteFailure());
    }
  }
  Future<void> updateNote({required NoteEntity note}) async{
    try{
      await updateNoteUseCase.call(note);
    }on SocketException catch(_)
    {
      emit(NoteFailure());
    }catch(_)
    {
      emit(NoteFailure());
    }
  }
  Future<void> getNotes({required String uid}) async{
    try{
      getNotesusecase.call(uid).listen((notes) {
        emit(NoteLoaded(notes: notes));
      });
    }on SocketException catch(_)
    {
      emit(NoteFailure());
    }catch(_)
    {
      emit(NoteFailure());
    }
  }
}
