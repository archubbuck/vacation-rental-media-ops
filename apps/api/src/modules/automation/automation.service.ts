import { Injectable } from '@nestjs/common';

@Injectable()
export class AutomationService {
  getDefaultPolicy() {
    return {
      autoOptimize: true,
      autoPublish: true,
      roomConfidenceThreshold: 0.9,
      maxEditDelta: 0.18,
      reorderStrategy: 'quality_then_coverage'
    };
  }
}
