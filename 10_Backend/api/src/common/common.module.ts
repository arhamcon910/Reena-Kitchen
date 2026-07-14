import { Global, Module } from '@nestjs/common';

/**
 * CommonModule — shared utilities, guards, interceptors, decorators.
 * Marked @Global so it is available without importing everywhere.
 * Business logic added Sprint S002+.
 */
@Global()
@Module({
  providers: [],
  exports: [],
})
export class CommonModule {}
