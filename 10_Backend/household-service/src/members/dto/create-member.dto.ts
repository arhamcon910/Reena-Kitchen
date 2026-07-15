import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, IsEnum, IsArray } from 'class-validator';

export enum MemberRole { HEAD = 'HEAD', ADULT = 'ADULT', CHILD = 'CHILD', SENIOR = 'SENIOR' }

export class CreateMemberDto {
  @ApiProperty({ example: 'Arham' })
  @IsString()
  name: string;

  @ApiProperty({ enum: MemberRole, default: 'ADULT', required: false })
  @IsOptional()
  @IsEnum(MemberRole)
  role?: MemberRole;

  @ApiProperty({ example: ['weight management', 'more protein'], required: false })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  healthGoals?: string[];

  @ApiProperty({ example: 'No onions', required: false })
  @IsOptional()
  @IsString()
  dietaryNotes?: string;
}
