import 'package:flutter_bloc/flutter_bloc.dart';

class ContactState {}

class ContactInitial extends ContactState {}

class NavigateToContact extends ContactState {} // Navigation state

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  void navigate() {
    emit(NavigateToContact());
  }
}
