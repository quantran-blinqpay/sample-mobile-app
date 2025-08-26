import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:designerwardrobe/src/features/autumn_collection/domain/repositories/autumn_collection_repository.dart';
import 'package:designerwardrobe/src/features/home/domain/repositories/home_repository.dart';

class AutumnCollectionRepositoryImpl implements AutumnCollectionRepository {
  AutumnCollectionRepositoryImpl({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;
  String? _sessionId;
  String? _recommId;

  @override
  Future<void> initializeSession() async {
    // Use the existing home repository to initialize session
    final result = await _homeRepository.loadRecombeeSession();
    result.fold(
      (error) => throw Exception('Failed to initialize session: ${error.toString()}'),
      (sessionId) => _sessionId = sessionId,
    );
  }

  @override
  Future<List<ProductTile>> getRecommendedItems() async {
    // Ensure session is initialized
    if (_sessionId == null) {
      await initializeSession();
    }

    // Use the existing home repository to get recommended items
    final result = await _homeRepository.loadRecommendedItems(_sessionId!);
    return result.fold(
      (error) => throw Exception('Failed to load recommended items: ${error.toString()}'),
      (data) {
        _recommId = data?.recommId;
        return data?.recomms ?? [];
      },
    );
  }

  @override
  Future<List<ProductTile>> getNextItems() async {
    // Use the existing home repository to get next items
    if (_recommId == null) {
      throw Exception('No recommId available for loading next items');
    }

    final result = await _homeRepository.loadNextItems(_recommId!);
    return result.fold(
      (error) => throw Exception('Failed to load next items: ${error.toString()}'),
      (data) {
        _recommId = data?.recommId; // Update recommId for next pagination
        return data?.recomms ?? [];
      },
    );
  }
}
