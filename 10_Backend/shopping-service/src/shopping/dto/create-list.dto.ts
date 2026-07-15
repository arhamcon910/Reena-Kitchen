import { ApiProperty } from '@nestjs/swagger';
import { IsString, MinLength } from 'class-validator';

export class CreateListDto {
  @ApiProperty({ example: 'Weekly Groceries' })
  @IsString()
  @MinLength(2)
  name: string;
}
