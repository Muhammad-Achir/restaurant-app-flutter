import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant.dart';
import 'package:restaurant_app/screen/detail/favorite_icon_widget.dart';
import 'package:restaurant_app/screen/detail/label_list.dart';
import 'package:restaurant_app/screen/detail/review_list.dart';

class DetailScreenContent extends StatelessWidget {
  final Restaurant restaurant;
  const DetailScreenContent({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Hero(
                tag: restaurant.id,
                child: Image.network(
                  '${ApiServices.baseUrl}/images/medium/${restaurant.pictureId}',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(100.0),
                          child: Lottie.asset(
                            'assets/animations/lottie/food_loading.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 100.0,
                        bottom: 50,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 100,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: -25,
                right: 20,
                child: FavoriteIconWidget(restaurant: restaurant),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headlineMedium,
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
                        '${restaurant.city} on ${restaurant.address}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                  height: 20,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 12,
                ),
                ReadMoreText(
                  restaurant.description,
                  trimMode: TrimMode.Line,
                  trimLines: 4,
                  colorClickableText: Colors.pink,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: ' Show less',
                  textAlign: TextAlign.justify,
                ),
                Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                  height: 20,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Category',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 12,
                ),
                LabelList(
                  contents: restaurant.categories,
                ),
                Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                  height: 20,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Menus',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Foods',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 4,
                ),
                LabelList(contents: restaurant.menus.foods),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Drinks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 4,
                ),
                LabelList(contents: restaurant.menus.drinks),
                Divider(
                  color: Colors.blueGrey,
                  thickness: 1,
                  height: 20,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      restaurant.rating.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox.square(
                      dimension: 4,
                    ),
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
                        'Product Rating'.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                ReviewList(restaurant: restaurant),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
