import { Controller, Get, Param } from '@nestjs/common';
import { PropertiesService } from './properties.service';

@Controller('properties')
export class PropertiesController {
  constructor(private readonly propertiesService: PropertiesService) {}

  @Get()
  listProperties() {
    return this.propertiesService.list();
  }

  @Get(':id')
  getProperty(@Param('id') id: string) {
    return this.propertiesService.getById(id);
  }
}
