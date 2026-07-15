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
exports.HouseholdService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let HouseholdService = class HouseholdService {
    constructor(prisma) {
        this.prisma = prisma;
    }
    async create(dto) {
        return this.prisma.household.create({
            data: { name: dto.name, timezone: dto.timezone ?? 'Asia/Kolkata' },
            include: { members: true },
        });
    }
    async findAll() {
        return this.prisma.household.findMany({ include: { members: true } });
    }
    async findOne(id) {
        const household = await this.prisma.household.findUnique({
            where: { id },
            include: { members: true },
        });
        if (!household)
            throw new common_1.NotFoundException(`Household ${id} not found`);
        return household;
    }
    async update(id, dto) {
        await this.findOne(id);
        return this.prisma.household.update({
            where: { id },
            data: dto,
            include: { members: true },
        });
    }
    async remove(id) {
        await this.findOne(id);
        await this.prisma.household.delete({ where: { id } });
        return { message: 'Household deleted' };
    }
};
exports.HouseholdService = HouseholdService;
exports.HouseholdService = HouseholdService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], HouseholdService);
//# sourceMappingURL=household.service.js.map