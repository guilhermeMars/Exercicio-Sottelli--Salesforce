public with sharing class MediaVO {
    public MediaVO(AvaliacaoMediaDiaria__c media) {
        this.name = media.Name;
        this.nota = media.media_conta__c.setScale(1);
    }

    @AuraEnabled public String name {get; set;}
    @AuraEnabled public Decimal nota {get; set;}
}