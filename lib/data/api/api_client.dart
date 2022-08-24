// creating a class for the api client to be called in the init method which will then be passed into the main

import 'package:ecommerce/utils/app_constants.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class ApiClient extends GetConnect implements GetxService {
   late String token;        // because in general when you talk to the server you should have a token which would be initialised in the api client class
   final String appBaseUrl;   // the url of our app that will talk  to the server ie the server url

  late Map<String,String> _mainHeaders;               // for storing data

   ApiClient({required this.appBaseUrl}){
     baseUrl = appBaseUrl;
     timeout = Duration(seconds: 30);
     token = AppConstants.TOKEN;
     _mainHeaders={
       "Content-type":"application/json; charset=UTF-8",
       "Authorization":"Bearer $token",
     };
   }


   Future<Response> getData(String uri) async {

     try {
      Response response = await get(uri);
      return response;
     }
     catch(e) {
       return Response(statusCode: 1, statusText: e.toString());
     }
  }


}
