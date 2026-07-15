import { Controller, Get, Post, Patch, Delete, Param, Body } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiCreatedResponse, ApiOkResponse } from '@nestjs/swagger';
import { HouseholdService } from './household.service';
import { CreateHouseholdDto } from './dto/create-household.dto';
import { UpdateHouseholdDto } from './dto/update-household.dto';

@ApiTags('Households')
@Controller('households')
export class HouseholdController {
  constructor(private householdService: HouseholdService) {}

  @Post()
  @ApiOperation({ summary: 'Create a household' })
  @ApiCreatedResponse({ description: 'Household created' })
  create(@Body() dto: CreateHouseholdDto) {
    return this.householdService.create(dto);
  }

  @Get()
  @ApiOperation({ summary: 'List all households' })
  @ApiOkResponse({ description: 'List of households' })
  findAll() {
    return this.householdService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get household by ID' })
  findOne(@Param('id') id: string) {
    return this.householdService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update household' })
  update(@Param('id') id: string, @Body() dto: UpdateHouseholdDto) {
    return this.householdService.update(id, dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete household' })
  remove(@Param('id') id: string) {
    return this.householdService.remove(id);
  }
}
