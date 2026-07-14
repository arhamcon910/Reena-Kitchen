import { Controller, Get, Post, Patch, Delete, Param, Body, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiCreatedResponse, ApiOkResponse, ApiQuery } from '@nestjs/swagger';
import { RecipeService } from './recipe.service';
import { CreateRecipeDto } from './dto/create-recipe.dto';
import { UpdateRecipeDto } from './dto/update-recipe.dto';
import { SearchRecipeDto } from './dto/search-recipe.dto';

@ApiTags('Recipes')
@Controller('recipes')
export class RecipeController {
  constructor(private recipeService: RecipeService) {}

  @Post()
  @ApiOperation({ summary: 'Create a recipe' })
  @ApiCreatedResponse({ description: 'Recipe created' })
  create(@Body() dto: CreateRecipeDto) {
    return this.recipeService.create(dto);
  }

  @Post('seed')
  @ApiOperation({ summary: 'Seed default Indian vegetarian recipes' })
  seed() {
    return this.recipeService.seed();
  }

  @Get()
  @ApiOperation({ summary: 'Search and filter recipes' })
  @ApiQuery({ name: 'q', required: false, description: 'Search term' })
  @ApiQuery({ name: 'category', required: false, enum: ['BREAKFAST','LUNCH','DINNER','SNACK','DESSERT','DRINK'] })
  @ApiQuery({ name: 'spiceLevel', required: false, enum: ['MILD','MEDIUM','HOT'] })
  @ApiQuery({ name: 'cuisine', required: false })
  @ApiQuery({ name: 'festival', required: false })
  @ApiQuery({ name: 'vegetarianOnly', required: false })
  @ApiQuery({ name: 'maxMinutes', required: false })
  @ApiQuery({ name: 'maxCostInr', required: false })
  findAll(@Query() query: SearchRecipeDto) {
    if (Object.keys(query).length > 0) {
      return this.recipeService.search(query);
    }
    return this.recipeService.findAll();
  }

  @Get('category/:category')
  @ApiOperation({ summary: 'Get recipes by meal category' })
  findByCategory(@Param('category') category: string) {
    return this.recipeService.findByCategory(category);
  }

  @Get('festival/:festival')
  @ApiOperation({ summary: 'Get recipes by festival' })
  findByFestival(@Param('festival') festival: string) {
    return this.recipeService.findByFestival(festival);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get recipe by ID' })
  findOne(@Param('id') id: string) {
    return this.recipeService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update recipe' })
  update(@Param('id') id: string, @Body() dto: UpdateRecipeDto) {
    return this.recipeService.update(id, dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete recipe' })
  remove(@Param('id') id: string) {
    return this.recipeService.remove(id);
  }
}
