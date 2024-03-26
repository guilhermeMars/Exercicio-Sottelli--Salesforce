import { LightningElement, api } from 'lwc';
import getAv from '@salesforce/apex/CadastroAvaliacaoController.getAv';
// import vermelho from '@salesforce/resourceUrl/semaforo_vermelho';
// import laranja from '@salesforce/resourceUrl/semaforo_laranja';
// import amarelo from '@salesforce/resourceUrl/semaforo_amarelo';
// import verde from '@salesforce/resourceUrl/semaforo_verde';
// import azul from '@salesforce/resourceUrl/semaforo_azul';

export default class AvaliacaoDatatable extends LightningElement {
    dadoTabela = [];
    colunaTabela = [
        { label: 'Avaliador', fieldName: 'userName' },
        { label: 'Título', fieldName: 'name' },
        { label: 'Descrição', fieldName: 'descricao' },
        { label: 'Nota', fieldName: 'nota', type: 'customSemaforoDT', typeAttributes: {cor: {fieldName: 'cor'}}},
    ];
    @api registroid;

    mostraAv(){
        getAv({accountId : this.registroid})
        .then(res =>{
            this.dadoTabela = res;
        })
        .catch(err =>{
            console.log(err);
        });
    }

    connectedCallback(){
        this.mostraAv();
    }

    @api
    refreshData(){
        this.connectedCallback();
    }

}