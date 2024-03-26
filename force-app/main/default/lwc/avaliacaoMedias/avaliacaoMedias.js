import { LightningElement, api } from 'lwc';
import getMedias from '@salesforce/apex/CadastroAvaliacaoController.getMedias';

export default class AvaliacaoMedias extends LightningElement {
    data = [];
    coloumn = [
        { label: 'Data', fieldName: 'name' },
        { label: 'Média', fieldName: 'nota' }
    ];
    @api registroid;

    connectedCallback(){
        getMedias({ accountId : this.registroid })
        .then(res =>{
            this.data = res;
            console.log("Olha a res: " + res);
            console.log(this.registroid);
        })
        .catch(err =>{
            console.log(err);
        });
    }
}