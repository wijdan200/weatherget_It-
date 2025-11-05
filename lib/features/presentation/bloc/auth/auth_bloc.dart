import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterweather/features/data/datasource/auth_service.dart';
import 'package:flutterweather/features/presentation/bloc/auth/auth_event.dart';
import 'package:flutterweather/features/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<LoginModeToggled>(_onLoginModeToggled);
    on<PasswordVisibilityToggled>(_onPasswordVisibilityToggled);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (!isClosed) {
        add(AuthCheckRequested());
      }
    });

    // Listen to auth state changes with error handling
    _authService.authStateChanges.listen(
      (user) {
        if (!isClosed) {
          add(AuthCheckRequested());
        }
      },
      onError: (error) {
        if (!isClosed) {
          emit(AuthError('Auth state error: ${error.toString()}', isLogin: state.isLogin, obscurePassword: state.obscurePassword));
        }
      },
    );
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Check synchronously for immediate response
      final user = _authService.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user, isLogin: state.isLogin, obscurePassword: state.obscurePassword));
      } else {
        emit(AuthUnauthenticated(isLogin: state.isLogin, obscurePassword: state.obscurePassword));
      }
    } catch (e) {
      emit(AuthError('Auth check error: ${e.toString()}', isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    try {
      final credential = await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (credential?.user != null) {
        emit(AuthAuthenticated(credential!.user!, isLogin: state.isLogin, obscurePassword: state.obscurePassword));
      } else {
        emit(AuthError('Sign in failed', isLogin: state.isLogin, obscurePassword: state.obscurePassword));
      }
    } catch (e) {
      emit(AuthError(e.toString(), isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    try {
      final credential = await _authService.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (credential?.user != null) {
        emit(AuthAuthenticated(credential!.user!, isLogin: state.isLogin, obscurePassword: state.obscurePassword));
      } else {
        emit(AuthError('Sign up failed', isLogin: state.isLogin, obscurePassword: state.obscurePassword));
      }
    } catch (e) {
      emit(AuthError(e.toString(), isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    }
  }

  Future<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    try {
      final credential = await _authService.signInWithGoogle();
      if (credential?.user != null) {
        emit(AuthAuthenticated(credential!.user!, isLogin: state.isLogin, obscurePassword: state.obscurePassword));
      } else {
        // User canceled the sign-in
        emit(AuthUnauthenticated(isLogin: state.isLogin, obscurePassword: state.obscurePassword));
      }
    } catch (e) {
      debugPrint("Google Sign-In error: $e");
      emit(AuthError(e.toString(), isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    try {
      await _authService.signOut();
      emit(AuthUnauthenticated(isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    } catch (e) {
      emit(AuthError(e.toString(), isLogin: state.isLogin, obscurePassword: state.obscurePassword));
    }
  }

  void _onLoginModeToggled(
    LoginModeToggled event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthUnauthenticated || state is AuthInitial || state is AuthError) {
      emit(state.copyWith(isLogin: !state.isLogin));
    }
  }

  void _onPasswordVisibilityToggled(
    PasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthUnauthenticated || state is AuthInitial || state is AuthError || state is AuthLoading) {
      emit(state.copyWith(obscurePassword: !state.obscurePassword));
    }
  }
}

