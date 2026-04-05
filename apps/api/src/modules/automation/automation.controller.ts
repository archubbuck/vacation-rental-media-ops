import { Controller, Get } from '@nestjs/common';
import { AutomationService } from './automation.service';

@Controller('automation')
export class AutomationController {
  constructor(private readonly automationService: AutomationService) {}

  @Get('policies/default')
  getDefaultPolicy() {
    return this.automationService.getDefaultPolicy();
  }
}
