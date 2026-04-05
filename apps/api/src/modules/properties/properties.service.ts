import { Injectable } from '@nestjs/common';

@Injectable()
export class PropertiesService {
  list() {
    return [
      {
        id: 'prop_1',
        name: 'Ocean View Villa',
        readinessScore: 94,
        channels: ['airbnb', 'vrbo']
      }
    ];
  }

  getById(id: string) {
    return {
      id,
      name: 'Ocean View Villa',
      readinessScore: 94,
      rooms: [
        { type: 'bedroom', label: 'Primary Bedroom', required: true },
        { type: 'kitchen', label: 'Kitchen', required: true },
        { type: 'living_room', label: 'Living Room', required: true }
      ]
    };
  }
}
