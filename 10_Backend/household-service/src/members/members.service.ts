import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateMemberDto } from './dto/create-member.dto';
import { UpdateMemberDto } from './dto/update-member.dto';

@Injectable()
export class MembersService {
  constructor(private prisma: PrismaService) {}

  async create(householdId: string, dto: CreateMemberDto) {
    return this.prisma.member.create({
      data: { householdId, ...dto, healthGoals: dto.healthGoals ?? [] },
    });
  }

  async findAll(householdId: string) {
    return this.prisma.member.findMany({ where: { householdId } });
  }

  async findOne(householdId: string, id: string) {
    const member = await this.prisma.member.findFirst({ where: { id, householdId } });
    if (!member) throw new NotFoundException(`Member ${id} not found`);
    return member;
  }

  async update(householdId: string, id: string, dto: UpdateMemberDto) {
    await this.findOne(householdId, id);
    return this.prisma.member.update({ where: { id }, data: dto });
  }

  async remove(householdId: string, id: string) {
    await this.findOne(householdId, id);
    await this.prisma.member.delete({ where: { id } });
    return { message: 'Member deleted' };
  }
}
