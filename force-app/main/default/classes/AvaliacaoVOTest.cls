@isTest
public with sharing class AvaliacaoVOTest {
    @TestSetup
    static void makeData(){
        Account acc = TestDataFactory.criaAcc('Conta 34223');
        insert acc;
        User usr = TestDataFactory.criaUser('Rosária', 'Lemos');
        insert usr;
        System.runAs(usr){
            List<Avaliacao__c> avInsert = new List<Avaliacao__c>();
            avInsert.add(TestDataFactory.criaAv('Teste 92132', acc.Id, 1));
            avInsert.add(TestDataFactory.criaAv('Teste 32312', acc.Id, 2));
            avInsert.add(TestDataFactory.criaAv('Teste 43234', acc.Id, 3));
            avInsert.add(TestDataFactory.criaAv('Teste 65454', acc.Id, 4));
            avInsert.add(TestDataFactory.criaAv('Teste 65234', acc.Id, 5));
            avInsert.add(TestDataFactory.criaAv('Teste Err 65234', acc.Id, 6)); 
            insert avInsert;
            // ALDO: da um insert só
        }
    }

    @isTest
    public static void AvaliacaoVOWork(){
        list<Avaliacao__c> listSelect = [select CreatedBy.Name, Name, Nota__c, Descricao__c from Avaliacao__c];
        
        for(Avaliacao__c item : listSelect){
            AvaliacaoVO avVO = new AvaliacaoVO(item);
            Assert.areEqual(avVO.userName, item.CreatedBy.Name);
            Assert.areEqual(avVO.name, item.Name);
            Assert.areEqual(avVO.nota, item.Nota__c);
            Assert.areEqual(avVO.descricao, item.Descricao__c);
        }

        // ALDO: faz um select só, cria uma lista e itera sobre ela
    }
}