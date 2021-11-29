import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_api/data/provider/restaurant_provider.dart';
import 'package:restaurant_api/ui/home/restaurant_item.dart';

class FavoritePage extends StatelessWidget {
  static const String routeName = '/favorite_page';

  const FavoritePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Favorite Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              return RestaurantItem(
                restaurant: provider.favorite[index],
              );
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}
