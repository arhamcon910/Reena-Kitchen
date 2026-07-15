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
exports.CreateRecipeDto = exports.SpiceLevel = exports.MealCategory = void 0;
const swagger_1 = require("@nestjs/swagger");
const class_validator_1 = require("class-validator");
var MealCategory;
(function (MealCategory) {
    MealCategory["BREAKFAST"] = "BREAKFAST";
    MealCategory["LUNCH"] = "LUNCH";
    MealCategory["DINNER"] = "DINNER";
    MealCategory["SNACK"] = "SNACK";
    MealCategory["DESSERT"] = "DESSERT";
    MealCategory["DRINK"] = "DRINK";
})(MealCategory || (exports.MealCategory = MealCategory = {}));
var SpiceLevel;
(function (SpiceLevel) {
    SpiceLevel["MILD"] = "MILD";
    SpiceLevel["MEDIUM"] = "MEDIUM";
    SpiceLevel["HOT"] = "HOT";
})(SpiceLevel || (exports.SpiceLevel = SpiceLevel = {}));
class CreateRecipeDto {
}
exports.CreateRecipeDto = CreateRecipeDto;
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'Dal Tadka' }),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], CreateRecipeDto.prototype, "name", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'Classic North Indian yellow lentil curry', required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], CreateRecipeDto.prototype, "description", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 'North Indian', required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsString)(),
    __metadata("design:type", String)
], CreateRecipeDto.prototype, "cuisine", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ enum: MealCategory }),
    (0, class_validator_1.IsEnum)(MealCategory),
    __metadata("design:type", String)
], CreateRecipeDto.prototype, "category", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ enum: SpiceLevel, default: 'MEDIUM', required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsEnum)(SpiceLevel),
    __metadata("design:type", String)
], CreateRecipeDto.prototype, "spiceLevel", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: true, default: true, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsBoolean)(),
    __metadata("design:type", Boolean)
], CreateRecipeDto.prototype, "isVegetarian", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 10, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsInt)(),
    (0, class_validator_1.Min)(0),
    __metadata("design:type", Number)
], CreateRecipeDto.prototype, "prepMinutes", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 30 }),
    (0, class_validator_1.IsInt)(),
    (0, class_validator_1.Min)(1),
    __metadata("design:type", Number)
], CreateRecipeDto.prototype, "cookMinutes", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 4, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsInt)(),
    (0, class_validator_1.Min)(1),
    __metadata("design:type", Number)
], CreateRecipeDto.prototype, "servings", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 320, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsInt)(),
    __metadata("design:type", Number)
], CreateRecipeDto.prototype, "calories", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 18.5, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsNumber)(),
    __metadata("design:type", Number)
], CreateRecipeDto.prototype, "proteinG", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 6.2, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsNumber)(),
    __metadata("design:type", Number)
], CreateRecipeDto.prototype, "fibreG", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: 80, required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsInt)(),
    __metadata("design:type", Number)
], CreateRecipeDto.prototype, "costInr", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: ['yellow dal', 'onion', 'tomato', 'ghee'], required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsArray)(),
    (0, class_validator_1.IsString)({ each: true }),
    __metadata("design:type", Array)
], CreateRecipeDto.prototype, "ingredients", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: ['protein', 'comfort food'], required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsArray)(),
    (0, class_validator_1.IsString)({ each: true }),
    __metadata("design:type", Array)
], CreateRecipeDto.prototype, "tags", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ example: ['Diwali', 'Pongal'], required: false }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsArray)(),
    (0, class_validator_1.IsString)({ each: true }),
    __metadata("design:type", Array)
], CreateRecipeDto.prototype, "festivals", void 0);
//# sourceMappingURL=create-recipe.dto.js.map