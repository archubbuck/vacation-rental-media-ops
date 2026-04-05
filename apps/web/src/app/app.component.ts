import { Component, signal } from '@angular/core';

@Component({
  selector: 'app-root',
  standalone: true,
  templateUrl: './app.component.html'
})
export class AppComponent {
  readonly kpis = signal([
    { label: 'Active Properties', value: '128', trend: '+12 this week' },
    { label: 'Auto Publish Rate', value: '82%', trend: '+6 pts' },
    { label: 'Open Exceptions', value: '17', trend: '-4 today' },
    { label: 'Failed Syncs', value: '3', trend: 'Needs attention' }
  ]);

  readonly listings = signal([
    { name: 'Ocean View Villa', channel: 'Airbnb', readiness: '94', status: 'Healthy' },
    { name: 'Blue Ridge Cabin', channel: 'Vrbo', readiness: '76', status: 'Needs review' },
    { name: 'Downtown Loft', channel: 'Airbnb', readiness: '88', status: 'Healthy' }
  ]);
}
