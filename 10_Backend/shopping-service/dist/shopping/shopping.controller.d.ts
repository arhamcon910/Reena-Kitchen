import { ShoppingService } from './shopping.service';
import { CreateListDto } from './dto/create-list.dto';
import { CreateItemDto } from './dto/create-item.dto';
import { UpdateItemDto } from './dto/update-item.dto';
import { GenerateListDto } from './dto/generate-list.dto';
export declare class ShoppingController {
    private shoppingService;
    constructor(shoppingService: ShoppingService);
    createList(householdId: string, dto: CreateListDto): Promise<{
        items: {
            name: string;
            quantity: number | null;
            unit: string | null;
            category: string;
            isPurchased: boolean;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            listId: string;
        }[];
    } & {
        name: string;
        id: string;
        householdId: string;
        status: import(".prisma/client").$Enums.ListStatus;
        createdAt: Date;
        updatedAt: Date;
    }>;
    generateList(householdId: string, dto: GenerateListDto): Promise<{
        message: string;
        skipped: string[];
        list: {
            items: {
                name: string;
                quantity: number | null;
                unit: string | null;
                category: string;
                isPurchased: boolean;
                id: string;
                createdAt: Date;
                updatedAt: Date;
                listId: string;
            }[];
        } & {
            name: string;
            id: string;
            householdId: string;
            status: import(".prisma/client").$Enums.ListStatus;
            createdAt: Date;
            updatedAt: Date;
        };
    }>;
    getLists(householdId: string): Promise<({
        items: {
            name: string;
            quantity: number | null;
            unit: string | null;
            category: string;
            isPurchased: boolean;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            listId: string;
        }[];
    } & {
        name: string;
        id: string;
        householdId: string;
        status: import(".prisma/client").$Enums.ListStatus;
        createdAt: Date;
        updatedAt: Date;
    })[]>;
    getList(householdId: string, listId: string): Promise<{
        items: {
            name: string;
            quantity: number | null;
            unit: string | null;
            category: string;
            isPurchased: boolean;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            listId: string;
        }[];
    } & {
        name: string;
        id: string;
        householdId: string;
        status: import(".prisma/client").$Enums.ListStatus;
        createdAt: Date;
        updatedAt: Date;
    }>;
    completeList(householdId: string, listId: string): Promise<{
        items: {
            name: string;
            quantity: number | null;
            unit: string | null;
            category: string;
            isPurchased: boolean;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            listId: string;
        }[];
    } & {
        name: string;
        id: string;
        householdId: string;
        status: import(".prisma/client").$Enums.ListStatus;
        createdAt: Date;
        updatedAt: Date;
    }>;
    deleteList(householdId: string, listId: string): Promise<{
        message: string;
    }>;
    addItem(householdId: string, listId: string, dto: CreateItemDto): Promise<{
        name: string;
        quantity: number | null;
        unit: string | null;
        category: string;
        isPurchased: boolean;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        listId: string;
    }>;
    updateItem(householdId: string, listId: string, itemId: string, dto: UpdateItemDto): Promise<{
        name: string;
        quantity: number | null;
        unit: string | null;
        category: string;
        isPurchased: boolean;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        listId: string;
    }>;
    markAllPurchased(householdId: string, listId: string): Promise<{
        items: {
            name: string;
            quantity: number | null;
            unit: string | null;
            category: string;
            isPurchased: boolean;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            listId: string;
        }[];
    } & {
        name: string;
        id: string;
        householdId: string;
        status: import(".prisma/client").$Enums.ListStatus;
        createdAt: Date;
        updatedAt: Date;
    }>;
    removeItem(householdId: string, listId: string, itemId: string): Promise<{
        message: string;
    }>;
}
