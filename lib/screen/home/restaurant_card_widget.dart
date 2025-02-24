import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_list/restaurant_list.dart';

class RestaurantCardWidget extends StatelessWidget {
  final RestaurantList restaurantItem;
  final Function() onTap;

  const RestaurantCardWidget({
    super.key,
    required this.restaurantItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag: restaurantItem.id,
                  child: Image.network(
                    '${ApiServices.baseUrl}/images/small/${restaurantItem.pictureId}',
                    fit: BoxFit.cover,
                    loadingBuilder: (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        // image loaded
                        return child;
                      } else {
                        // image loading
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Lottie.asset(
                              'assets/animations/lottie/food_loading.json',
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox.square(
              dimension: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    restaurantItem.name,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                    maxLines: 1,
                  ),
                  SizedBox.square(
                    dimension: 6,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        size: 18,
                        color: Colors.red,
                      ),
                      SizedBox.square(
                        dimension: 4,
                      ),
                      Expanded(
                        child: Text(
                          restaurantItem.city,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox.square(
                    dimension: 6,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: Colors.amberAccent,
                      ),
                      SizedBox.square(
                        dimension: 4,
                      ),
                      Expanded(
                        child: Text(
                          restaurantItem.rating.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
