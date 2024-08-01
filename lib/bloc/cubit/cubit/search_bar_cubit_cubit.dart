import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'search_bar_cubit_state.dart';

class SearchBarCubitCubit extends Cubit<SearchBarState> {
  SearchBarCubitCubit() : super(SearchBarHidden());
  void toggleSearchbar(){
    if(state is SearchBarHidden){
      emit(SearchBarVisible());
    }else{
      emit(SearchBarHidden());
    }
  }
}
