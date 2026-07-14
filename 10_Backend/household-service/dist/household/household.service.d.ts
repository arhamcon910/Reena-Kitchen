import { PrismaService } from '../prisma/prisma.service';
import { CreateHouseholdDto } from './dto/create-household.dto';
import { UpdateHouseholdDto } from './dto/update-household.dto';
export declare class HouseholdService {
    private prisma;
    constructor(prisma: PrismaService);
    create(dto: CreateHouseholdDto): Promise<{
        members: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            householdId: string;
            role: import(".prisma/client").$Enums.MemberRole;
            healthGoals: string[];
            dietaryNotes: string | null;
        }[];
    } & {
        name: string;
        timezone: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    findAll(): Promise<({
        members: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            householdId: string;
            role: import(".prisma/client").$Enums.MemberRole;
            healthGoals: string[];
            dietaryNotes: string | null;
        }[];
    } & {
        name: string;
        timezone: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
    })[]>;
    findOne(id: string): Promise<{
        members: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            householdId: string;
            role: import(".prisma/client").$Enums.MemberRole;
            healthGoals: string[];
            dietaryNotes: string | null;
        }[];
    } & {
        name: string;
        timezone: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    update(id: string, dto: UpdateHouseholdDto): Promise<{
        members: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            householdId: string;
            role: import(".prisma/client").$Enums.MemberRole;
            healthGoals: string[];
            dietaryNotes: string | null;
        }[];
    } & {
        name: string;
        timezone: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    remove(id: string): Promise<{
        message: string;
    }>;
}
