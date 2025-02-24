import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_list/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_list/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockRestaurantListProvider extends Mock implements ApiServices {}

void main() {
  late MockRestaurantListProvider apiServices;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    apiServices = MockRestaurantListProvider();
    restaurantListProvider = RestaurantListProvider(apiServices);
  });

  group('restaurant list provider', () {
    test('should return RestaurantListNoneState when provider initialize', () {
      final initState = restaurantListProvider.resultState;

      expect(initState, isA<RestaurantListNoneState>());
    });

    test(
        'should return RestaurantListLoaded when success fetch restaurant list datas',
        () async {
      final fakeRestaurantList = RestaurantListResponse(
        error: false,
        message: 'message',
        count: 1,
        restaurants: [
          RestaurantList(
              id: '1',
              name: 'name',
              description: 'description',
              pictureId: 'pictureId',
              city: 'city',
              rating: 2.3),
        ],
      );
      when(() => apiServices.getRestaurantList()).thenAnswer(
        (_) async => fakeRestaurantList,
      );

      await restaurantListProvider.fetchRestaurantList();

      expect(
        restaurantListProvider.resultState,
        isA<RestaurantListLoadedState>(),
      );
    });

    test(
        'should return RestaurantListErrorState when fetch restaurant list is failed',
        () async {
      when(() => apiServices.getRestaurantList())
          .thenAnswer((_) async => RestaurantListResponse(
                error: true,
                message: 'message',
                count: 0,
                restaurants: [],
              ));

      await restaurantListProvider.fetchRestaurantList();

      expect(
          restaurantListProvider.resultState, isA<RestaurantListErrorState>());
    });
  });
}
