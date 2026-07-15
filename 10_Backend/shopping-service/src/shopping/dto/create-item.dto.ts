import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, IsNumber, IsBoolean, Min } from 'class-validator';

export class CreateItemDto {
  @ApiProperty({ example: 'Onion' })
  @IsString()
  name: string;

  @ApiProperty({ example: 2, required: false })
  @IsOptional()
  @IsNumber()
  @Min(0)
  quantity?: number;

  @ApiProperty({ example: 'kg', required: false })
  @IsOptional()
  @IsString()
  unit?: string;

  @ApiProperty({ example: 'VEGETABLE', required: false })
  @IsOptional()
  @IsString()
  category?: string;
}
