import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_tile.dart';

abstract class AutumnCollectionRepository {
  Future<void> initializeSession();
  Future<List<ProductTile>> getRecommendedItems();
  Future<List<ProductTile>> getNextItems();
}
