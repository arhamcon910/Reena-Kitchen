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
exports.HouseholdController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const household_service_1 = require("./household.service");
const create_household_dto_1 = require("./dto/create-household.dto");
const update_household_dto_1 = require("./dto/update-household.dto");
let HouseholdController = class HouseholdController {
    constructor(householdService) {
        this.householdService = householdService;
    }
    create(dto) {
        return this.householdService.create(dto);
    }
    findAll() {
        return this.householdService.findAll();
    }
    findOne(id) {
        return this.householdService.findOne(id);
    }
    update(id, dto) {
        return this.householdService.update(id, dto);
    }
    remove(id) {
        return this.householdService.remove(id);
    }
};
exports.HouseholdController = HouseholdController;
__decorate([
    (0, common_1.Post)(),
    (0, swagger_1.ApiOperation)({ summary: 'Create a household' }),
    (0, swagger_1.ApiCreatedResponse)({ description: 'Household created' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_household_dto_1.CreateHouseholdDto]),
    __metadata("design:returntype", void 0)
], HouseholdController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'List all households' }),
    (0, swagger_1.ApiOkResponse)({ description: 'List of households' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], HouseholdController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get household by ID' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], HouseholdController.prototype, "findOne", null);
__decorate([
    (0, common_1.Patch)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Update household' }),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_household_dto_1.UpdateHouseholdDto]),
    __metadata("design:returntype", void 0)
], HouseholdController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete household' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], HouseholdController.prototype, "remove", null);
exports.HouseholdController = HouseholdController = __decorate([
    (0, swagger_1.ApiTags)('Households'),
    (0, common_1.Controller)('households'),
    __metadata("design:paramtypes", [household_service_1.HouseholdService])
], HouseholdController);
//# sourceMappingURL=household.controller.js.map