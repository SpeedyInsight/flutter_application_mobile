import 'package:hive_flutter/hive_flutter.dart';

part 'favorite_item_model.g.dart';

@HiveType(typeId: 2)
class FavoriteItem extends HiveObject {
  FavoriteItem({
    required this.userId,
    required this.itemId,
    required this.itemType,
  });

  @HiveField(0)
  int userId;

  @HiveField(1)
  int itemId;

  @HiveField(2)
  String itemType;

  @override
  String toString() {
    return 'FavoriteItem{userId: $userId, itemId: $itemId, itemType: $itemType}';
  }
}

class HiveService {
  static Future<void> addFavorite(FavoriteItem item) async {
    final box = await Hive.openBox<FavoriteItem>('favorites');
    await box.add(item);
  }

  static Future<List<FavoriteItem>> getFavoritesByUser(int userId) async {
    final box = await Hive.openBox<FavoriteItem>('favorites');
    final favorites = box.values.where((item) => item.userId == userId).toList();
    return favorites;
  }

  static Future<void> removeFavorite(int userId, int itemId) async {
    final box = await Hive.openBox<FavoriteItem>('favorites');
    final favorite = box.values.firstWhere((item) => item.userId == userId && item.itemId == itemId);
    if (favorite != null) {
      await favorite.delete();
    }
  }

  static Future<bool> isFavorite(int userId, int itemId) async {
    final box = await Hive.openBox<FavoriteItem>('favorites');
    final favorite = box.values.firstWhere((item) => item.userId == userId && item.itemId == itemId);
    return favorite != null;
  }
}
