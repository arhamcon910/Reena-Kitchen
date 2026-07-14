import { NestFactory } from '@nestjs/core';
import { ValidationPipe, Logger } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { ConfigService } from '@nestjs/config';
import { AppModule } from './app.module';

async function bootstrap() {
  const logger = new Logger('Bootstrap');
  const app = await NestFactory.create(AppModule);
  const configService = app.get(ConfigService);
  const port = configService.get<number>('PORT', 3004);

  app.enableCors({ origin: '*' });
  app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true }));

  const config = new DocumentBuilder()
    .setTitle('REENA Recipe Service')
    .setDescription('Vegetarian Indian recipe catalogue and search')
    .setVersion('1.0.0')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api/docs', app, document);

  await app.listen(port);
  logger.log(`Recipe Service running on http://localhost:${port}`);
  logger.log(`Swagger: http://localhost:${port}/api/docs`);

  process.on('SIGTERM', async () => { await app.close(); process.exit(0); });
  process.on('SIGINT',  async () => { await app.close(); process.exit(0); });
}
bootstrap();
