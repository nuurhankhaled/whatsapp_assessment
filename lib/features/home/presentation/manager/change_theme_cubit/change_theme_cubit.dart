import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/cache_helper/cache_helper.dart';
import 'package:whatsapp_assessment/core/cache_helper/cache_values.dart';

part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeStates> {
  ChangeThemeCubit() : super(ChangeThemeInitial());

  bool isDark = false;
  void changeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      print('isDark: $isDark');
      emit(ThemeChanged(isDark: isDark));
    } else {
      isDark = !isDark;
      print('isDark: $isDark');
      CacheHelper.saveData(key: CacheKeys.isDark, value: isDark);
      emit(ThemeChanged(isDark: isDark));
    }
  }
}
