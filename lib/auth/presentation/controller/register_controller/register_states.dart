
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  RegisterSuccessState();
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}
class ChangePasswordVisibilityState  extends RegisterStates
{
  final bool visibility;

  ChangePasswordVisibilityState(this.visibility);
}

class ChangeVisibilityState  extends RegisterStates
{
  final bool isObsecured;

  ChangeVisibilityState(this.isObsecured);
}
class ChangeExpandedState  extends RegisterStates
{
  final bool isExpanded;

  ChangeExpandedState(this.isExpanded);
}
