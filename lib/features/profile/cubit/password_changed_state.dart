import 'package:equatable/equatable.dart';

abstract class PasswordChangedState extends Equatable {
  const PasswordChangedState();

  @override
  List<Object?> get props => [];
}

class PasswordChangedInitial extends PasswordChangedState {}

class PasswordChangedLoading extends PasswordChangedState {}

class PasswordChangedSuccess extends PasswordChangedState {
  final String message;

  const PasswordChangedSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordChangedError extends PasswordChangedState {
  final String error;

  const PasswordChangedError(this.error);

  @override
  List<Object?> get props => [error];
}
