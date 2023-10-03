part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState{
  final String uid;
  Authenticated({
    required this.uid
});
  List<Object> get props => [];
}

class UnAuthenticated extends AuthState{
  List<Object> get props => [];
}