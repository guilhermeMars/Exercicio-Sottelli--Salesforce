public with sharing class AvaliacaoVO {

    public string selecionaCor(Integer nota){
        switch on nota {
            when 1{
                return 'dot vermelho';
            }
            when 2{
                return 'dot laranja';
            }
            when 3{
                return 'dot amarelo';
            }
            when 4{
                return 'dot verde';
            }
            when 5{
                return 'dot azul';
            }
            when else{
                return null;
            }
        }
    }

    public AvaliacaoVO(Avaliacao__c av) {
        this.userName = av.CreatedBy.Name;
        this.name = av.Name;
        this.nota = av.Nota__c;
        this.descricao = av.Descricao__c;
        this.cor = this.selecionaCor((Integer) this.nota);
    }

    @AuraEnabled public String userName { get; set; }
    @AuraEnabled public String name { get; set; }
    @AuraEnabled public Decimal nota { get; set; }
    @AuraEnabled public String descricao { get; set; }
    @AuraEnabled public String cor { get; set; }
}