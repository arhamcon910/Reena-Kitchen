import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, IsNumber, IsBoolean, IsEnum, Min } from 'class-validator';

export enum ItemCategory {
  VEGETABLE = 'VEGETABLE', FRUIT = 'FRUIT', GRAIN = 'GRAIN',
  DAIRY = 'DAIRY', SPICE = 'SPICE', OIL = 'OIL',
  LEGUME = 'LEGUME', NUT = 'NUT', HERB = 'HERB', OTHER = 'OTHER',
}

export class CreatePantryItemDto {
  @ApiProperty({ example: 'Onion' })
  @IsString()
  name: string;

  @ApiProperty({ example: 5, required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  quantity?: number;

  @ApiProperty({ example: 'kg', required: false })
  @IsOptional()
  @IsString()
  unit?: string;

  @ApiProperty({ enum: ItemCategory, default: 'OTHER', required: false })
  @IsOptional()
  @IsEnum(ItemCategory)
  category?: ItemCategory;

  @ApiProperty({ example: true, required: false })
  @IsOptional()
  @IsBoolean()
  inStock?: boolean;
}
