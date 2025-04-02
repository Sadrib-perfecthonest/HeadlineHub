import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:headlinehub/cubits/splash_state.dart';
import 'package:meta/meta.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading()) {
    _startsplash();
  }

  void _startsplash() async {
    Future.delayed(const Duration(seconds: 3), () {
      emit(SplashCompleted());
    });
  }
}
