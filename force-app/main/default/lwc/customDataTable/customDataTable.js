import LightningDataTable from 'lightning/datatable';
import CustomSemaforo from './customSemaforo.html';

export default class CustomDataTable extends LightningDataTable {

    static customTypes = {
        customSemaforoDT:{
            template: CustomSemaforo,
            typeAttributes: ['cor'],
        }
    }
}