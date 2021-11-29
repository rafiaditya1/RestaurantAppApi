import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/restaurant.dart';
import 'package:restaurant_api/data/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_api/ui/details/detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isFavorited(restaurant.id),
            builder: (context, snapshot) {
              var isFav = snapshot.data ?? false;
              return Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, DetailPage.routeName,
                        arguments: restaurant.id);
                  },
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.red[200],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                ApiService.smallImage + restaurant.pictureId,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                restaurant.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_pin,
                                    color: Colors.redAccent,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(restaurant.city),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    restaurant.rating.toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            icon: isFav
                                ? IconButton(
                                    onPressed: () =>
                                        provider.removeFavorite(restaurant.id),
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () =>
                                        provider.addFavorite(restaurant),
                                    icon: const Icon(Icons.favorite_border),
                                  ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
