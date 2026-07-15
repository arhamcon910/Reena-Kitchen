class Recipe {
  const Recipe({
    required this.id,
    required this.name,
    this.description,
    required this.cuisine,
    required this.category,
    required this.spiceLevel,
    required this.isVegetarian,
    required this.prepMinutes,
    required this.cookMinutes,
    required this.servings,
    this.calories,
    this.proteinG,
    this.fibreG,
    this.costInr,
    required this.ingredients,
    required this.tags,
    required this.festivals,
  });

  final String id;
  final String name;
  final String? description;
  final String cuisine;
  final String category;
  final String spiceLevel;
  final bool isVegetarian;
  final int prepMinutes;
  final int cookMinutes;
  final int servings;
  final int? calories;
  final double? proteinG;
  final double? fibreG;
  final int? costInr;
  final List<String> ingredients;
  final List<String> tags;
  final List<String> festivals;

  int get totalMinutes => prepMinutes + cookMinutes;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        cuisine: json['cuisine'] as String? ?? 'Indian',
        category: json['category'] as String,
        spiceLevel: json['spiceLevel'] as String? ?? 'MEDIUM',
        isVegetarian: json['isVegetarian'] as bool? ?? true,
        prepMinutes: json['prepMinutes'] as int? ?? 0,
        cookMinutes: json['cookMinutes'] as int,
        servings: json['servings'] as int? ?? 4,
        calories: json['calories'] as int?,
        proteinG: (json['proteinG'] as num?)?.toDouble(),
        fibreG: (json['fibreG'] as num?)?.toDouble(),
        costInr: json['costInr'] as int?,
        ingredients: (json['ingredients'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        tags: (json['tags'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        festivals: (json['festivals'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
      );

  static const categories = [
    'ALL','BREAKFAST','LUNCH','DINNER','SNACK','DESSERT','DRINK',
  ];

  static const spiceColors = {
    'MILD': 0xFF4CAF50,
    'MEDIUM': 0xFFFF9800,
    'HOT': 0xFFF44336,
  };
}
