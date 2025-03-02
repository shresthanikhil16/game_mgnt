import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsState {}

class AboutUsInitial extends AboutUsState {}

class NavigateToAboutUs extends AboutUsState {} // Navigation state

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(AboutUsInitial());

  void navigate() {
    emit(NavigateToAboutUs());
  }
}
