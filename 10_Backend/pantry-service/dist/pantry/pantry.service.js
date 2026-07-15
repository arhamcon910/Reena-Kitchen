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
exports.PantryService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let PantryService = class PantryService {
    constructor(prisma) {
        this.prisma = prisma;
    }
    async create(householdId, dto) {
        return this.prisma.pantryItem.create({
            data: { householdId, ...dto },
        });
    }
    async findAll(householdId) {
        return this.prisma.pantryItem.findMany({
            where: { householdId },
            orderBy: { name: 'asc' },
        });
    }
    async findInStock(householdId) {
        return this.prisma.pantryItem.findMany({
            where: { householdId, inStock: true },
            orderBy: { name: 'asc' },
        });
    }
    async findOne(householdId, id) {
        const item = await this.prisma.pantryItem.findFirst({
            where: { id, householdId },
        });
        if (!item)
            throw new common_1.NotFoundException(`Pantry item ${id} not found`);
        return item;
    }
    async update(householdId, id, dto) {
        await this.findOne(householdId, id);
        return this.prisma.pantryItem.update({ where: { id }, data: dto });
    }
    async remove(householdId, id) {
        await this.findOne(householdId, id);
        await this.prisma.pantryItem.delete({ where: { id } });
        return { message: 'Item removed from pantry' };
    }
    async bulkCreate(householdId, items) {
        const created = await this.prisma.$transaction(items.map((item) => this.prisma.pantryItem.create({ data: { householdId, ...item } })));
        return { count: created.length, items: created };
    }
};
exports.PantryService = PantryService;
exports.PantryService = PantryService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], PantryService);
//# sourceMappingURL=pantry.service.js.map