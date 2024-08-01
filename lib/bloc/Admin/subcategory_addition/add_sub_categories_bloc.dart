import 'dart:math';

import 'package:adminmetrogenius/services/sub_catgeory/sub_category.dart';
import 'package:bloc/bloc.dart';
import 'package:random_string/random_string.dart';

part 'add_sub_categories_event.dart';
part 'add_sub_categories_state.dart';

class AddSubCategoriesBloc extends Bloc<AddSubCategoriesEvent, AddSubCategoriesState> {
  AddSubCategoriesBloc() : super(AddSubCategoriesState()) {
   on<ImageChnagesSubCatgeory>(_imageChanegs);
   on<CatDesChnages>(_desChnages);
   on<CatPriceChnages>(_priceChanges);
   on<CatNameChanges>(_catNameChanges);
   on<FormSubmit>(_formSubmit);
   on<CheckBoxChecked>(_isCheckedbox);

  }
  void _imageChanegs(ImageChnagesSubCatgeory event,Emitter<AddSubCategoriesState>emit){
    emit(state.copyWith(catImage: event.image));
  }
  void _desChnages(CatDesChnages event,Emitter<AddSubCategoriesState>emit){
    emit(state.copyWith(catDescription:event.catDes ));
  
  }
    void _priceChanges(CatPriceChnages event,Emitter<AddSubCategoriesState>emit){
      emit(state.copyWith(catPrice: event.catPrice));
    }
    void _catNameChanges(CatNameChanges event,Emitter<AddSubCategoriesState>emit){
      emit(state.copyWith(catName: event.CatName));
    }
    void _isCheckedbox(CheckBoxChecked event,Emitter<AddSubCategoriesState>emit){
       Map<String, bool> updatedCheckboxes = Map.from(state.checkboxes);
          updatedCheckboxes[event.id] = event.isChecked;
          emit(state.copyWith(checkboxes: updatedCheckboxes));
    }
    void _formSubmit(FormSubmit event,Emitter<AddSubCategoriesState>emit)async{
      emit(state.copyWith(status: SubCatFormStatus.pending));
      try {
        String id = randomAlphaNumeric(7);
        final categoryInfo=SubCategory.subcategoryInfo(id: id, catName: state.catName!, catDes: state.catDescription!, catPrice: state.catPrice!, catImage: state.catImage!, checkBox: state.checkboxes);
        final added=await SubCategory.addSubcategory(event.categoryId, categoryInfo, id);
        if(added){
          emit(state.copyWith(status:SubCatFormStatus.sucess));
        }else{
              emit(state.copyWith(status: SubCatFormStatus.failure));
        }
      } catch (e) {
          emit(state.copyWith(status: SubCatFormStatus.failure));
      }
    }
}
