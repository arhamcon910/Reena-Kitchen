import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateHouseholdDto } from './dto/create-household.dto';
import { UpdateHouseholdDto } from './dto/update-household.dto';

@Injectable()
export class HouseholdService {
  constructor(private prisma: PrismaService) {}

  async create(dto: CreateHouseholdDto) {
    return this.prisma.household.create({
      data: { name: dto.name, timezone: dto.timezone ?? 'Asia/Kolkata' },
      include: { members: true },
    });
  }

  async findAll() {
    return this.prisma.household.findMany({ include: { members: true } });
  }

  async findOne(id: string) {
    const household = await this.prisma.household.findUnique({
      where: { id },
      include: { members: true },
    });
    if (!household) throw new NotFoundException(`Household ${id} not found`);
    return household;
  }

  async update(id: string, dto: UpdateHouseholdDto) {
    await this.findOne(id);
    return this.prisma.household.update({
      where: { id },
      data: dto,
      include: { members: true },
    });
  }

  async remove(id: string) {
    await this.findOne(id);
    await this.prisma.household.delete({ where: { id } });
    return { message: 'Household deleted' };
  }
}
