import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, MinLength } from 'class-validator';

export class CreateHouseholdDto {
  @ApiProperty({ example: 'The Arham Family' })
  @IsString()
  @MinLength(2)
  name: string;

  @ApiProperty({ example: 'Asia/Kolkata', required: false })
  @IsOptional()
  @IsString()
  timezone?: string;
}
