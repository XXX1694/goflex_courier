part of 'autharization_bloc.dart';

abstract class AutharizationEvent extends Equatable {
  const AutharizationEvent();

  @override
  List<Object> get props => [];
}

class LogIn extends AutharizationEvent {
  final String phone;
  final String password;
  const LogIn({
    required this.phone,
    required this.password,
  });
}

class GetStatus extends AutharizationEvent {}

class LogOut extends AutharizationEvent {}
