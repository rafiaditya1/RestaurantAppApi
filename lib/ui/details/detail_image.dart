import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/provider/restaurant_detail_provider.dart';

class DetailImage extends StatelessWidget {
  const DetailImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RestaurantDetailProvider>(context);
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: state.result.restaurant.id,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Image.network(
              ApiService.largeImage + state.result.restaurant.pictureId,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
