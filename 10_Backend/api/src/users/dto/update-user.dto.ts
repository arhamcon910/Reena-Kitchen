import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional } from 'class-validator';

export class UpdateUserDto {
  @ApiProperty({ example: 'Arham Contractor', required: false })
  @IsOptional()
  @IsString()
  name?: string;
}
