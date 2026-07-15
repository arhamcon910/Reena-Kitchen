import { ApiProperty } from '@nestjs/swagger';
import {
  IsString, IsOptional, IsBoolean, IsEnum,
  IsInt, IsNumber, IsArray, Min,
} from 'class-validator';

export enum MealCategory {
  BREAKFAST = 'BREAKFAST', LUNCH = 'LUNCH', DINNER = 'DINNER',
  SNACK = 'SNACK', DESSERT = 'DESSERT', DRINK = 'DRINK',
}

export enum SpiceLevel {
  MILD = 'MILD', MEDIUM = 'MEDIUM', HOT = 'HOT',
}

export class CreateRecipeDto {
  @ApiProperty({ example: 'Dal Tadka' })
  @IsString()
  name: string;

  @ApiProperty({ example: 'Classic North Indian yellow lentil curry', required: false })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ example: 'North Indian', required: false })
  @IsOptional()
  @IsString()
  cuisine?: string;

  @ApiProperty({ enum: MealCategory })
  @IsEnum(MealCategory)
  category: MealCategory;

  @ApiProperty({ enum: SpiceLevel, default: 'MEDIUM', required: false })
  @IsOptional()
  @IsEnum(SpiceLevel)
  spiceLevel?: SpiceLevel;

  @ApiProperty({ example: true, default: true, required: false })
  @IsOptional()
  @IsBoolean()
  isVegetarian?: boolean;

  @ApiProperty({ example: 10, required: false })
  @IsOptional()
  @IsInt()
  @Min(0)
  prepMinutes?: number;

  @ApiProperty({ example: 30 })
  @IsInt()
  @Min(1)
  cookMinutes: number;

  @ApiProperty({ example: 4, required: false })
  @IsOptional()
  @IsInt()
  @Min(1)
  servings?: number;

  @ApiProperty({ example: 320, required: false })
  @IsOptional()
  @IsInt()
  calories?: number;

  @ApiProperty({ example: 18.5, required: false })
  @IsOptional()
  @IsNumber()
  proteinG?: number;

  @ApiProperty({ example: 6.2, required: false })
  @IsOptional()
  @IsNumber()
  fibreG?: number;

  @ApiProperty({ example: 80, required: false })
  @IsOptional()
  @IsInt()
  costInr?: number;

  @ApiProperty({ example: ['yellow dal', 'onion', 'tomato', 'ghee'], required: false })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  ingredients?: string[];

  @ApiProperty({ example: ['protein', 'comfort food'], required: false })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  tags?: string[];

  @ApiProperty({ example: ['Diwali', 'Pongal'], required: false })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  festivals?: string[];
}
