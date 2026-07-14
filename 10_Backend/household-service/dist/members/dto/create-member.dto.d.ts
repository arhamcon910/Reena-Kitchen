export declare enum MemberRole {
    HEAD = "HEAD",
    ADULT = "ADULT",
    CHILD = "CHILD",
    SENIOR = "SENIOR"
}
export declare class CreateMemberDto {
    name: string;
    role?: MemberRole;
    healthGoals?: string[];
    dietaryNotes?: string;
}
