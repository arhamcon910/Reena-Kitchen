import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateListDto } from './dto/create-list.dto';
import { CreateItemDto } from './dto/create-item.dto';
import { UpdateItemDto } from './dto/update-item.dto';
import { GenerateListDto } from './dto/generate-list.dto';

@Injectable()
export class ShoppingService {
  constructor(private prisma: PrismaService) {}

  // ── Lists ───────────────────────────────────────────────────────────────

  async createList(householdId: string, dto: CreateListDto) {
    return this.prisma.shoppingList.create({
      data: { householdId, name: dto.name },
      include: { items: true },
    });
  }

  async getLists(householdId: string) {
    return this.prisma.shoppingList.findMany({
      where: { householdId },
      include: {
        items: { orderBy: [{ isPurchased: 'asc' }, { name: 'asc' }] },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async getList(householdId: string, listId: string) {
    const list = await this.prisma.shoppingList.findFirst({
      where: { id: listId, householdId },
      include: {
        items: { orderBy: [{ isPurchased: 'asc' }, { name: 'asc' }] },
      },
    });
    if (!list) throw new NotFoundException(`Shopping list ${listId} not found`);
    return list;
  }

  async completeList(householdId: string, listId: string) {
    await this.getList(householdId, listId);
    return this.prisma.shoppingList.update({
      where: { id: listId },
      data: { status: 'COMPLETED' },
      include: { items: true },
    });
  }

  async deleteList(householdId: string, listId: string) {
    await this.getList(householdId, listId);
    await this.prisma.shoppingList.delete({ where: { id: listId } });
    return { message: 'Shopping list deleted' };
  }

  // ── Items ───────────────────────────────────────────────────────────────

  async addItem(householdId: string, listId: string, dto: CreateItemDto) {
    await this.getList(householdId, listId);
    return this.prisma.shoppingItem.create({
      data: { listId, ...dto },
    });
  }

  async updateItem(
    householdId: string,
    listId: string,
    itemId: string,
    dto: UpdateItemDto,
  ) {
    await this.getList(householdId, listId);
    const item = await this.prisma.shoppingItem.findFirst({
      where: { id: itemId, listId },
    });
    if (!item) throw new NotFoundException(`Item ${itemId} not found`);
    return this.prisma.shoppingItem.update({ where: { id: itemId }, data: dto });
  }

  async removeItem(householdId: string, listId: string, itemId: string) {
    await this.getList(householdId, listId);
    await this.prisma.shoppingItem.delete({ where: { id: itemId } });
    return { message: 'Item removed' };
  }

  async markAllPurchased(householdId: string, listId: string) {
    await this.getList(householdId, listId);
    await this.prisma.shoppingItem.updateMany({
      where: { listId },
      data: { isPurchased: true },
    });
    return this.getList(householdId, listId);
  }

  // ── Generate from ingredients ───────────────────────────────────────────

  async generateList(householdId: string, dto: GenerateListDto) {
    const pantryLower = (dto.pantryItems ?? []).map((p) => p.toLowerCase());

    // Filter out ingredients already in pantry
    const needed = dto.ingredients.filter(
      (i) => !pantryLower.some((p) => p.includes(i.toLowerCase()) ||
                                      i.toLowerCase().includes(p)),
    );

    if (needed.length === 0) {
      return {
        message: 'All ingredients are already in your pantry!',
        list: null,
        skipped: dto.ingredients,
      };
    }

    const list = await this.prisma.shoppingList.create({
      data: {
        householdId,
        name: dto.name,
        items: {
          create: needed.map((ingredient) => ({
            name: ingredient,
            category: this._guessCategory(ingredient),
          })),
        },
      },
      include: {
        items: { orderBy: { name: 'asc' } },
      },
    });

    return {
      message: `Generated list with ${needed.length} items`,
      skipped: dto.ingredients.filter((i) => !needed.includes(i)),
      list,
    };
  }

  private _guessCategory(ingredient: string): string {
    const i = ingredient.toLowerCase();
    if (['onion','tomato','spinach','potato','carrot','cabbage','capsicum','chilli'].some(v => i.includes(v))) return 'VEGETABLE';
    if (['dal','lentil','chickpea','chana','rajma','moong'].some(v => i.includes(v))) return 'LEGUME';
    if (['rice','flour','oats','wheat','grain','atta','bread'].some(v => i.includes(v))) return 'GRAIN';
    if (['ghee','oil','butter'].some(v => i.includes(v))) return 'OIL';
    if (['milk','curd','paneer','cream','cheese','yogurt'].some(v => i.includes(v))) return 'DAIRY';
    if (['cumin','turmeric','coriander','masala','spice','pepper','cardamom','clove'].some(v => i.includes(v))) return 'SPICE';
    if (['ginger','garlic','mint','basil','curry'].some(v => i.includes(v))) return 'HERB';
    if (['peanut','cashew','almond','walnut','nut'].some(v => i.includes(v))) return 'NUT';
    if (['mango','banana','apple','lemon','orange','fruit'].some(v => i.includes(v))) return 'FRUIT';
    return 'OTHER';
  }
}
