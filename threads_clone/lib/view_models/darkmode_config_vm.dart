import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/models/darkmode_config_model.dart';
import 'package:threads_clone/repos/setting_darkmode_config_repo.dart';

final settingDarkmodeConfigRepoProvider =
    Provider<SettingDarkmodeConfigRepo>((ref) {
  throw UnimplementedError();
});

class DarkmodeConfigViewModel extends Notifier<DarkmodeConfigModel> {
  late final SettingDarkmodeConfigRepo _repository;

  @override
  DarkmodeConfigModel build() {
    _repository = ref.watch(settingDarkmodeConfigRepoProvider);
    return DarkmodeConfigModel(darkMode: _repository.isDarkMode());
  }

  bool get darkMode => state.darkMode;

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = DarkmodeConfigModel(darkMode: value);
  }
}

final changeDarkmodeProvider =
    NotifierProvider<DarkmodeConfigViewModel, DarkmodeConfigModel>(
  DarkmodeConfigViewModel.new,
);
