public with sharing class AvaliacaoBO {
    public static void updateNota(list<Avaliacao__c> triggerNew){
        list<Account> accUpd = new List<Account>();
        set<Id> idAcc = new set<Id>();
        for(Avaliacao__c trr : triggerNew){
            idAcc.add(trr.Account__c);
        }
        list<Account> accWithId = new list<Account>([
            select Id, Nota__c from Account
            WHERE Id = :idAcc
            Order by Id
        ]);
        AggregateResult[] mediaContas = [select AVG(Nota__c)media from Avaliacao__c WHERE Account__c IN :idAcc group by Account__c Order by Account__c];
        for(integer i=0; i < idAcc.size(); i++){
            Decimal media = (Decimal)mediaContas[i].get('media');
            accWithId[i].Nota__c = media;
            accUpd.add(accWithId[i]);
        }
        update accUpd;
    }
}