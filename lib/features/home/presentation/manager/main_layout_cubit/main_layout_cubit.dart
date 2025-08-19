import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/core/constants/constant.dart';
part 'main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());

  static MainLayoutCubit get(BuildContext context) =>
      BlocProvider.of<MainLayoutCubit>(context);
  void changeBottomNavBarIndex(int index) {
    mainLayoutIntitalScreenIndex = index;
    emit(AppBottomNavState(mainLayoutIntitalScreenIndex));
  }
}
