public with sharing class AvaliacaoDAO { 

    public static list<Avaliacao__c> getAv(Id accountId){
        list<Avaliacao__c> acc = [select CreatedBy.Name, Name, Nota__c, Descricao__c, Account__c from Avaliacao__c 
        WHERE Account__c = :accountId
        ORDER BY createdDate DESC]; 

        if(acc.size() <= 0 || accountId == null){
            throw new ListException('Nenhum elemento foi retornado');
        }
        return acc;
    }

    public static string getNomeConta(Id accountId){
        Account acc = [select Name from Account WHERE Id = :accountId];
        string str = (String)acc.Name;
        return str;
    }
    
    public static Decimal getMenorNota(Id accountId){
        AggregateResult[] avMenor = [
            select MIN(Nota__c)menor from Avaliacao__c WHERE Account__c = :accountId
        ];
        
        if(avMenor.size() <= 0 || accountId == null){
            throw new ListException('Nenhum elemento foi retornado');
        }
        
        return (Decimal) avMenor[0].get('menor');
    }

    public static Decimal getMaiorNota(Id accountId){
        AggregateResult[] avMaior = [
            select MAX(Nota__c)maior from Avaliacao__c WHERE Account__c = :accountId
        ];
        
        if(avMaior.size() <= 0 || accountId == null){
            throw new ListException('Nenhum elemento foi retornado');
        }
        
        return (Decimal) avMaior[0].get('maior');
    }

    public static list<AvaliacaoMediaDiaria__c> getMedias(Id accountId){
        list<AvaliacaoMediaDiaria__c> listaMedia = [select Name, media_conta__c from AvaliacaoMediaDiaria__c where Account__c = :accountId];
        system.debug(listaMedia);
        if (listaMedia.size() <= 0 || listaMedia == null) {
            throw new ListException('Nenhum elemento foi retornado');
        }
        return listaMedia;
    }
}