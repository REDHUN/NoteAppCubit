// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:noteapp/feature/domain/entities/note_entity.dart';
import 'package:noteapp/feature/domain/usecases/add_new_task_usecase.dart';
import 'package:noteapp/feature/domain/usecases/delete_note_usecase.dart';
import 'package:noteapp/feature/domain/usecases/get_notes_usecase.dart';
import 'package:noteapp/feature/domain/usecases/update_note_usecase.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNoteUseCase getNoteUseCase;
  final AddNewNoteUseCase addNewNoteUseCase;

  NoteCubit({
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.getNoteUseCase,
    required this.addNewNoteUseCase,
  }) : super(NoteInitial());

  Future<void> addNote({required NoteEntity note}) async {
    try {
      await addNewNoteUseCase.call(note);
    } on SocketException catch (_) {
      emit(NoteFailture());
    } catch (_) {
      emit(NoteFailture());
    }
  }

  Future<void> deleteNote({required NoteEntity note}) async {
    try {
      await deleteNoteUseCase.call(note);
    } on SocketException catch (_) {
      emit(NoteFailture());
    } catch (_) {
      emit(NoteFailture());
    }
  }

  Future<void> updateNote({required NoteEntity note}) async {
    try {
      await updateNoteUseCase.call(note);
    } on SocketException catch (_) {
      emit(NoteFailture());
    } catch (_) {
      emit(NoteFailture());
    }
  }

  Future<void> getNote({required String uid}) async {
    emit(NoteLoading());
    try {
      getNoteUseCase.call(uid).listen((notes) {
        emit(NoteLoaded(notes: notes));
      });
    } on SocketException catch (_) {
      emit(NoteFailture());
    } catch (_) {
      emit(NoteFailture());
    }
  }
}
