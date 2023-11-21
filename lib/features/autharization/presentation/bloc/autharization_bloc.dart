import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/features/autharization/data/repositories/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'autharization_event.dart';
part 'autharization_state.dart';

final _storage = SharedPreferences.getInstance();

class AutharizationBloc extends Bloc<AutharizationEvent, AutharizationState> {
  final AutharizationRepository repo;
  AutharizationBloc({
    required this.repo,
    required AutharizationState autharizationState,
  }) : super(AutharizationInitial()) {
    on<LogIn>(
      (event, emit) async {
        emit(LogingIn());
        try {
          int res = await repo.logIn(
            phone: event.phone,
            password: event.password,
          );
          if (res == 200) {
            emit(LoggedIn());
          } else {
            emit(LogInError(error: 'Код ошибки: $res'));
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(LogInError(error: e.toString()));
        }
      },
    );
    on<GetStatus>(
      (event, emit) async {
        final storage = await _storage;
        String? token = storage.getString('auth_token');
        if (token != null) {
          emit(LoggedIn());
        }
      },
    );
    on<LogOut>(
      (event, emit) async {
        final storage = await _storage;
        await storage.remove('auth_token');
        emit(AutharizationInitial());
      },
    );
  }
}
