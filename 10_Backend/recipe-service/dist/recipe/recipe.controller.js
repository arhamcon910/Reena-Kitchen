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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.RecipeController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const recipe_service_1 = require("./recipe.service");
const create_recipe_dto_1 = require("./dto/create-recipe.dto");
const update_recipe_dto_1 = require("./dto/update-recipe.dto");
const search_recipe_dto_1 = require("./dto/search-recipe.dto");
let RecipeController = class RecipeController {
    constructor(recipeService) {
        this.recipeService = recipeService;
    }
    create(dto) {
        return this.recipeService.create(dto);
    }
    seed() {
        return this.recipeService.seed();
    }
    findAll(query) {
        if (Object.keys(query).length > 0) {
            return this.recipeService.search(query);
        }
        return this.recipeService.findAll();
    }
    findByCategory(category) {
        return this.recipeService.findByCategory(category);
    }
    findByFestival(festival) {
        return this.recipeService.findByFestival(festival);
    }
    findOne(id) {
        return this.recipeService.findOne(id);
    }
    update(id, dto) {
        return this.recipeService.update(id, dto);
    }
    remove(id) {
        return this.recipeService.remove(id);
    }
};
exports.RecipeController = RecipeController;
__decorate([
    (0, common_1.Post)(),
    (0, swagger_1.ApiOperation)({ summary: 'Create a recipe' }),
    (0, swagger_1.ApiCreatedResponse)({ description: 'Recipe created' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_recipe_dto_1.CreateRecipeDto]),
    __metadata("design:returntype", void 0)
], RecipeController.prototype, "create", null);
__decorate([
    (0, common_1.Post)('seed'),
    (0, swagger_1.ApiOperation)({ summary: 'Seed default Indian vegetarian recipes' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], RecipeController.prototype, "seed", null);
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'Search and filter recipes' }),
    (0, swagger_1.ApiQuery)({ name: 'q', required: false, description: 'Search term' }),
    (0, swagger_1.ApiQuery)({ name: 'category', required: false, enum: ['BREAKFAST', 'LUNCH', 'DINNER', 'SNACK', 'DESSERT', 'DRINK'] }),
    (0, swagger_1.ApiQuery)({ name: 'spiceLevel', required: false, enum: ['MILD', 'MEDIUM', 'HOT'] }),
    (0, swagger_1.ApiQuery)({ name: 'cuisine', required: false }),
    (0, swagger_1.ApiQuery)({ name: 'festival', required: false }),
    (0, swagger_1.ApiQuery)({ name: 'vegetarianOnly', required: false }),
    (0, swagger_1.ApiQuery)({ name: 'maxMinutes', required: false }),
    (0, swagger_1.ApiQuery)({ name: 'maxCostInr', required: false }),
    __param(0, (0, common_1.Query)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [search_recipe_dto_1.SearchRecipeDto]),
    __metadata("design:returntype", void 0)
], RecipeController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)('category/:category'),
    (0, swagger_1.ApiOperation)({ summary: 'Get recipes by meal category' }),
    __param(0, (0, common_1.Param)('category')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], RecipeController.prototype, "findByCategory", null);
__decorate([
    (0, common_1.Get)('festival/:festival'),
    (0, swagger_1.ApiOperation)({ summary: 'Get recipes by festival' }),
    __param(0, (0, common_1.Param)('festival')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], RecipeController.prototype, "findByFestival", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get recipe by ID' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], RecipeController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Update recipe' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_recipe_dto_1.UpdateRecipeDto]),
    __metadata("design:returntype", void 0)
], RecipeController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete recipe' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], RecipeController.prototype, "remove", null);
exports.RecipeController = RecipeController = __decorate([
    (0, swagger_1.ApiTags)('Recipes'),
    (0, common_1.Controller)('recipes'),
    __metadata("design:paramtypes", [recipe_service_1.RecipeService])
], RecipeController);
//# sourceMappingURL=recipe.controller.js.map