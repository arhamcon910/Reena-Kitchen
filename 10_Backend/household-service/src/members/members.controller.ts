import { Controller, Get, Post, Patch, Delete, Param, Body } from '@nestjs/common';
import { ApiTags, ApiOperation } from '@nestjs/swagger';
import { MembersService } from './members.service';
import { CreateMemberDto } from './dto/create-member.dto';
import { UpdateMemberDto } from './dto/update-member.dto';

@ApiTags('Members')
@Controller('households/:householdId/members')
export class MembersController {
  constructor(private membersService: MembersService) {}

  @Post()
  @ApiOperation({ summary: 'Add member to household' })
  create(@Param('householdId') householdId: string, @Body() dto: CreateMemberDto) {
    return this.membersService.create(householdId, dto);
  }

  @Get()
  @ApiOperation({ summary: 'List household members' })
  findAll(@Param('householdId') householdId: string) {
    return this.membersService.findAll(householdId);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get member by ID' })
  findOne(@Param('householdId') householdId: string, @Param('id') id: string) {
    return this.membersService.findOne(householdId, id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update member' })
  update(
    @Param('householdId') householdId: string,
    @Param('id') id: string,
    @Body() dto: UpdateMemberDto,
  ) {
    return this.membersService.update(householdId, id, dto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Remove member' })
  remove(@Param('householdId') householdId: string, @Param('id') id: string) {
    return this.membersService.remove(householdId, id);
  }
}
