import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/api/connection_service.dart';
import 'package:restaurant_api/data/model/restaurant_detail.dart';
import 'package:http/http.dart' as http;

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class RestaurantDetailProvider extends ChangeNotifier {
  RestaurantDetailProvider(this.context, {@required this.id}) {
    _fetchRestaurantDetailData();
  }

  final String id;
  final BuildContext context;
  final apiService = ApiService();
  final connectionService = ConnectionService();

  String _message = '';
  ResultState _state;
  DetailRestaurantResult _detailRestaurantResult;

  String get message => _message;
  ResultState get state => _state;
  DetailRestaurantResult get result => _detailRestaurantResult;

  Future<dynamic> _fetchRestaurantDetailData() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final connection = await connectionService.connectionService(context);
      if (!connection.connected) {
        _state = ResultState.NoConnection;
        notifyListeners();
        return _message = connection.message;
      }
      final restaurant = await getRestaurantDetail();
      if (restaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailRestaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<DetailRestaurantResult> getRestaurantDetail() async {
    final response = await http.get(Uri.parse((ApiService.detail + id)));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Sorry, we are failed to load data');
    }
  }

  void refresh() {
    _fetchRestaurantDetailData();
    notifyListeners();
  }
}
