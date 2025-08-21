import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/cache_helper/cache_helper.dart';
import 'package:whatsapp_assessment/core/cache_helper/cache_values.dart';

part 'change_mood_state.dart';

class ChangeMoodCubit extends Cubit<ChangeMoodStates> {
  ChangeMoodCubit() : super(ChangeMoodInitial());

  bool isDark = false;
  void changeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ThemeChanged(isDark: isDark));
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: CacheKeys.isDark, value: isDark);
      emit(ThemeChanged(isDark: isDark));
    }
  }
}
