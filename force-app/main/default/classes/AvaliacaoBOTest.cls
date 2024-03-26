@isTest
public with sharing class AvaliacaoBOTest {
    @TestSetup
    static void makeData(){
        Account acc = TestDataFactory.criaAcc('Teste 12121');
        insert acc;
        List<Avaliacao__c> avInsert = new List<Avaliacao__c>();
        avInsert.add(TestDataFactory.criaAv('Av 01', acc.Id, 1));
        avInsert.add(TestDataFactory.criaAv('Av 02', acc.Id, 2));
        avInsert.add(TestDataFactory.criaAv('Av 02', acc.Id, 5));
        avInsert.add(TestDataFactory.criaAv('Av 02', acc.Id, 5));
        // ALDO: tenta reduzir o numero de insert pra somente 1
        
        Account acc2 = TestDataFactory.criaAcc('Teste 92731');
        insert acc2;
        avInsert.add(TestDataFactory.criaAv('Av 01', acc2.Id, 3));
        avInsert.add(TestDataFactory.criaAv('Av 02', acc2.Id, 4));
        avInsert.add(TestDataFactory.criaAv('Av 02', acc2.Id, 4));
        avInsert.add(TestDataFactory.criaAv('Av 02', acc2.Id, 5));
        insert avInsert; 
        // ALDO: tenta reduzir o numero de insert pra somente 1
    }

    @isTest
    public static void updateTest(){
        Account acc = [select Id, Nota__c from Account where Name = 'Teste 12121'];
        List<Avaliacao__c> av = [select Id, Account__c from Avaliacao__c where Account__c = :acc.Id];
        Account acc2 = [select Id, Nota__c from Account where Name = 'Teste 92731'];
        List<Avaliacao__c> av2 = [select Id, Account__c from Avaliacao__c where Account__c = :acc2.Id];

        AvaliacaoBO.updateNota(av);
        AvaliacaoBO.updateNota(av2);

        Assert.areEqual(Integer.valueOf(acc.Nota__c), 3);
        Assert.areEqual(Integer.valueOf(acc2.Nota__c), 4);
    }
}