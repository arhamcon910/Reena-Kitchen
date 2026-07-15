import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, IsNumber, IsBoolean, Min } from 'class-validator';

export class UpdateItemDto {
  @ApiProperty({ required: false }) @IsOptional() @IsString()  name?: string;
  @ApiProperty({ required: false }) @IsOptional() @IsNumber() @Min(0) quantity?: number;
  @ApiProperty({ required: false }) @IsOptional() @IsString()  unit?: string;
  @ApiProperty({ required: false }) @IsOptional() @IsString()  category?: string;
  @ApiProperty({ required: false }) @IsOptional() @IsBoolean() isPurchased?: boolean;
}
