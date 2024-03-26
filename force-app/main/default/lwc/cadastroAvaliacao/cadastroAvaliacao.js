import { LightningElement, api } from 'lwc';
import setAv from '@salesforce/apex/CadastroAvaliacaoController.setAv';
import getUserNome from '@salesforce/apex/CadastroAvaliacaoController.getCompleteUserName';
import getAccNome from '@salesforce/apex/CadastroAvaliacaoController.getAccName';
import getMenorNota from '@salesforce/apex/CadastroAvaliacaoController.getMenorNota';
import getMaiorNota from '@salesforce/apex/CadastroAvaliacaoController.getMaiorNota';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CadastroAvaliacao extends LightningElement {
    // Variáveis
    nomeConta;
    nomeUser;
    tituloAv;
    notaAv;
    descricaoAv;
    idAvaliacao;
    notaMaxima;
    notaMínima;
    @api recordId;
    get opcoesNota(){
        return[
            { label: '1', value: '1' },
            { label: '2', value: '2' },
            { label: '3', value: '3' },
            { label: '4', value: '4' },
            { label: '5', value: '5' }
        ]
    }

    escolheCor(nota){
        switch (nota) {
            case 1:
                return 'dot vermelho';
            case 2:
                return 'dot laranja';
            case 3:
                return 'dot amarelo';
            case 4:
                return 'dot verde';
            case 5:
                return 'dot azul';
            default:
                return 'dot branco';
        }
    }

    connectedCallback(){
        getUserNome({})
        .then(res =>{
            this.nomeUser = res;
        })
        .catch(err =>{
            console.log(err);
        });

        getAccNome({accountId : this.recordId})
        .then(res =>{
            this.nomeConta = res;
        })
        .catch(err =>{
            console.log(err);
        });

        getMenorNota({accountId : this.recordId})
        .then(res =>{
            this.notaMínima = this.escolheCor(res);
        })
        .catch(err =>{
            console.log(err);
        });

        getMaiorNota({accountId : this.recordId})
        .then(res =>{
            this.notaMaxima = this.escolheCor(res);
        })
        .catch(err =>{
            console.log(err);
        });
    }
    // cria conexão entre o componente e o backend
    // @wire(getAv)
    // dadoTabela

    // Handlers
    handleTitulo(event){
        this.tituloAv = event.target.value;
    }
    handleNota(event){
        this.notaAv = event.detail.value;
    }
    handleDescricao(event){
        this.descricaoAv = event.target.value;
    }
    
    limpaCampos(){
        this.tituloAv = undefined;
        this.notaAv = undefined;
        this.descricaoAv = undefined;
    }
    
    showErrorToast(campo) {
        const evt = new ShowToastEvent({
            title: 'Toast Error',
            message: 'Preencha o campo '+ campo,
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    validaCampos(){
        if(this.tituloAv == null || this.tituloAv.trim() == ''){
            this.showErrorToast('Titulo');
            return false;
        } else if(this.notaAv == null || this.notaAv == 'Escolha'){
            this.showErrorToast('Nota');
            return false;
        } else if(this.descricaoAv == null || this.descricaoAv.trim() == ''){
            this.showErrorToast('Descrição');
            return false;
        }
        return true;
    }

    criaAv(){
        if(this.validaCampos()){
            let avaliacao = { 'sObjectType': 'Avaliacao__c' };
            avaliacao.Name = this.tituloAv;
            avaliacao.Nota__c = Number(this.notaAv);
            avaliacao.Descricao__c = this.descricaoAv;
            avaliacao.Account__c = this.recordId;
            setAv({ av: avaliacao })
            .then(res =>{
                this.idAvaliacao = res;       
                this.template.querySelector("c-avaliacao-datatable").refreshData();
                this.limpaCampos();
            })
            .catch(err =>{
                console.log(err);
            })
        }
        // callback hell - pesquisar
    }

    handleClick(){
        this.criaAv();
    }


}