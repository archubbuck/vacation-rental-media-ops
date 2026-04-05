import { Module } from '@nestjs/common';
import { HealthModule } from './modules/health/health.module';
import { PropertiesModule } from './modules/properties/properties.module';
import { AutomationModule } from './modules/automation/automation.module';
import { PublishingModule } from './modules/publishing/publishing.module';

@Module({
  imports: [
    HealthModule,
    PropertiesModule,
    AutomationModule,
    PublishingModule
  ]
})
export class AppModule {}
