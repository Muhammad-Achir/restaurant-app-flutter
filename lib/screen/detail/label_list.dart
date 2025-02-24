import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail/category.dart';

class LabelList extends StatelessWidget {
  final List<Category> contents;

  const LabelList({
    super.key,
    required this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: contents.map((content) {
          return Container(
            margin: EdgeInsets.only(
              right: 12,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              content.name,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
