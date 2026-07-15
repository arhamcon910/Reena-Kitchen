class ShoppingItem {
  const ShoppingItem({
    required this.id,
    required this.listId,
    required this.name,
    this.quantity,
    this.unit,
    required this.category,
    required this.isPurchased,
  });

  final String id;
  final String listId;
  final String name;
  final double? quantity;
  final String? unit;
  final String category;
  final bool isPurchased;

  factory ShoppingItem.fromJson(Map<String, dynamic> json) => ShoppingItem(
        id: json['id'] as String,
        listId: json['listId'] as String,
        name: json['name'] as String,
        quantity: (json['quantity'] as num?)?.toDouble(),
        unit: json['unit'] as String?,
        category: json['category'] as String? ?? 'OTHER',
        isPurchased: json['isPurchased'] as bool? ?? false,
      );
}

class ShoppingList {
  const ShoppingList({
    required this.id,
    required this.householdId,
    required this.name,
    required this.status,
    required this.items,
    required this.createdAt,
  });

  final String id;
  final String householdId;
  final String name;
  final String status;
  final List<ShoppingItem> items;
  final DateTime createdAt;

  int get totalItems => items.length;
  int get purchasedItems => items.where((i) => i.isPurchased).length;
  double get progress => totalItems > 0 ? purchasedItems / totalItems : 0;
  bool get isCompleted => status == 'COMPLETED';

  factory ShoppingList.fromJson(Map<String, dynamic> json) => ShoppingList(
        id: json['id'] as String,
        householdId: json['householdId'] as String,
        name: json['name'] as String,
        status: json['status'] as String? ?? 'ACTIVE',
        items: (json['items'] as List<dynamic>? ?? [])
            .map((e) => ShoppingItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
            DateTime.now(),
      );
}
