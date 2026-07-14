import { ItemCategory } from './create-pantry-item.dto';
export declare class UpdatePantryItemDto {
    name?: string;
    quantity?: number;
    unit?: string;
    category?: ItemCategory;
    inStock?: boolean;
}
