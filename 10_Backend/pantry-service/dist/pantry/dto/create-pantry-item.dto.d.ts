export declare enum ItemCategory {
    VEGETABLE = "VEGETABLE",
    FRUIT = "FRUIT",
    GRAIN = "GRAIN",
    DAIRY = "DAIRY",
    SPICE = "SPICE",
    OIL = "OIL",
    LEGUME = "LEGUME",
    NUT = "NUT",
    HERB = "HERB",
    OTHER = "OTHER"
}
export declare class CreatePantryItemDto {
    name: string;
    quantity?: number;
    unit?: string;
    category?: ItemCategory;
    inStock?: boolean;
}
