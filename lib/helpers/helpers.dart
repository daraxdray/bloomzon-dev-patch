

import 'dart:developer';

import 'package:bloomzon/repository/ApiRep.dart';
import 'package:http/http.dart';
import 'package:bloomzon/utils/DxNetwork.dart';

List<Map<String,dynamic>> getLocationList(List<dynamic> list, {bool getId = false}){

  List<Map<String,dynamic>> newList = [];

  //return the ID as the value if getID is true frpm parameter
  if(getId){
  for(int i = 0; i < list.length; i++ ){
    var value = {'value': list[i]['id'].toString(), 'label': list[i]['title']};
    newList.add(value);
  }}
  else{
  for(int i = 0; i < list.length; i++ ){
    var value = {'value': list[i]['title'].toString(), 'label': list[i]['title']};
    newList.add(value);
  }}
  return newList;
}

List<Map<String,dynamic>> getRolesList(List<dynamic> list){

  List<Map<String,dynamic>> newList = [];

  for(int i = 0; i < list.length; i++ ){
    var value = {'value': list[i]['role_type'].toString(), 'label': list[i]['role_type']};
    newList.add(value);
  }
  return newList;
}


Future<dynamic> getLocation({getId = false}) async{
  ApiRep  apirep = ApiRep();
  Map<String, dynamic> locations = await apirep.get('listing/get_all_locations'); //get the locations

  List<Map<String,dynamic>> newList = getLocationList(locations['data'],getId:getId ); // list all locations for display

  return newList;
}