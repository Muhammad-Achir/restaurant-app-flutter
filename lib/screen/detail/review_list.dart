import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail/restaurant.dart';
import 'package:restaurant_app/provider/detail/review_provider.dart';
import 'package:restaurant_app/screen/detail/review_item.dart';
import 'package:restaurant_app/static/review_result_state.dart';

class ReviewList extends StatefulWidget {
  final Restaurant restaurant;
  ReviewList({
    super.key,
    required this.restaurant,
  });

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = context.watch<ReviewProvider>().reviews;
    final reviewProvider = context.read<ReviewProvider>();

    return Column(
      children: [
        // context.watch<ReviewProvider>().reviews,
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // itemCount: restaurant.customerReviews.length,
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            // final review = restaurant.customerReviews[index];
            final review = reviews[index];
            return ReviewItem(
              review: review,
            );
          },
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius:
                BorderRadius.circular(20.0), // Membuat sudut melengkung
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withAlpha(50), // Memberikan efek bayangan halus
                offset: Offset(0, 4), // Posisi bayangan
                blurRadius: 6.0, // Efek kabur bayangan
              ),
            ],
          ),
          child: Consumer<ReviewProvider>(
            builder: (context, value, child) {
              return switch (value.resultState) {
                ReviewLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ReviewLoadedState() => Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: "Nama"),
                        textInputAction: TextInputAction.next,
                      ),
                      TextField(
                        controller: _reviewController,
                        decoration: InputDecoration(labelText: "Review"),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (_nameController.text.isNotEmpty &&
                              _reviewController.text.isNotEmpty) {
                            reviewProvider.addReview(widget.restaurant.id,
                                _nameController.text, _reviewController.text);
                            _nameController.clear();
                            _reviewController.clear();
                          }
                        },
                        child: Text("Add Review"),
                      ),
                    ],
                  ),
                ReviewErrorState() => Center(
                    child: Column(
                      children: [
                        Text(
                          'Failed add review!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            reviewProvider.resultState = ReviewLoadedState();
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                _ => const SizedBox(),
              };
            },
          ),
        )
      ],
    );
  }
}
