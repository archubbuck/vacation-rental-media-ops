import { Injectable } from '@nestjs/common';

@Injectable()
export class PublishingService {
  getQueue() {
    return [
      {
        id: 'pub_1',
        channel: 'airbnb',
        propertyName: 'Ocean View Villa',
        status: 'queued'
      }
    ];
  }
}
