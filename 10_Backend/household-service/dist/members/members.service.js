"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MembersService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let MembersService = class MembersService {
    constructor(prisma) {
        this.prisma = prisma;
    }
    async create(householdId, dto) {
        return this.prisma.member.create({
            data: { householdId, ...dto, healthGoals: dto.healthGoals ?? [] },
        });
    }
    async findAll(householdId) {
        return this.prisma.member.findMany({ where: { householdId } });
    }
    async findOne(householdId, id) {
        const member = await this.prisma.member.findFirst({ where: { id, householdId } });
        if (!member)
            throw new common_1.NotFoundException(`Member ${id} not found`);
        return member;
    }
    async update(householdId, id, dto) {
        await this.findOne(householdId, id);
        return this.prisma.member.update({ where: { id }, data: dto });
    }
    async remove(householdId, id) {
        await this.findOne(householdId, id);
        await this.prisma.member.delete({ where: { id } });
        return { message: 'Member deleted' };
    }
};
exports.MembersService = MembersService;
exports.MembersService = MembersService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], MembersService);
//# sourceMappingURL=members.service.js.map