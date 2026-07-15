import { Controller, Get } from '@nestjs/common';
import { ApiOperation, ApiTags, ApiOkResponse } from '@nestjs/swagger';

@ApiTags('Health')
@Controller('health')
export class HealthController {
  @Get()
  @ApiOperation({ summary: 'Service health check' })
  @ApiOkResponse({
    description: 'Service is healthy',
    schema: {
      example: {
        status: 'ok',
        service: 'REENA API',
        version: '1.0.0',
      },
    },
  })
  health(): Record<string, string> {
    return {
      status: 'ok',
      service: 'REENA API',
      version: '1.0.0',
    };
  }
}
