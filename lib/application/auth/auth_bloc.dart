import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_office/application/auth/auth_event/auth_event.dart';
import 'package:portal_office/application/auth/auth_state/auth_state.dart';
import 'package:portal_office/infrastructure/auth/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc({required this.authService}) : super(AuthIntail()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authService.SignIn(
            email: event.email, password: event.password);
        emit(AuthSuccess(user!.uid));
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });

    on<SignupRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authService.SignUp(
            email: event.email, password: event.password);
        emit(AuthSuccess(user!.uid));
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authService.SignOut();
      emit(AuthIntail());
    });
  }
}
