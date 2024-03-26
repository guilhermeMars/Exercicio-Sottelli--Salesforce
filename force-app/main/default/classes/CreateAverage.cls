public with sharing class CreateAverage {
    public static void inserirMedia(){
        Set<AvaliacaoMediaDiaria__c> avMediaUpd = new Set<AvaliacaoMediaDiaria__c>();
        Set<Account> accUpd = new Set<Account>();

        list<Avaliacao__c> avList = [select Id, Account__c, Account__r.Nota__c, Account__r.Name from Avaliacao__c WHERE CreatedDate >= :system.today()];
        system.debug(avList);
        // map<Id, Decimal> notasValidas = new Map<Id, Decimal>();
        for(Avaliacao__c av : avList){
            Decimal nota = av.Account__c != null ? av.Account__r.Nota__c : null;
            if(nota != null){
                // notasAccount.put(av.Account__c, nota);
                avMediaUpd.add(new AvaliacaoMediaDiaria__c(
                    Account__c = av.Account__c,
                    Name = 'Média de avaliações do dia ' + system.today().day(),
                    media_conta__c = nota
                ));
                accUpd.add(new Account(
                    Id = av.Account__c,
                    Nota__c = null
                ));
            }
        }
        insert new List<AvaliacaoMediaDiaria__c>(avMediaUpd);
        update new List<Account>(accUpd);
    }
}