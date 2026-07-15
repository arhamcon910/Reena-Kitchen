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
exports.PantryController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const pantry_service_1 = require("./pantry.service");
const create_pantry_item_dto_1 = require("./dto/create-pantry-item.dto");
const update_pantry_item_dto_1 = require("./dto/update-pantry-item.dto");
let PantryController = class PantryController {
    constructor(pantryService) {
        this.pantryService = pantryService;
    }
    create(householdId, dto) {
        return this.pantryService.create(householdId, dto);
    }
    bulkCreate(householdId, dto) {
        return this.pantryService.bulkCreate(householdId, dto);
    }
    findAll(householdId) {
        return this.pantryService.findAll(householdId);
    }
    findInStock(householdId) {
        return this.pantryService.findInStock(householdId);
    }
    findOne(householdId, id) {
        return this.pantryService.findOne(householdId, id);
    }
    update(householdId, id, dto) {
        return this.pantryService.update(householdId, id, dto);
    }
    remove(householdId, id) {
        return this.pantryService.remove(householdId, id);
    }
};
exports.PantryController = PantryController;
__decorate([
    (0, common_1.Post)(),
    (0, swagger_1.ApiOperation)({ summary: 'Add item to pantry' }),
    (0, swagger_1.ApiCreatedResponse)({ description: 'Item added' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, create_pantry_item_dto_1.CreatePantryItemDto]),
    __metadata("design:returntype", void 0)
], PantryController.prototype, "create", null);
__decorate([
    (0, common_1.Post)('bulk'),
    (0, swagger_1.ApiOperation)({ summary: 'Add multiple items to pantry' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Array]),
    __metadata("design:returntype", void 0)
], PantryController.prototype, "bulkCreate", null);
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'List all pantry items' }),
    (0, swagger_1.ApiOkResponse)({ description: 'All pantry items' }),
    __param(0, (0, common_1.Param)('householdId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], PantryController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)('in-stock'),
    (0, swagger_1.ApiOperation)({ summary: 'List in-stock items only' }),
    __param(0, (0, common_1.Param)('householdId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], PantryController.prototype, "findInStock", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get pantry item by ID' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], PantryController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Update pantry item' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('id')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, update_pantry_item_dto_1.UpdatePantryItemDto]),
    __metadata("design:returntype", void 0)
], PantryController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Remove pantry item' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], PantryController.prototype, "remove", null);
exports.PantryController = PantryController = __decorate([
    (0, swagger_1.ApiTags)('Pantry'),
    (0, common_1.Controller)('pantry/:householdId/items'),
    __metadata("design:paramtypes", [pantry_service_1.PantryService])
], PantryController);
//# sourceMappingURL=pantry.controller.js.map