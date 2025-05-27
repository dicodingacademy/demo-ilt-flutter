import 'package:ui_error_app/model/tourism.dart';

abstract class DatabaseService {
  Future<int> insertItem(Place place);
  Future<List<Place>> getAllItems();
  Future<int> removeItem(int id);
  Future<int> updateItem(int itemId, Place place);
  Future<Place?> getItemById(int id);
}
