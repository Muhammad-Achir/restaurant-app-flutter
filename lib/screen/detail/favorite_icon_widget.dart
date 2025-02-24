import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list/restaurant_list.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/favorite/database_favorite_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;
  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    super.initState();

    final dbProvider = context.read<DatabaseFavoriteProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await dbProvider.getRestaurantById(widget.restaurant.id);
      final value = dbProvider.restaurant == null
          ? false
          : dbProvider.restaurant!.id == widget.restaurant.id;

      favoriteIconProvider.isFavorite = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        print('object');
        final dbProvider = context.read<DatabaseFavoriteProvider>();
        final favoriteProvider = context.read<FavoriteIconProvider>();
        final isFavorite = favoriteProvider.isFavorite;

        if (isFavorite) {
          await dbProvider.removeRestaurant(widget.restaurant.id);
        } else {
          final RestaurantList restaurantList = RestaurantList(
            id: widget.restaurant.id,
            name: widget.restaurant.name,
            description: widget.restaurant.description,
            pictureId: widget.restaurant.pictureId,
            city: widget.restaurant.city,
            rating: widget.restaurant.rating,
          );
          await dbProvider.saveRestaurant(restaurantList);
        }

        favoriteProvider.isFavorite = !isFavorite;
        dbProvider.getAllRestaurant();
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(), // Membuatnya melingkar
        padding: const EdgeInsets.all(16), // Menyesuaikan ukuran
      ),
      child: Icon(
        context.watch<FavoriteIconProvider>().isFavorite
            ? Icons.favorite
            : Icons.favorite_border_outlined,
        color: Colors.red,
      ),
    );
  }
}
