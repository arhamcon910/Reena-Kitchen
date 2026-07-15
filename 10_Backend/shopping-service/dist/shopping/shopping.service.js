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
exports.ShoppingService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let ShoppingService = class ShoppingService {
    constructor(prisma) {
        this.prisma = prisma;
    }
    async createList(householdId, dto) {
        return this.prisma.shoppingList.create({
            data: { householdId, name: dto.name },
            include: { items: true },
        });
    }
    async getLists(householdId) {
        return this.prisma.shoppingList.findMany({
            where: { householdId },
            include: {
                items: { orderBy: [{ isPurchased: 'asc' }, { name: 'asc' }] },
            },
            orderBy: { createdAt: 'desc' },
        });
    }
    async getList(householdId, listId) {
        const list = await this.prisma.shoppingList.findFirst({
            where: { id: listId, householdId },
            include: {
                items: { orderBy: [{ isPurchased: 'asc' }, { name: 'asc' }] },
            },
        });
        if (!list)
            throw new common_1.NotFoundException(`Shopping list ${listId} not found`);
        return list;
    }
    async completeList(householdId, listId) {
        await this.getList(householdId, listId);
        return this.prisma.shoppingList.update({
            where: { id: listId },
            data: { status: 'COMPLETED' },
            include: { items: true },
        });
    }
    async deleteList(householdId, listId) {
        await this.getList(householdId, listId);
        await this.prisma.shoppingList.delete({ where: { id: listId } });
        return { message: 'Shopping list deleted' };
    }
    async addItem(householdId, listId, dto) {
        await this.getList(householdId, listId);
        return this.prisma.shoppingItem.create({
            data: { listId, ...dto },
        });
    }
    async updateItem(householdId, listId, itemId, dto) {
        await this.getList(householdId, listId);
        const item = await this.prisma.shoppingItem.findFirst({
            where: { id: itemId, listId },
        });
        if (!item)
            throw new common_1.NotFoundException(`Item ${itemId} not found`);
        return this.prisma.shoppingItem.update({ where: { id: itemId }, data: dto });
    }
    async removeItem(householdId, listId, itemId) {
        await this.getList(householdId, listId);
        await this.prisma.shoppingItem.delete({ where: { id: itemId } });
        return { message: 'Item removed' };
    }
    async markAllPurchased(householdId, listId) {
        await this.getList(householdId, listId);
        await this.prisma.shoppingItem.updateMany({
            where: { listId },
            data: { isPurchased: true },
        });
        return this.getList(householdId, listId);
    }
    async generateList(householdId, dto) {
        const pantryLower = (dto.pantryItems ?? []).map((p) => p.toLowerCase());
        const needed = dto.ingredients.filter((i) => !pantryLower.some((p) => p.includes(i.toLowerCase()) ||
            i.toLowerCase().includes(p)));
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
    _guessCategory(ingredient) {
        const i = ingredient.toLowerCase();
        if (['onion', 'tomato', 'spinach', 'potato', 'carrot', 'cabbage', 'capsicum', 'chilli'].some(v => i.includes(v)))
            return 'VEGETABLE';
        if (['dal', 'lentil', 'chickpea', 'chana', 'rajma', 'moong'].some(v => i.includes(v)))
            return 'LEGUME';
        if (['rice', 'flour', 'oats', 'wheat', 'grain', 'atta', 'bread'].some(v => i.includes(v)))
            return 'GRAIN';
        if (['ghee', 'oil', 'butter'].some(v => i.includes(v)))
            return 'OIL';
        if (['milk', 'curd', 'paneer', 'cream', 'cheese', 'yogurt'].some(v => i.includes(v)))
            return 'DAIRY';
        if (['cumin', 'turmeric', 'coriander', 'masala', 'spice', 'pepper', 'cardamom', 'clove'].some(v => i.includes(v)))
            return 'SPICE';
        if (['ginger', 'garlic', 'mint', 'basil', 'curry'].some(v => i.includes(v)))
            return 'HERB';
        if (['peanut', 'cashew', 'almond', 'walnut', 'nut'].some(v => i.includes(v)))
            return 'NUT';
        if (['mango', 'banana', 'apple', 'lemon', 'orange', 'fruit'].some(v => i.includes(v)))
            return 'FRUIT';
        return 'OTHER';
    }
};
exports.ShoppingService = ShoppingService;
exports.ShoppingService = ShoppingService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], ShoppingService);
//# sourceMappingURL=shopping.service.js.map