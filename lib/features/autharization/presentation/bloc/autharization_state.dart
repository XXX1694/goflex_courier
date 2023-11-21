part of 'autharization_bloc.dart';

class AutharizationState extends Equatable {
  const AutharizationState();

  @override
  List<Object> get props => [];
}

class AutharizationInitial extends AutharizationState {}

class LogingIn extends AutharizationState {}

class LoggedIn extends AutharizationState {}

class LogInError extends AutharizationState {
  final String error;
  const LogInError({required this.error});
}
