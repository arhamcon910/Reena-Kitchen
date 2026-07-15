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
exports.ShoppingController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const shopping_service_1 = require("./shopping.service");
const create_list_dto_1 = require("./dto/create-list.dto");
const create_item_dto_1 = require("./dto/create-item.dto");
const update_item_dto_1 = require("./dto/update-item.dto");
const generate_list_dto_1 = require("./dto/generate-list.dto");
let ShoppingController = class ShoppingController {
    constructor(shoppingService) {
        this.shoppingService = shoppingService;
    }
    createList(householdId, dto) {
        return this.shoppingService.createList(householdId, dto);
    }
    generateList(householdId, dto) {
        return this.shoppingService.generateList(householdId, dto);
    }
    getLists(householdId) {
        return this.shoppingService.getLists(householdId);
    }
    getList(householdId, listId) {
        return this.shoppingService.getList(householdId, listId);
    }
    completeList(householdId, listId) {
        return this.shoppingService.completeList(householdId, listId);
    }
    deleteList(householdId, listId) {
        return this.shoppingService.deleteList(householdId, listId);
    }
    addItem(householdId, listId, dto) {
        return this.shoppingService.addItem(householdId, listId, dto);
    }
    updateItem(householdId, listId, itemId, dto) {
        return this.shoppingService.updateItem(householdId, listId, itemId, dto);
    }
    markAllPurchased(householdId, listId) {
        return this.shoppingService.markAllPurchased(householdId, listId);
    }
    removeItem(householdId, listId, itemId) {
        return this.shoppingService.removeItem(householdId, listId, itemId);
    }
};
exports.ShoppingController = ShoppingController;
__decorate([
    (0, common_1.Post)('lists'),
    (0, swagger_1.ApiOperation)({ summary: 'Create a shopping list' }),
    (0, swagger_1.ApiCreatedResponse)({ description: 'List created' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, create_list_dto_1.CreateListDto]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "createList", null);
__decorate([
    (0, common_1.Post)('lists/generate'),
    (0, swagger_1.ApiOperation)({ summary: 'Generate shopping list from ingredients (excluding pantry)' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, generate_list_dto_1.GenerateListDto]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "generateList", null);
__decorate([
    (0, common_1.Get)('lists'),
    (0, swagger_1.ApiOperation)({ summary: 'Get all shopping lists' }),
    (0, swagger_1.ApiOkResponse)({ description: 'All lists with items' }),
    __param(0, (0, common_1.Param)('householdId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "getLists", null);
__decorate([
    (0, common_1.Get)('lists/:listId'),
    (0, swagger_1.ApiOperation)({ summary: 'Get a shopping list with items' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('listId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "getList", null);
__decorate([
    (0, common_1.Patch)('lists/:listId/complete'),
    (0, swagger_1.ApiOperation)({ summary: 'Mark list as completed' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('listId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "completeList", null);
__decorate([
    (0, common_1.Delete)('lists/:listId'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete a shopping list' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('listId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "deleteList", null);
__decorate([
    (0, common_1.Post)('lists/:listId/items'),
    (0, swagger_1.ApiOperation)({ summary: 'Add item to shopping list' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('listId')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, create_item_dto_1.CreateItemDto]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "addItem", null);
__decorate([
    (0, common_1.Patch)('lists/:listId/items/:itemId'),
    (0, swagger_1.ApiOperation)({ summary: 'Update item (mark purchased, change quantity)' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('listId')),
    __param(2, (0, common_1.Param)('itemId')),
    __param(3, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, String, update_item_dto_1.UpdateItemDto]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "updateItem", null);
__decorate([
    (0, common_1.Patch)('lists/:listId/items/mark-all-purchased'),
    (0, swagger_1.ApiOperation)({ summary: 'Mark all items as purchased' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('listId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "markAllPurchased", null);
__decorate([
    (0, common_1.Delete)('lists/:listId/items/:itemId'),
    (0, swagger_1.ApiOperation)({ summary: 'Remove item from list' }),
    __param(0, (0, common_1.Param)('householdId')),
    __param(1, (0, common_1.Param)('listId')),
    __param(2, (0, common_1.Param)('itemId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, String]),
    __metadata("design:returntype", void 0)
], ShoppingController.prototype, "removeItem", null);
exports.ShoppingController = ShoppingController = __decorate([
    (0, swagger_1.ApiTags)('Shopping'),
    (0, common_1.Controller)('shopping/:householdId'),
    __metadata("design:paramtypes", [shopping_service_1.ShoppingService])
], ShoppingController);
//# sourceMappingURL=shopping.controller.js.map