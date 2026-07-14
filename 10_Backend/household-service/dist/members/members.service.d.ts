import { PrismaService } from '../prisma/prisma.service';
import { CreateMemberDto } from './dto/create-member.dto';
import { UpdateMemberDto } from './dto/update-member.dto';
export declare class MembersService {
    private prisma;
    constructor(prisma: PrismaService);
    create(householdId: string, dto: CreateMemberDto): Promise<{
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        householdId: string;
        role: import(".prisma/client").$Enums.MemberRole;
        healthGoals: string[];
        dietaryNotes: string | null;
    }>;
    findAll(householdId: string): Promise<{
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        householdId: string;
        role: import(".prisma/client").$Enums.MemberRole;
        healthGoals: string[];
        dietaryNotes: string | null;
    }[]>;
    findOne(householdId: string, id: string): Promise<{
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        householdId: string;
        role: import(".prisma/client").$Enums.MemberRole;
        healthGoals: string[];
        dietaryNotes: string | null;
    }>;
    update(householdId: string, id: string, dto: UpdateMemberDto): Promise<{
        name: string;
        id: string;
        createdAt: Date;
        updatedAt: Date;
        householdId: string;
        role: import(".prisma/client").$Enums.MemberRole;
        healthGoals: string[];
        dietaryNotes: string | null;
    }>;
    remove(householdId: string, id: string): Promise<{
        message: string;
    }>;
}
