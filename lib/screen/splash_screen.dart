import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../cubits/splash_cubit.dart';
import '../cubits/splash_state.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "HeadlineHub",
                  style: GoogleFonts.lato(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                SpinKitSpinningLines(
                  color: Colors.white,
                  size: 60.0,
                  lineWidth: 3.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
