import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsArray, IsOptional } from 'class-validator';

export class GenerateListDto {
  @ApiProperty({ example: 'Weekly Groceries' })
  @IsString()
  name: string;

  @ApiProperty({
    description: 'Ingredient names to add to the shopping list',
    example: ['yellow dal', 'onion', 'tomato', 'ghee'],
  })
  @IsArray()
  @IsString({ each: true })
  ingredients: string[];

  @ApiProperty({
    description: 'Items already in pantry to exclude',
    example: ['onion', 'tomato'],
    required: false,
  })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  pantryItems?: string[];
}
