import { Controller, Get, Post, Patch, Delete, Param, Body } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiCreatedResponse, ApiOkResponse } from '@nestjs/swagger';
import { PantryService } from './pantry.service';
import { CreatePantryItemDto } from './dto/create-pantry-item.dto';
import { UpdatePantryItemDto } from './dto/update-pantry-item.dto';

@ApiTags('Pantry')
@Controller('pantry/:householdId/items')
export class PantryController {
  constructor(private pantryService: PantryService) {}

  @Post()
  @ApiOperation({ summary: 'Add item to pantry' })
  @ApiCreatedResponse({ description: 'Item added' })
  create(
    @Param('householdId') householdId: string,
    @Body() dto: CreatePantryItemDto,
  ) {
    return this.pantryService.create(householdId, dto);
  }

  @Post('bulk')
  @ApiOperation({ summary: 'Add multiple items to pantry' })
  bulkCreate(
    @Param('householdId') householdId: string,
    @Body() dto: CreatePantryItemDto[],
  ) {
    return this.pantryService.bulkCreate(householdId, dto);
  }

  @Get()
  @ApiOperation({ summary: 'List all pantry items' })
  @ApiOkResponse({ description: 'All pantry items' })
  findAll(@Param('householdId') householdId: string) {
    return this.pantryService.findAll(householdId);
  }

  @Get('in-stock')
  @ApiOperation({ summary: 'List in-stock items only' })
  findInStock(@Param('householdId') householdId: string) {
    return this.pantryService.findInStock(householdId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get pantry item by ID' })
  findOne(
    @Param('householdId') householdId: string,
    @Param('id') id: string,
  ) {
    return this.pantryService.findOne(householdId, id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update pantry item' })
  update(
    @Param('householdId') householdId: string,
    @Param('id') id: string,
    @Body() dto: UpdatePantryItemDto,
  ) {
    return this.pantryService.update(householdId, id, dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Remove pantry item' })
  remove(
    @Param('householdId') householdId: string,
    @Param('id') id: string,
  ) {
    return this.pantryService.remove(householdId, id);
  }
}
