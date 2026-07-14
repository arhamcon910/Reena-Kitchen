import { ApiProperty } from '@nestjs/swagger';
import {
  IsString, IsOptional, IsBoolean, IsEnum,
  IsInt, IsNumber, IsArray, Min,
} from 'class-validator';
import { MealCategory, SpiceLevel } from './create-recipe.dto';

export class UpdateRecipeDto {
  @ApiProperty({ required: false }) @IsOptional() @IsString() name?: string;
  @ApiProperty({ required: false }) @IsOptional() @IsString() description?: string;
  @ApiProperty({ required: false }) @IsOptional() @IsString() cuisine?: string;
  @ApiProperty({ enum: MealCategory, required: false }) @IsOptional() @IsEnum(MealCategory) category?: MealCategory;
  @ApiProperty({ enum: SpiceLevel, required: false }) @IsOptional() @IsEnum(SpiceLevel) spiceLevel?: SpiceLevel;
  @ApiProperty({ required: false }) @IsOptional() @IsBoolean() isVegetarian?: boolean;
  @ApiProperty({ required: false }) @IsOptional() @IsInt() @Min(0) prepMinutes?: number;
  @ApiProperty({ required: false }) @IsOptional() @IsInt() @Min(1) cookMinutes?: number;
  @ApiProperty({ required: false }) @IsOptional() @IsInt() @Min(1) servings?: number;
  @ApiProperty({ required: false }) @IsOptional() @IsInt() calories?: number;
  @ApiProperty({ required: false }) @IsOptional() @IsNumber() proteinG?: number;
  @ApiProperty({ required: false }) @IsOptional() @IsNumber() fibreG?: number;
  @ApiProperty({ required: false }) @IsOptional() @IsInt() costInr?: number;
  @ApiProperty({ required: false }) @IsOptional() @IsArray() @IsString({ each: true }) ingredients?: string[];
  @ApiProperty({ required: false }) @IsOptional() @IsArray() @IsString({ each: true }) tags?: string[];
  @ApiProperty({ required: false }) @IsOptional() @IsArray() @IsString({ each: true }) festivals?: string[];
}
