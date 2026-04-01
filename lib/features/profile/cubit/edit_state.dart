abstract class EditState {}

class EditInitial extends EditState {}

class EditLoading extends EditState {}

class EditSuccess extends EditState {}

class EditError extends EditState {
  final String message;

  EditError(this.message);
}
