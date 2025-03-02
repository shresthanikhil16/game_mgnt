import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  // Add methods for handling settings changes if needed
}
