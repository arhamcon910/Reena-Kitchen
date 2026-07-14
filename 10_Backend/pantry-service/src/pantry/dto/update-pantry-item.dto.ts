import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, IsNumber, IsBoolean, IsEnum, Min } from 'class-validator';
import { ItemCategory } from './create-pantry-item.dto';

export class UpdatePantryItemDto {
  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  quantity?: number;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  unit?: string;

  @ApiProperty({ enum: ItemCategory, required: false })
  @IsOptional()
  @IsEnum(ItemCategory)
  category?: ItemCategory;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsBoolean()
  inStock?: boolean;
}
