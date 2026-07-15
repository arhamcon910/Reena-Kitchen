import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString, IsEnum, IsBoolean } from 'class-validator';
import { Transform } from 'class-transformer';
import { MealCategory, SpiceLevel } from './create-recipe.dto';

export class SearchRecipeDto {
  @ApiProperty({ required: false }) @IsOptional() @IsString() q?: string;
  @ApiProperty({ enum: MealCategory, required: false }) @IsOptional() @IsEnum(MealCategory) category?: MealCategory;
  @ApiProperty({ enum: SpiceLevel, required: false }) @IsOptional() @IsEnum(SpiceLevel) spiceLevel?: SpiceLevel;
  @ApiProperty({ required: false }) @IsOptional() @IsString() cuisine?: string;
  @ApiProperty({ required: false }) @IsOptional() @IsString() festival?: string;
  @ApiProperty({ required: false }) @IsOptional() @Transform(({ value }) => value === 'true') @IsBoolean() vegetarianOnly?: boolean;
  @ApiProperty({ required: false }) @IsOptional() @IsString() maxMinutes?: string;
  @ApiProperty({ required: false }) @IsOptional() @IsString() maxCostInr?: string;
}
