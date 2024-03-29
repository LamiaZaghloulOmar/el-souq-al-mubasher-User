import 'package:efood_multivendor/data/api/api_checker.dart';
import 'package:efood_multivendor/data/model/response/category_model.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/data/repository/category_repo.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

import '../view/screens/posts/post_screen.dart';

class Services {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String image;
  String status;
  List translations = [];

  Services(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.status,
      this.translations});

  Services.fromJson(Map<String, dynamic> json) {
    id =int.parse(json['id'].toString());
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    status = json['status'].toString();
    if (json['translations'] != null) {
      translations = [];
      json['translations'].forEach((v) {
        translations.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['status'] = this.status;
    if (this.translations != null) {
      data['translations'] = this.translations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({@required this.categoryRepo});

  List<CategoryModel> _categoryList;
  List<Services> _services = [];
  List<Services> _mainservices = [];
  List<Post> _postsList = [];
  List<Post> _postsByWorkerList = [];
  List _reviewList = [];
  List<CategoryModel> _subCategoryList;
  List<Product> _categoryProductList;
  List<Restaurant> _categoryRestList;
  List<Product> _searchProductList = [];
  List<Name> _name = [];
  List<Name> _nameW = [];
  
  List<Restaurant> _searchRestList = [];
  List<bool> _interestSelectedList;
  bool _isLoading = false;
  int _pageSize;
  int _restPageSize;
  bool _isSearching = false;
  int _subCategoryIndex = 0;
  String _type = 'all';
  bool _isRestaurant = false;
  String _searchText = '';
  String _restResultText = '';
  String _prodResultText = '';
  int _offset = 1;

  List<CategoryModel> get categoryList => _categoryList;
  List<Post> get postsList => _postsList;
  List<Post> get postsByWorkerList => _postsByWorkerList;
  List get reviewList => _reviewList;
  
  List<Name> get name => _name;
  List<Name> get nameW => _nameW;
  List<CategoryModel> get subCategoryList => _subCategoryList;
  List<Product> get categoryProductList => _categoryProductList;
  List<Restaurant> get categoryRestList => _categoryRestList;
  List<Product> get searchProductList => _searchProductList;
  List<Restaurant> get searchRestList => _searchRestList;
  List<bool> get interestSelectedList => _interestSelectedList;
  bool get isLoading => _isLoading;
  bool get isLoadingserv => _isLoadingserv;
  int get pageSize => _pageSize;
  int get restPageSize => _restPageSize;
  bool get isSearching => _isSearching;
  int get subCategoryIndex => _subCategoryIndex;
  String get type => _type;
  bool get isRestaurant => _isRestaurant;
  String get searchText => _searchText;
  int get offset => _offset;
  List<Services> get services => _services;
  List<Services> get main_services => _mainservices;
  

  Future<void> getCategoryList(bool reload) async {
    if (_categoryList == null || reload) {
      Response response = await categoryRepo.getCategoryList();
      print("Response+ ${response.body}");
      if (response.statusCode == 200) {
        _categoryList = [];
        _interestSelectedList = [];
        response.body.forEach((category) {
          _categoryList.add(CategoryModel.fromJson(category));
          _interestSelectedList.add(false);
        });
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> getSubCategoryList(String categoryID) async {
    _subCategoryIndex = 0;
    _subCategoryList = null;
    _categoryProductList = null;
    _isRestaurant = false;
    Response response = await categoryRepo.getSubCategoryList(categoryID);
    if (response.statusCode == 200) {
      _subCategoryList = [];
      // _subCategoryList
      //     .add(CategoryModel(id: int.parse(categoryID), name: 'all'.tr));
      response.body.forEach((category) {
        _subCategoryList.add(CategoryModel.fromJson(category));
      });
      getCategoryProductList(categoryID, 1, 'all', false);
    } else {
      ApiChecker.checkApi(response);
    }
    
  }

    void getPosts() async {
    _subCategoryIndex = 0;

    Response response = await categoryRepo.getPostsList();
    if (response.statusCode == 200) {
      _postsList = [];
      _name = [];
      print(response.body);
      if(response.body.length>0){
      response.body[0].forEach((category) {
        _name.add(Name.fromJson(category));
      });
      // _subCategoryList
      //     .add(CategoryModel(id: int.parse(categoryID), name: 'all'.tr));
      response.body[1].forEach((category) {
        _postsList.add(Post.fromJson(category));
      });
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    
  }
  
  void getserviceorders(id) async {
     Response response = await categoryRepo.getserviceorderbydm(id);
    if (response.statusCode == 200) {
       _postsByWorkerList = [];
      _nameW = [];
       print(response.body);
      if(response.body.length>0){
           response.body[0].forEach((category) {
        _nameW.add(Name.fromJson(category));
      });
      response.body[1].forEach((category) {
        _postsByWorkerList.add(Post.fromJson(category));
      });
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    
  }

void addrateForWorker(serviceMark,serviceowner,orderid,rate,comment) async {
     Response response = await categoryRepo.addRate(serviceMark,serviceowner,orderid,rate,comment);
    if (response.statusCode == 200) {
       print(response.body);
     showCustomSnackBar('تم التقييم بنجاح',isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    
  }


  void getshowserviceReview(id) async {
   
    Response response = await categoryRepo.showserviceReview(id);
    if (response.statusCode == 200) {
       _reviewList=[];

      print(response.body);
      if(response.body.length>0){
      response.body[0].forEach((category) {
        _reviewList.add(category);
      });
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    
  }

  void completMyOrder(id) async {
    Response response = await categoryRepo.completeservice(id);
    if (response.statusCode == 200) {
       showCustomSnackBar('تم تغيير حالة الطلب الي مكتمل',isError: false);
      
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    
  }

  


    getMainServices() async {
    Response response = await categoryRepo.getMainServices();
    print("ServiceCatResponse + ${response.body[0]}");
    if (response.statusCode == 200) {
      _mainservices = [];
      // _subCategoryList
      //     .add(CategoryModel(id: int.parse(categoryID), name: 'all'.tr));
      response.body.forEach((category) {
        _mainservices.add(Services(
            id: Services.fromJson(category).id,
            // createdAt: Services.fromJson(category).createdAt,
            // image: Services.fromJson(category).image,
            name: Services.fromJson(category).name,
            // status: Services.fromJson(category).status,
            // translations: Services.fromJson(category).translations,
            // updatedAt: Services.fromJson(category).updatedAt
            ));
      });
    } else {
      print("ServiceCatFail");
      ApiChecker.checkApi(response);
    }
    update();
  }

 bool _isLoadingserv = false;
  Future<void> getServices(id) async {
    // _isLoadingserv = true;
    update();
    Response response = await categoryRepo.getSubServices(id);
    print("ServiceCatResponse + ${response.body}");
    if (response.statusCode == 200) {
      _services = [];
      // _subCategoryList
      //     .add(CategoryModel(id: int.parse(categoryID), name: 'all'.tr));
      response.body.forEach((category) {
        _services.add(Services(
            id: Services.fromJson(category).id,
            createdAt: Services.fromJson(category).createdAt,
            image: Services.fromJson(category).image,
            name: Services.fromJson(category).name,
            status: Services.fromJson(category).status,
            translations: Services.fromJson(category).translations,
            updatedAt: Services.fromJson(category).updatedAt));
      });
    } else {
      print("ServiceCatFail");
      ApiChecker.checkApi(response);
    }
    _isLoadingserv = false;
    update();
  }

  void setSubCategoryIndex(int index, String categoryID) {
    _subCategoryIndex = index;
    if (_isRestaurant) {
      getCategoryRestaurantList(
          _subCategoryIndex == 0
              ? categoryID
              : _subCategoryList[index].id.toString(),
          1,
          _type,
          true);
    } else {
      getCategoryProductList(
          _subCategoryIndex == 0
              ? categoryID
              : _subCategoryList[index].id.toString(),
          1,
          _type,
          true);
    }
  }

  void getCategoryProductList(
      String categoryID, int offset, String type, bool notify) async {
    _offset = offset;
    if (offset == 1) {
      if (_type == type) {
        _isSearching = false;
      }
      _type = type;
      if (notify) {
        update();
      }
      _categoryProductList = null;
    }
    Response response =
        await categoryRepo.getCategoryProductList(categoryID, offset, type);
    print("Urlll + $categoryID + ${response.body.toString()}");
    if (response.statusCode == 200) {
      if (offset == 1) {
        _categoryProductList = [];
      }
      _categoryProductList
          .addAll(ProductModel.fromJson(response.body).products);
      _pageSize = ProductModel.fromJson(response.body).totalSize;
      print("This Id +$categoryID + $_categoryProductList");
      _isLoading = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getCategoryRestaurantList(
      String categoryID, int offset, String type, bool notify) async {
    _offset = offset;
    if (offset == 1) {
      if (_type == type) {
        _isSearching = false;
      }
      _type = type;
      if (notify) {
        update();
      }
      _categoryRestList = null;
    }
    Response response =
        await categoryRepo.getCategoryRestaurantList(categoryID, offset, type);
    if (response.statusCode == 200) {
      if (offset == 1) {
        _categoryRestList = [];
      }
      _categoryRestList
          .addAll(RestaurantModel.fromJson(response.body).restaurants);
      _restPageSize = ProductModel.fromJson(response.body).totalSize;
      _isLoading = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void searchData(String query, String categoryID, String type) async {
    print(
        '-------${(_isRestaurant && query.isNotEmpty && query != _restResultText) || (!_isRestaurant && query.isNotEmpty && query != _prodResultText)}');
    if ((_isRestaurant && query.isNotEmpty && query != _restResultText) ||
        (!_isRestaurant && query.isNotEmpty && query != _prodResultText)) {
      _searchText = query;
      _type = type;
      if (_isRestaurant) {
        _searchRestList = null;
      } else {
        _searchProductList = null;
      }
      _isSearching = true;
      update();

      Response response =
          await categoryRepo.getSearchData(query, categoryID, false, type);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
       
            _searchProductList = [];
          
        } else {
          if (_isRestaurant) {
            _restResultText = query;
            _searchRestList = [];
            _searchRestList
                .addAll(RestaurantModel.fromJson(response.body).restaurants);
          } else {
            _prodResultText = query;
            _searchProductList = [];
            _searchProductList
                .addAll(ProductModel.fromJson(response.body).products);
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    _searchProductList = [];
    if (_categoryProductList != null) {
      _searchProductList.addAll(_categoryProductList);
    }
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  Future<bool> saveInterest(List<int> interests) async {
    _isLoading = true;
    update();
    Response response = await categoryRepo.saveUserInterests(interests);
    bool _isSuccess;
    if (response.statusCode == 200) {
      _isSuccess = true;
    } else {
      _isSuccess = false;
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  void addInterestSelection(int index) {
    _interestSelectedList[index] = !_interestSelectedList[index];
    update();
  }

  void setRestaurant(bool isRestaurant) {
    _isRestaurant = isRestaurant;
    update();
  }
}
