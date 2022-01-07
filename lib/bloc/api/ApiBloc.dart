import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloomzon/helpers/helpers.dart';
import 'package:bloomzon/repository/ApiRep.dart';
import 'package:bloomzon/utils/CustomException.dart';
import 'ApiEvent.dart';
import 'ApiState.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiRep apirep;

  ApiBloc() : super(null) {
    apirep = new ApiRep();

  }

  ApiState get initialState => ApiInitials();

  @override
  Stream<ApiState> mapEventToState(ApiEvent event) async* {
    yield ApiRequesting();
try{
    if(event is RequestApi){
      switch(event.type){
        case 'specialties':
          List result = await apirep.get('taxonomies/get-specilities');
          if(result.length > 0) {
            yield ApiSuccess(result);
            return;
          }
            yield ApiFailed("Unable to load");
            break;

        case 'locs_roles':
          Map<String, dynamic> locations = await apirep.get('listing/get_all_locations'); //get the locations
          Map<String, dynamic> roles = await apirep.get('listing/get_all_roles'); //get the roles

          if(locations == null || roles == null){
            yield NetworkFailure();
            return;
          }

          List<Map<String,dynamic>> newList = getLocationList(locations['data']); // list all locations for display
          List<Map<String,dynamic>> newList2 = getRolesList(roles['data']); //list the roles for display on select field

          yield ApiSuccess({'locations':newList,'roles':newList2});
          break;


        case 'search':
          var result = await apirep.get('search-results?search=${event.data['search']}&type=${event.data['type']}&location=${event.data['location']}');
          if(!result['status']){
            yield ApiFailed("Failed Search");
          }
           List<dynamic> search = result['data'];
           yield ApiSuccess(search);
          break;
        default:
          break;
      }
    }

  }
  catch(e){

      if(e == FetchDataException){
        yield NetworkFailure();
      }else{
          yield ApiFailed(e);
          log("ERORAPIBLOC",error: e);
          }
  }}
}
