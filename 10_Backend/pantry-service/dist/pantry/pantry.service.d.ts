import { PrismaService } from '../prisma/prisma.service';
import { CreatePantryItemDto } from './dto/create-pantry-item.dto';
import { UpdatePantryItemDto } from './dto/update-pantry-item.dto';
export declare class PantryService {
    private prisma;
    constructor(prisma: PrismaService);
    create(householdId: string, dto: CreatePantryItemDto): Promise<{
        name: string;
        quantity: number | null;
        unit: string | null;
        category: import(".prisma/client").$Enums.ItemCategory;
        inStock: boolean;
        id: string;
        householdId: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    findAll(householdId: string): Promise<{
        name: string;
        quantity: number | null;
        unit: string | null;
        category: import(".prisma/client").$Enums.ItemCategory;
        inStock: boolean;
        id: string;
        householdId: string;
        createdAt: Date;
        updatedAt: Date;
    }[]>;
    findInStock(householdId: string): Promise<{
        name: string;
        quantity: number | null;
        unit: string | null;
        category: import(".prisma/client").$Enums.ItemCategory;
        inStock: boolean;
        id: string;
        householdId: string;
        createdAt: Date;
        updatedAt: Date;
    }[]>;
    findOne(householdId: string, id: string): Promise<{
        name: string;
        quantity: number | null;
        unit: string | null;
        category: import(".prisma/client").$Enums.ItemCategory;
        inStock: boolean;
        id: string;
        householdId: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    update(householdId: string, id: string, dto: UpdatePantryItemDto): Promise<{
        name: string;
        quantity: number | null;
        unit: string | null;
        category: import(".prisma/client").$Enums.ItemCategory;
        inStock: boolean;
        id: string;
        householdId: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    remove(householdId: string, id: string): Promise<{
        message: string;
    }>;
    bulkCreate(householdId: string, items: CreatePantryItemDto[]): Promise<{
        count: number;
        items: {
            name: string;
            quantity: number | null;
            unit: string | null;
            category: import(".prisma/client").$Enums.ItemCategory;
            inStock: boolean;
            id: string;
            householdId: string;
            createdAt: Date;
            updatedAt: Date;
        }[];
    }>;
}
