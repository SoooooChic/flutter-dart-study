import 'package:flutter/material.dart';
import 'package:threads_clone/models/darkmode_config_model.dart';
import 'package:threads_clone/repos/setting_darkmode_config_repo.dart';

class DarkmodeConfigViewModel extends ChangeNotifier {
  final SettingDarkmodeConfigRepo _repository;

  late final DarkmodeConfigModel _model = DarkmodeConfigModel(
    darkMode: _repository.isDarkMode(),
  );

  DarkmodeConfigViewModel(this._repository);

  bool get darkMode => _model.darkMode;

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    _model.darkMode = value;
    notifyListeners();
  }
}
