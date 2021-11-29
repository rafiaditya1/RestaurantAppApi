import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/provider/restaurant_detail_provider.dart';

import 'menu_item.dart';

class DetailMenu extends StatelessWidget {
  final String title;

  const DetailMenu({@required this.title});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RestaurantDetailProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MenuItem(index: index, type: title);
                },
                itemCount: title == "Makanan"
                    ? state.result.restaurant.menus.foods.length
                    : state.result.restaurant.menus.drinks.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
