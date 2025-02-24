import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: kToolbarHeight,
          child: TextField(
            key: const ValueKey('searchField'),
            autofocus: true,
            controller: _searchController,
            textInputAction: TextInputAction.send,
            onSubmitted: (value) {
              context
                  .read<RestaurantSearchProvider>()
                  .fetchRestaurantSearch(_searchController.text);
            },
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              hintText: "Search...",
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.send_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  context
                      .read<RestaurantSearchProvider>()
                      .fetchRestaurantSearch(_searchController.text);
                },
              ),
            ),
          ),
        ),
      ),
      body: Consumer<RestaurantSearchProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantSearchLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            RestaurantSearchLoadedState(data: var restaurantList) => Container(
                child: restaurantList.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 120.0),
                          child: Text('No data found!'),
                        ),
                      )
                    : ListView.builder(
                        itemCount: restaurantList.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurantList[index];
                          return RestaurantCardWidget(
                            restaurantItem: restaurant,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NavigationRoute.detailRoute.name,
                                arguments: restaurant.id,
                              );
                            },
                          );
                        },
                      ),
              ),
            RestaurantSearchErrorState() => Center(
                child: Lottie.asset(
                  'assets/animations/lottie/no_wifi.json',
                ),
              ),
            _ => const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 120.0),
                  child: Text('Search first!'),
                ),
              ),
          };
        },
      ),
    );
  }
}
