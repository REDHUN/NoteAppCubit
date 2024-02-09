import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:noteapp/feature/data/remote/remote_data_source.dart';
import 'package:noteapp/feature/data/remote/remote_data_source_impl.dart';
import 'package:noteapp/feature/data/repositories/firebase_respository_impl.dart';
import 'package:noteapp/feature/domain/repositories/firebase_respository.dart';
import 'package:noteapp/feature/domain/usecases/add_new_task_usecase.dart';
import 'package:noteapp/feature/domain/usecases/delete_note_usecase.dart';
import 'package:noteapp/feature/domain/usecases/get_create_current_user_usecase.dart';
import 'package:noteapp/feature/domain/usecases/get_current_uid_usecase.dart';
import 'package:noteapp/feature/domain/usecases/get_notes_usecase.dart';
import 'package:noteapp/feature/domain/usecases/is_sign_in_usecase.dart';
import 'package:noteapp/feature/domain/usecases/sign_in_usecase.dart';
import 'package:noteapp/feature/domain/usecases/sign_out_usecase.dart';
import 'package:noteapp/feature/domain/usecases/sign_up_usecase.dart';
import 'package:noteapp/feature/domain/usecases/update_note_usecase.dart';
import 'package:noteapp/feature/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:noteapp/feature/presentation/cubit/note/cubit/note_cubit.dart';
import 'package:noteapp/feature/presentation/cubit/user/cubit/user_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
//Cubit/Bloc

  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUidUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call()));

  sl.registerFactory<UserCubit>(() => UserCubit(
        getCreateCurrentUserUseCase: sl.call(),
        signInUseCase: sl.call(),
        signUpUseCase: sl.call(),
      ));
  sl.registerFactory<NoteCubit>(() => NoteCubit(
      addNewNoteUseCase: sl.call(),
      deleteNoteUseCase: sl.call(),
      getNoteUseCase: sl.call(),
      updateNoteUseCase: sl.call()));

//useCase
  sl.registerLazySingleton<AddNewNoteUseCase>(
      () => AddNewNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteNoteUseCase>(
      () => DeleteNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetNoteUseCase>(
      () => GetNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateNoteUseCase>(
      () => UpdateNoteUseCase(repository: sl.call()));

//respository

  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

//data source

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

//External

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}
