import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreatePantryItemDto } from './dto/create-pantry-item.dto';
import { UpdatePantryItemDto } from './dto/update-pantry-item.dto';

@Injectable()
export class PantryService {
  constructor(private prisma: PrismaService) {}

  async create(householdId: string, dto: CreatePantryItemDto) {
    return this.prisma.pantryItem.create({
      data: { householdId, ...dto },
    });
  }

  async findAll(householdId: string) {
    return this.prisma.pantryItem.findMany({
      where: { householdId },
      orderBy: { name: 'asc' },
    });
  }

  async findInStock(householdId: string) {
    return this.prisma.pantryItem.findMany({
      where: { householdId, inStock: true },
      orderBy: { name: 'asc' },
    });
  }

  async findOne(householdId: string, id: string) {
    const item = await this.prisma.pantryItem.findFirst({
      where: { id, householdId },
    });
    if (!item) throw new NotFoundException(`Pantry item ${id} not found`);
    return item;
  }

  async update(householdId: string, id: string, dto: UpdatePantryItemDto) {
    await this.findOne(householdId, id);
    return this.prisma.pantryItem.update({ where: { id }, data: dto });
  }

  async remove(householdId: string, id: string) {
    await this.findOne(householdId, id);
    await this.prisma.pantryItem.delete({ where: { id } });
    return { message: 'Item removed from pantry' };
  }

  async bulkCreate(householdId: string, items: CreatePantryItemDto[]) {
    const created = await this.prisma.$transaction(
      items.map((item) =>
        this.prisma.pantryItem.create({ data: { householdId, ...item } }),
      ),
    );
    return { count: created.length, items: created };
  }
}
