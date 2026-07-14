import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateRecipeDto } from './dto/create-recipe.dto';
import { UpdateRecipeDto } from './dto/update-recipe.dto';
import { SearchRecipeDto } from './dto/search-recipe.dto';
import { Prisma } from '@prisma/client';

@Injectable()
export class RecipeService {
  constructor(private prisma: PrismaService) {}

  async create(dto: CreateRecipeDto) {
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

  async search(query: SearchRecipeDto) {
    const where: Prisma.RecipeWhereInput = {};

    if (query.q) {
      where.OR = [
        { name: { contains: query.q, mode: 'insensitive' } },
        { description: { contains: query.q, mode: 'insensitive' } },
        { ingredients: { has: query.q } },
        { tags: { has: query.q } },
      ];
    }
    if (query.category)     where.category   = query.category;
    if (query.spiceLevel)   where.spiceLevel  = query.spiceLevel;
    if (query.cuisine)      where.cuisine     = { contains: query.cuisine, mode: 'insensitive' };
    if (query.festival)     where.festivals   = { has: query.festival };
    if (query.vegetarianOnly === true) where.isVegetarian = true;
    if (query.maxMinutes)   where.cookMinutes = { lte: parseInt(query.maxMinutes) };
    if (query.maxCostInr)   where.costInr     = { lte: parseInt(query.maxCostInr) };

    return this.prisma.recipe.findMany({ where, orderBy: { name: 'asc' } });
  }

  async findOne(id: string) {
    const recipe = await this.prisma.recipe.findUnique({ where: { id } });
    if (!recipe) throw new NotFoundException(`Recipe ${id} not found`);
    return recipe;
  }

  async findByCategory(category: string) {
    return this.prisma.recipe.findMany({
      where: { category: category as any, isVegetarian: true },
      orderBy: { name: 'asc' },
    });
  }

  async findByFestival(festival: string) {
    return this.prisma.recipe.findMany({
      where: { festivals: { has: festival }, isVegetarian: true },
      orderBy: { name: 'asc' },
    });
  }

  async update(id: string, dto: UpdateRecipeDto) {
    await this.findOne(id);
    return this.prisma.recipe.update({ where: { id }, data: dto });
  }

  async remove(id: string) {
    await this.findOne(id);
    await this.prisma.recipe.delete({ where: { id } });
    return { message: 'Recipe deleted' };
  }

  async seed() {
    const recipes: CreateRecipeDto[] = [
      {
        name: 'Dal Tadka', cuisine: 'North Indian', category: 'DINNER' as any,
        spiceLevel: 'MEDIUM' as any, cookMinutes: 30, servings: 4,
        calories: 320, proteinG: 18, fibreG: 8, costInr: 80,
        description: 'Classic yellow lentil curry with aromatic tempering',
        ingredients: ['yellow dal', 'onion', 'tomato', 'ghee', 'cumin', 'garlic', 'turmeric'],
        tags: ['protein', 'comfort food', 'high fibre'], festivals: ['Diwali'],
      },
      {
        name: 'Masala Oats', cuisine: 'Pan Indian', category: 'BREAKFAST' as any,
        spiceLevel: 'MILD' as any, cookMinutes: 10, servings: 1,
        calories: 220, proteinG: 8, fibreG: 4, costInr: 40,
        description: 'Quick savoury oats with vegetables',
        ingredients: ['rolled oats', 'onion', 'tomato', 'green chilli', 'mustard seeds', 'curry leaves'],
        tags: ['quick', 'healthy', 'weight management'], festivals: [],
      },
      {
        name: 'Khichdi', cuisine: 'Pan Indian', category: 'DINNER' as any,
        spiceLevel: 'MILD' as any, cookMinutes: 20, servings: 2,
        calories: 280, proteinG: 10, fibreG: 5, costInr: 50,
        description: 'Comforting rice and lentil porridge',
        ingredients: ['rice', 'moong dal', 'ghee', 'cumin', 'turmeric', 'ginger'],
        tags: ['comfort food', 'easy', 'diabetes management'], festivals: ['Pongal'],
      },
      {
        name: 'Aloo Paratha', cuisine: 'North Indian', category: 'BREAKFAST' as any,
        spiceLevel: 'MEDIUM' as any, cookMinutes: 25, servings: 2,
        calories: 380, proteinG: 8, fibreG: 3, costInr: 60,
        description: 'Whole wheat flatbread stuffed with spiced potato',
        ingredients: ['whole wheat flour', 'potato', 'onion', 'green chilli', 'coriander', 'ghee'],
        tags: ['filling', 'traditional'], festivals: [],
      },
      {
        name: 'Curd Rice', cuisine: 'South Indian', category: 'LUNCH' as any,
        spiceLevel: 'MILD' as any, cookMinutes: 15, servings: 2,
        calories: 260, proteinG: 7, fibreG: 1, costInr: 45,
        description: 'Cooling yoghurt rice with curry leaves and mustard',
        ingredients: ['rice', 'curd', 'mustard seeds', 'curry leaves', 'ginger', 'green chilli'],
        tags: ['cooling', 'summer', 'quick'], festivals: [],
      },
      {
        name: 'Palak Paneer', cuisine: 'North Indian', category: 'DINNER' as any,
        spiceLevel: 'MEDIUM' as any, cookMinutes: 35, servings: 4,
        calories: 310, proteinG: 16, fibreG: 4, costInr: 120,
        description: 'Cottage cheese in creamy spinach gravy',
        ingredients: ['paneer', 'spinach', 'onion', 'tomato', 'cream', 'spices'],
        tags: ['protein', 'iron rich', 'restaurant style'], festivals: ['Diwali', 'Navratri'],
      },
      {
        name: 'Lemon Rice', cuisine: 'South Indian', category: 'LUNCH' as any,
        spiceLevel: 'MILD' as any, cookMinutes: 15, servings: 2,
        calories: 290, proteinG: 5, fibreG: 2, costInr: 40,
        description: 'Tangy rice with peanuts and curry leaves',
        ingredients: ['rice', 'lemon', 'peanuts', 'curry leaves', 'mustard seeds', 'turmeric'],
        tags: ['quick', 'tangy', 'budget cooking'], festivals: ['Pongal', 'Ugadi'],
      },
      {
        name: 'Chana Masala', cuisine: 'North Indian', category: 'LUNCH' as any,
        spiceLevel: 'HOT' as any, cookMinutes: 40, servings: 4,
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
}
