abstract class ChangeState<State> {}

class InitialState extends ChangeState {}

class SignUpState extends ChangeState {}

class SignInState extends ChangeState {}

class SignOutState extends ChangeState {}

class IntializeCurrentState extends ChangeState {}


class VerificationState extends ChangeState {}

class GetState extends ChangeState {}

class AddState extends ChangeState {}

class DeleteState extends ChangeState {}

class UpdateState extends ChangeState {}

class ShowImageState extends ChangeState {}

class GetImageState extends ChangeState {}

class UploadFileState extends ChangeState {}

class GetFileState extends ChangeState {}

class SignUpErrorState extends ChangeState {}

class SignInErrorState extends ChangeState {}

class SignOutErrorState extends ChangeState {}

class VerificationErrorState extends ChangeState {}

class GetErrorState extends ChangeState {}

class AddErrorState extends ChangeState {}

class DeleteErrorState extends ChangeState {}

class UpdateErrorState extends ChangeState {}

class ShowImageErrorState extends ChangeState {}

class GetImageErrorState extends ChangeState {}

class UploadFileErrorState extends ChangeState {}

class GetFileErrorState extends ChangeState {}

class SendMessageState extends ChangeState {}

class SendMessageErrorState extends ChangeState {}

class GetMessageState extends ChangeState {}

class GetMessageErrorState extends ChangeState {}

class ScreenState extends ChangeState {}
