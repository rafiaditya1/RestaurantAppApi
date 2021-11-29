import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/provider/restaurant_detail_provider.dart';
import 'package:restaurant_api/ui/details/detail_menu.dart';

class Aligment extends StatelessWidget {
  const Aligment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RestaurantDetailProvider>(context);
    return ListView(
      children: [
        // Header
        Positioned(
          bottom: 0,
          left: 50,
          right: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: 315,
                height: 120,
                color: Colors.red[400],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.result.restaurant.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              Text(
                                state.result.restaurant.city,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              Text(
                                state.result.restaurant.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Card(
        //   color: Colors.white,
        //   child: Padding(
        //     padding: const EdgeInsets.all(5.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           state.result.restaurant.name,
        //           style: TextStyle(
        //             fontWeight: FontWeight.w700,
        //             fontSize: 20,
        //             color: Colors.black,
        //           ),
        //         ),
        //         CustomIcon(
        //             value: state.result.restaurant.city,
        //             icon: Icons.location_pin,
        //             color: Colors.red),
        //         CustomIcon(
        //             value: state.result.restaurant.rating.toString(),
        //             icon: Icons.star,
        //             color: Colors.amber)
        //       ],
        //     ),
        //   ),
        // ),
        // Desription
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.result.restaurant.description,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
        const DetailMenu(title: 'Makanan'),
        const DetailMenu(title: 'Minuman'),
      ],
    );
  }
}
