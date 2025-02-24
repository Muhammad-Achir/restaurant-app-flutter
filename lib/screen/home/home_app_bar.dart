import 'package:flutter/material.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/typography/restaurant_text_style.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // backgroundColor: Colors.blue[800],
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      pinned: true,
      floating: false,
      snap: false,
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.5,
        title: LayoutBuilder(
          builder: (context, constraints) {
            final currentHeight = constraints.biggest.height;
            final threshold = 100.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Restaurant List',
                      style: RestaurantTextStyle.displaySmall.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      key: const ValueKey('searchButton'),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          NavigationRoute.searchRoute.name,
                        );
                      },
                      icon: Icon(
                        Icons.manage_search_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 32,
                      ),
                    ),
                  ],
                ),
                if (currentHeight > threshold)
                  Text(
                    'Find the best restaurants around you!',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
              ],
            );
          },
        ),
        titlePadding: const EdgeInsets.all(16),
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.inversePrimary,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ),
          ),
          // child: Image.network(
          //   'https://picsum.photos/1600/900',
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }
}
