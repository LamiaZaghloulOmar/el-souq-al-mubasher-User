import 'package:efood_multivendor/data/api/api_client.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({@required this.apiClient});

  Future<Response> getCategoryList() async {
    return await apiClient.getData(AppConstants.CATEGORY_URI);
  }

  Future<Response> getSubCategoryList(String parentID) async {
    return await apiClient.getData('${AppConstants.SUB_CATEGORY_URI}$parentID');
  }

  Future<Response> getServices() async {
    return await apiClient.getData('${AppConstants.SERVICES_URI}');
  }
   Future<Response> getSubServices(id) async {
    return await apiClient.getData('${AppConstants.SERVICES_SUB_URI}/$id');
  }
  Future<Response> getMainServices() async { 
    return await apiClient.getData('${AppConstants.MAIN_SERVICES_URI}');
  }
  Future<Response> getCategoryProductList(
      String categoryID, int offset, String type) async {
    return await apiClient.getData(
        '${AppConstants.CATEGORY_PRODUCT_URI}$categoryID?limit=10&offset=$offset&type=$type');
  }

  Future<Response> getCategoryRestaurantList(
      String categoryID, int offset, String type) async {
    return await apiClient.getData(
        '${AppConstants.CATEGORY_RESTAURANT_URI}$categoryID?limit=10&offset=$offset&type=$type');
  }

  Future<Response> getSearchData(
      String query, String categoryID, bool isRestaurant, String type) async {
    return await apiClient.getData(
      '${AppConstants.SEARCH_URI}${isRestaurant ? 'restaurants' : 'products'}/search?name=$query&category_id=$categoryID&type=$type&offset=1&limit=50',
    );
  }

  Future<Response> saveUserInterests(List<int> interests) async {
    return await apiClient
        .postData(AppConstants.INTEREST_URI, {"interest": interests});
  }

  Future<Response> getPostsList() async {
    return await apiClient.getData("/api/v1/customer/serviceorder/");
  }

    Future<Response> getserviceorderbydm(id) async {
    return await apiClient.getData(AppConstants.GET_SERVICE_ORDER_BY_DM+id);
  }
  // https://elsouqalmubasher.com/api/v1/services/getserviceorderbydm/

    Future<Response> completeservice(id) async {
    return await apiClient.getData(AppConstants.COMPLETE_SERVICE+id);
  }

    Future<Response> showserviceReview(id) async {
    return await apiClient.getData(AppConstants.SHOW_SERVICE_REVIEW+id);
  }

   Future<Response> addRate(serviceMark,serviceowner,orderid,rate,comment) async {
    return await apiClient
        .postData(AppConstants.add_REVIEW, {"service_maker": serviceMark,
        "service_owner":serviceowner,
        "service_order_id":orderid,
        "rate":rate,
        "comment":comment,});
  }
}
