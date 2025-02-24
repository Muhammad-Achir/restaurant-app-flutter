import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail/customer_review.dart';

class ReviewItem extends StatelessWidget {
  final CustomerReview review;
  const ReviewItem({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // tileColor: Colors.red,
      title: Text(review.name),
      contentPadding: EdgeInsets.zero,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(review.review),
          Text(
            review.date,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
