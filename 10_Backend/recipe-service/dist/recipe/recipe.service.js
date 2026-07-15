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
exports.RecipeService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let RecipeService = class RecipeService {
    constructor(prisma) {
        this.prisma = prisma;
    }
    async create(dto) {
        return this.prisma.recipe.create({
            data: {
                ...dto,
                isVegetarian: dto.isVegetarian ?? true,
                ingredients: dto.ingredients ?? [],
                tags: dto.tags ?? [],
                festivals: dto.festivals ?? [],
            },
        });
    }
    async findAll() {
        return this.prisma.recipe.findMany({ orderBy: { name: 'asc' } });
    }
    async search(query) {
        const where = {};
        if (query.q) {
            where.OR = [
                { name: { contains: query.q, mode: 'insensitive' } },
                { description: { contains: query.q, mode: 'insensitive' } },
                { ingredients: { has: query.q } },
                { tags: { has: query.q } },
            ];
        }
        if (query.category)
            where.category = query.category;
        if (query.spiceLevel)
            where.spiceLevel = query.spiceLevel;
        if (query.cuisine)
            where.cuisine = { contains: query.cuisine, mode: 'insensitive' };
        if (query.festival)
            where.festivals = { has: query.festival };
        if (query.vegetarianOnly === true)
            where.isVegetarian = true;
        if (query.maxMinutes)
            where.cookMinutes = { lte: parseInt(query.maxMinutes) };
        if (query.maxCostInr)
            where.costInr = { lte: parseInt(query.maxCostInr) };
        return this.prisma.recipe.findMany({ where, orderBy: { name: 'asc' } });
    }
    async findOne(id) {
        const recipe = await this.prisma.recipe.findUnique({ where: { id } });
        if (!recipe)
            throw new common_1.NotFoundException(`Recipe ${id} not found`);
        return recipe;
    }
    async findByCategory(category) {
        return this.prisma.recipe.findMany({
            where: { category: category, isVegetarian: true },
            orderBy: { name: 'asc' },
        });
    }
    async findByFestival(festival) {
        return this.prisma.recipe.findMany({
            where: { festivals: { has: festival }, isVegetarian: true },
            orderBy: { name: 'asc' },
        });
    }
    async update(id, dto) {
        await this.findOne(id);
        return this.prisma.recipe.update({ where: { id }, data: dto });
    }
    async remove(id) {
        await this.findOne(id);
        await this.prisma.recipe.delete({ where: { id } });
        return { message: 'Recipe deleted' };
    }
    async seed() {
        const recipes = [
            {
                name: 'Dal Tadka', cuisine: 'North Indian', category: 'DINNER',
                spiceLevel: 'MEDIUM', cookMinutes: 30, servings: 4,
                calories: 320, proteinG: 18, fibreG: 8, costInr: 80,
                description: 'Classic yellow lentil curry with aromatic tempering',
                ingredients: ['yellow dal', 'onion', 'tomato', 'ghee', 'cumin', 'garlic', 'turmeric'],
                tags: ['protein', 'comfort food', 'high fibre'], festivals: ['Diwali'],
            },
            {
                name: 'Masala Oats', cuisine: 'Pan Indian', category: 'BREAKFAST',
                spiceLevel: 'MILD', cookMinutes: 10, servings: 1,
                calories: 220, proteinG: 8, fibreG: 4, costInr: 40,
                description: 'Quick savoury oats with vegetables',
                ingredients: ['rolled oats', 'onion', 'tomato', 'green chilli', 'mustard seeds', 'curry leaves'],
                tags: ['quick', 'healthy', 'weight management'], festivals: [],
            },
            {
                name: 'Khichdi', cuisine: 'Pan Indian', category: 'DINNER',
                spiceLevel: 'MILD', cookMinutes: 20, servings: 2,
                calories: 280, proteinG: 10, fibreG: 5, costInr: 50,
                description: 'Comforting rice and lentil porridge',
                ingredients: ['rice', 'moong dal', 'ghee', 'cumin', 'turmeric', 'ginger'],
                tags: ['comfort food', 'easy', 'diabetes management'], festivals: ['Pongal'],
            },
            {
                name: 'Aloo Paratha', cuisine: 'North Indian', category: 'BREAKFAST',
                spiceLevel: 'MEDIUM', cookMinutes: 25, servings: 2,
                calories: 380, proteinG: 8, fibreG: 3, costInr: 60,
                description: 'Whole wheat flatbread stuffed with spiced potato',
                ingredients: ['whole wheat flour', 'potato', 'onion', 'green chilli', 'coriander', 'ghee'],
                tags: ['filling', 'traditional'], festivals: [],
            },
            {
                name: 'Curd Rice', cuisine: 'South Indian', category: 'LUNCH',
                spiceLevel: 'MILD', cookMinutes: 15, servings: 2,
                calories: 260, proteinG: 7, fibreG: 1, costInr: 45,
                description: 'Cooling yoghurt rice with curry leaves and mustard',
                ingredients: ['rice', 'curd', 'mustard seeds', 'curry leaves', 'ginger', 'green chilli'],
                tags: ['cooling', 'summer', 'quick'], festivals: [],
            },
            {
                name: 'Palak Paneer', cuisine: 'North Indian', category: 'DINNER',
                spiceLevel: 'MEDIUM', cookMinutes: 35, servings: 4,
                calories: 310, proteinG: 16, fibreG: 4, costInr: 120,
                description: 'Cottage cheese in creamy spinach gravy',
                ingredients: ['paneer', 'spinach', 'onion', 'tomato', 'cream', 'spices'],
                tags: ['protein', 'iron rich', 'restaurant style'], festivals: ['Diwali', 'Navratri'],
            },
            {
                name: 'Lemon Rice', cuisine: 'South Indian', category: 'LUNCH',
                spiceLevel: 'MILD', cookMinutes: 15, servings: 2,
                calories: 290, proteinG: 5, fibreG: 2, costInr: 40,
                description: 'Tangy rice with peanuts and curry leaves',
                ingredients: ['rice', 'lemon', 'peanuts', 'curry leaves', 'mustard seeds', 'turmeric'],
                tags: ['quick', 'tangy', 'budget cooking'], festivals: ['Pongal', 'Ugadi'],
            },
            {
                name: 'Chana Masala', cuisine: 'North Indian', category: 'LUNCH',
                spiceLevel: 'HOT', cookMinutes: 40, servings: 4,
                calories: 350, proteinG: 15, fibreG: 10, costInr: 70,
                description: 'Spicy chickpea curry with aromatic spices',
                ingredients: ['chickpeas', 'onion', 'tomato', 'ginger', 'garlic', 'chana masala'],
                tags: ['high protein', 'high fibre', 'vegan'], festivals: [],
            },
        ];
        let count = 0;
        for (const recipe of recipes) {
            await this.prisma.recipe.upsert({
                where: { id: recipe.name.toLowerCase().replace(/ /g, '-') },
                update: {},
                create: {
                    id: recipe.name.toLowerCase().replace(/ /g, '-'),
                    ...recipe,
                    isVegetarian: true,
                    ingredients: recipe.ingredients ?? [],
                    tags: recipe.tags ?? [],
                    festivals: recipe.festivals ?? [],
                },
            });
            count++;
        }
        return { message: `Seeded ${count} recipes`, count };
    }
};
exports.RecipeService = RecipeService;
exports.RecipeService = RecipeService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], RecipeService);
//# sourceMappingURL=recipe.service.js.map