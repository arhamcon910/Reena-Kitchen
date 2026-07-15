import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, IsEnum, IsArray } from 'class-validator';
import { MemberRole } from './create-member.dto';

export class UpdateMemberDto {
  @ApiProperty({ example: 'Arham', required: false })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({ enum: MemberRole, required: false })
  @IsOptional()
  @IsEnum(MemberRole)
  role?: MemberRole;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  healthGoals?: string[];

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  dietaryNotes?: string;
}
