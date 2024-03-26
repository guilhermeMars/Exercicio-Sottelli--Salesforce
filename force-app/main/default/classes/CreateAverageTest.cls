@isTest
public with sharing class CreateAverageTest {
    @TestSetup
    static void makeData(){
        Account acc = TestDataFactory.criaAcc('Teste 43321');
        insert acc;
        List<Avaliacao__c> avInsert = new List<Avaliacao__c>();
        avInsert.add(TestDataFactory.criaAv('Av 354', acc.Id, 4));
        avInsert.add(TestDataFactory.criaAv('Av 643', acc.Id, 3));
        avInsert.add(TestDataFactory.criaAv('Av 543', acc.Id, 5));
        insert avInsert;
        // ALDO: tenta reduzir o numero de insert pra somente 1
        // Account errAcc = TestDataFactory.criaAcc('Teste Err');
        // insert errAcc;
        // insert TestDataFactory.criaAv('Av 543', acc.Id, null);
    }

    @isTest 
    static void inserirMediaWork(){
        CreateAverage.inserirMedia();
        Account acc = [select Id, Nota__c from Account where Name = 'Teste 43321'];
        AvaliacaoMediaDiaria__c avMedia = [select Account__c, Name, media_conta__c from AvaliacaoMediaDiaria__c WHERE Account__c = :acc.Id];
        
        Assert.areEqual(acc.Id, avMedia.Account__c);
        Assert.areEqual(null, acc.Nota__c);
        Assert.areEqual(4, avMedia.media_conta__c);
        Assert.areEqual('Média de avaliações do dia ' + system.today().day(), avMedia.Name);
    }

    // @isTest
    // static void inserirMediaErr(){
    //     CreateAverage.inserirMedia();
    //     Account acc = [select Id, Nota__c from Account where Name = 'Teste Err'];
    //     AvaliacaoMediaDiaria__c avMedia = [select Account__c, Name, media_conta__c from AvaliacaoMediaDiaria__c WHERE Account__c = :acc.Id];
        

    // }
}