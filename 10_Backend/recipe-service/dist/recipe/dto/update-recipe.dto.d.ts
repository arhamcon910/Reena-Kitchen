import { MealCategory, SpiceLevel } from './create-recipe.dto';
export declare class UpdateRecipeDto {
    name?: string;
    description?: string;
    cuisine?: string;
    category?: MealCategory;
    spiceLevel?: SpiceLevel;
    isVegetarian?: boolean;
    prepMinutes?: number;
    cookMinutes?: number;
    servings?: number;
    calories?: number;
    proteinG?: number;
    fibreG?: number;
    costInr?: number;
    ingredients?: string[];
    tags?: string[];
    festivals?: string[];
}
