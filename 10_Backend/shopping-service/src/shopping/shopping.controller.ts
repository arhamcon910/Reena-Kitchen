import { Controller, Get, Post, Patch, Delete, Param, Body } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiCreatedResponse, ApiOkResponse } from '@nestjs/swagger';
import { ShoppingService } from './shopping.service';
import { CreateListDto } from './dto/create-list.dto';
import { CreateItemDto } from './dto/create-item.dto';
import { UpdateItemDto } from './dto/update-item.dto';
import { GenerateListDto } from './dto/generate-list.dto';

@ApiTags('Shopping')
@Controller('shopping/:householdId')
export class ShoppingController {
  constructor(private shoppingService: ShoppingService) {}

  // ── Lists ───────────────────────────────────────────────────────────────

  @Post('lists')
  @ApiOperation({ summary: 'Create a shopping list' })
  @ApiCreatedResponse({ description: 'List created' })
  createList(
    @Param('householdId') householdId: string,
    @Body() dto: CreateListDto,
  ) {
    return this.shoppingService.createList(householdId, dto);
  }

  @Post('lists/generate')
  @ApiOperation({ summary: 'Generate shopping list from ingredients (excluding pantry)' })
  generateList(
    @Param('householdId') householdId: string,
    @Body() dto: GenerateListDto,
  ) {
    return this.shoppingService.generateList(householdId, dto);
  }

  @Get('lists')
  @ApiOperation({ summary: 'Get all shopping lists' })
  @ApiOkResponse({ description: 'All lists with items' })
  getLists(@Param('householdId') householdId: string) {
    return this.shoppingService.getLists(householdId);
  }

  @Get('lists/:listId')
  @ApiOperation({ summary: 'Get a shopping list with items' })
  getList(
    @Param('householdId') householdId: string,
    @Param('listId') listId: string,
  ) {
    return this.shoppingService.getList(householdId, listId);
  }

  @Patch('lists/:listId/complete')
  @ApiOperation({ summary: 'Mark list as completed' })
  completeList(
    @Param('householdId') householdId: string,
    @Param('listId') listId: string,
  ) {
    return this.shoppingService.completeList(householdId, listId);
  }

  @Delete('lists/:listId')
  @ApiOperation({ summary: 'Delete a shopping list' })
  deleteList(
    @Param('householdId') householdId: string,
    @Param('listId') listId: string,
  ) {
    return this.shoppingService.deleteList(householdId, listId);
  }

  // ── Items ───────────────────────────────────────────────────────────────

  @Post('lists/:listId/items')
  @ApiOperation({ summary: 'Add item to shopping list' })
  addItem(
    @Param('householdId') householdId: string,
    @Param('listId') listId: string,
    @Body() dto: CreateItemDto,
  ) {
    return this.shoppingService.addItem(householdId, listId, dto);
  }

  @Patch('lists/:listId/items/:itemId')
  @ApiOperation({ summary: 'Update item (mark purchased, change quantity)' })
  updateItem(
    @Param('householdId') householdId: string,
    @Param('listId') listId: string,
    @Param('itemId') itemId: string,
    @Body() dto: UpdateItemDto,
  ) {
    return this.shoppingService.updateItem(householdId, listId, itemId, dto);
  }

  @Patch('lists/:listId/items/mark-all-purchased')
  @ApiOperation({ summary: 'Mark all items as purchased' })
  markAllPurchased(
    @Param('householdId') householdId: string,
    @Param('listId') listId: string,
  ) {
    return this.shoppingService.markAllPurchased(householdId, listId);
  }

  @Delete('lists/:listId/items/:itemId')
  @ApiOperation({ summary: 'Remove item from list' })
  removeItem(
    @Param('householdId') householdId: string,
    @Param('listId') listId: string,
    @Param('itemId') itemId: string,
  ) {
    return this.shoppingService.removeItem(householdId, listId, itemId);
  }
}
