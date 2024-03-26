@isTest
public with sharing class AvaliacaoDAOTest {
    @TestSetup
    static void makeData(){
        Account acc = TestDataFactory.criaAcc('Teste 81732');
        insert acc;
        List<Avaliacao__c> avInsert = new List<Avaliacao__c>();
        avInsert.add(TestDataFactory.criaAv('Av 01', acc.Id, 1));
        avInsert.add(TestDataFactory.criaAv('Av 02', acc.Id, 2));
        avInsert.add(TestDataFactory.criaAv('Av 03', acc.Id, 5));
        avInsert.add(TestDataFactory.criaAv('Av 04', acc.Id, 5));
        insert avInsert;
        // ALDO: tenta reduzir o numero de insert pra somente 1
    }

    @isTest
    public static void getAvWork(){
        Account acc = [select Id from Account where Name = 'Teste 81732'];
        list<Avaliacao__c> avList = [select CreatedBy.Name, Name, Nota__c, Descricao__c, Account__c from Avaliacao__c 
        WHERE Account__c = :acc.Id
        ORDER BY createdDate DESC];
        // Avaliacao__c avFirstItem = [select CreatedBy.Name, Name, Nota__c, Descricao__c, Account__c from Avaliacao__c WHERE Name = 'Av 01'];

        list<Avaliacao__c> avGet = AvaliacaoDAO.getAv(acc.Id);

        Assert.areEqual(avGet, avList);
        // Assert.areEqual(avGet[0], avFirstItem);
    }

    @isTest
    public static void getAvException(){
        try {
            List<Avaliacao__c> avErr = AvaliacaoDAO.getAv(null);
        } catch (Exception e) {
            Assert.areEqual(e.getMessage(), 'Nenhum elemento foi retornado');
        }
    }

    @isTest
    public static void getNomeContaWork(){
        Account acc = [select Id from Account where Name = 'Teste 81732'];

        string nomeUser = AvaliacaoDAO.getNomeConta(acc.Id);
        Assert.areEqual(nomeUser, 'Teste 81732');
    }
    
    @isTest
    public static void getMenorNotaWork(){
        Account acc = [select Id from Account where Name = 'Teste 81732'];
        
        Decimal menor = AvaliacaoDAO.getMenorNota(acc.Id);
        Assert.areEqual(menor, 1);
    }
    
    @isTest
    public static void getMaiorNotaWork(){
        Account acc = [select Id from Account where Name = 'Teste 81732'];
        
        Decimal menor = AvaliacaoDAO.getMaiorNota(acc.Id);
        Assert.areEqual(menor, 5);
    }
}