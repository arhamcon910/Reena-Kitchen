export declare enum MealCategory {
    BREAKFAST = "BREAKFAST",
    LUNCH = "LUNCH",
    DINNER = "DINNER",
    SNACK = "SNACK",
    DESSERT = "DESSERT",
    DRINK = "DRINK"
}
export declare enum SpiceLevel {
    MILD = "MILD",
    MEDIUM = "MEDIUM",
    HOT = "HOT"
}
export declare class CreateRecipeDto {
    name: string;
    description?: string;
    cuisine?: string;
    category: MealCategory;
    spiceLevel?: SpiceLevel;
    isVegetarian?: boolean;
    prepMinutes?: number;
    cookMinutes: number;
    servings?: number;
    calories?: number;
    proteinG?: number;
    fibreG?: number;
    costInr?: number;
    ingredients?: string[];
    tags?: string[];
    festivals?: string[];
}
