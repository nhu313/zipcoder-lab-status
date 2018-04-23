import { Injectable } from '@angular/core';
import { Storage } from '@ionic/storage';

@Injectable()
export class Data {

  constructor(public storage: Storage) {

  }

  getData() {
    return this.storage.get('todos');
  }

  save(data){
    this.storage.set('todos', data);
  }
}
