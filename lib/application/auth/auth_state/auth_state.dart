import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthIntail extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String uid;
  const AuthSuccess(this.uid);
  @override
  List<Object?> get props => [uid];
}

class AuthFailed extends AuthState {
  final String error;
  const AuthFailed(this.error);
  @override
  List<Object?> get props => [error];
}
