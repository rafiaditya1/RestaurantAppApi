import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/provider/restaurant_detail_provider.dart';
import 'package:restaurant_api/ui/details/aligment.dart';

import 'detail_image.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_restaurant';
  final String id;
  const DetailPage({this.id});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<RestaurantDetailProvider>(context);

    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(context, id: widget.id),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              return NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    const DetailImage(),
                  ];
                },
                body: const Aligment(),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.Error) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.NoConnection) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 30),
                    RaisedButton(
                      color: Colors.blue,
                      child: const Text('Refresh'),
                      onPressed: () {
                        state.refresh();
                      },
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }
}
