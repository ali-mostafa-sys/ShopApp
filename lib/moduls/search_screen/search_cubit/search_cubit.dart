


  import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/moduls/search_screen/search_cubit/search_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remot/connection_manager/connection.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit(): super(SearchInitialState());
  static SearchCubit get(context)=> BlocProvider.of(context);

  SearchProductsRequest searchProductsRequest=SearchProductsRequest();
  late SearchModel searchModel;

  void getSearchData({required String text})async{

    emit(SearchLoadingState());
    final response=await searchProductsRequest.postSearch(token: token, text: text).then((value) {
      searchModel=value;
      emit(SearchSuccessState(searchModel: searchModel));
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState(error: error.toString()));
    });

  }

}