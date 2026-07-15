import { MealCategory, SpiceLevel } from './create-recipe.dto';
export declare class SearchRecipeDto {
    q?: string;
    category?: MealCategory;
    spiceLevel?: SpiceLevel;
    cuisine?: string;
    festival?: string;
    vegetarianOnly?: boolean;
    maxMinutes?: string;
    maxCostInr?: string;
}
