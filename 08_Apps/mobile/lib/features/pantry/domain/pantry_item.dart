class PantryItem {
  const PantryItem({
    required this.id,
    required this.householdId,
    required this.name,
    this.quantity,
    this.unit,
    required this.category,
    required this.inStock,
  });

  final String id;
  final String householdId;
  final String name;
  final double? quantity;
  final String? unit;
  final String category;
  final bool inStock;

  factory PantryItem.fromJson(Map<String, dynamic> json) => PantryItem(
        id: json['id'] as String,
        householdId: json['householdId'] as String,
        name: json['name'] as String,
        quantity: (json['quantity'] as num?)?.toDouble(),
        unit: json['unit'] as String?,
        category: json['category'] as String? ?? 'OTHER',
        inStock: json['inStock'] as bool? ?? true,
      );

  PantryItem copyWith({bool? inStock}) => PantryItem(
        id: id,
        householdId: householdId,
        name: name,
        quantity: quantity,
        unit: unit,
        category: category,
        inStock: inStock ?? this.inStock,
      );

  static const categories = [
    'VEGETABLE', 'FRUIT', 'GRAIN', 'DAIRY',
    'SPICE', 'OIL', 'LEGUME', 'NUT', 'HERB', 'OTHER',
  ];
}
