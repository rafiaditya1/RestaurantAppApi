import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/provider/restaurant_provider.dart';
import 'package:restaurant_api/ui/favorite_page.dart';
import 'package:restaurant_api/ui/home/drawer_widget.dart';
import 'package:restaurant_api/ui/home/restaurant_item.dart';
import 'package:restaurant_api/ui/home/search_bar.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';

  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(context),
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text('Restaurant Api'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, SearchBar.routeName);
              },
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, FavoritePage.routeName);
              },
              icon: const Icon(Icons.favorite),
            ),
          ],
        ),
        body: Consumer<RestaurantProvider>(builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.HasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantItem(
                  restaurant: state.result.restaurants[index],
                );
              },
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style:
                        const TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 25),
                  RaisedButton(
                    color: Colors.red,
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
        }),
      ),
    );
  }
}
