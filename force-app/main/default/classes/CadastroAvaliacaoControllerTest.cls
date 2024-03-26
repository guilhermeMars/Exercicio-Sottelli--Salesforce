@isTest
public class CadastroAvaliacaoControllerTest {
	// Criar dados no dataFactory
	// Apenas inserir pelo TestSetup
    @TestSetup
    public static void setupData(){
        Account acc = TestDataFactory.criaAcc('Nova Squad');
        insert acc;
        User usr = TestDataFactory.criaUser('Teste', 'da Silva 11111');
        insert usr;
        System.runAs(usr){
            List<Avaliacao__c> avInsert = new List<Avaliacao__c>();
            avInsert.add(TestDataFactory.criaAv('Teste de test 11111', acc.Id, 5));
        	avInsert.add(TestDataFactory.criaAv('Teste de test 22222', acc.Id, 5));
        	avInsert.add(TestDataFactory.criaAv('Teste de test 33333', acc.Id, 2));
            insert avInsert;
            // ALDO: tenta reduzir o numero de insert pra somente 1
        }
        insert TestDataFactory.criaUser(null, 'Err');
    }
    
    @isTest
    public static void testSetAv(){
        // Perguntar Eliseu aobre criar localmente para uma classe que apenas insere
        Account acc = [select Id from Account where Name = 'Nova Squad'];
        Avaliacao__c ava = TestDataFactory.criaAv('Teste Set', acc.Id, 5);
        
        Id avaId = CadastroAvaliacaoController.setAv(ava);
        Avaliacao__c avaSelect = [select Name, Nota__c, Descricao__c from Avaliacao__c where id = :avaId];
        Assert.areEqual(avaId, avaSelect.Id);
        
        //Test Error
        Assert.isNull(CadastroAvaliacaoController.setAv(null));
    }
    
    @isTest
    public static void testGetAv(){
        list<Avaliacao__c> avaList = [select CreatedBy.Name, Name, Nota__c, Descricao__c, Account__c from Avaliacao__c];
        Account acc = [select Id from Account where Name = 'Nova Squad'];
        User usr = [select Id from User where LastName = 'da Silva 11111'];
        
        list<AvaliacaoVO> accList = new list<AvaliacaoVO>();
        list<AvaliacaoVO> accGetAv = CadastroAvaliacaoController.getAv(acc.Id);
        integer i = 0;
        for(Avaliacao__c avaC : avaList){
            AvaliacaoVO ava = new AvaliacaoVO(avaC);
            accList.add(ava);
            Assert.areEqual(accGetAv[i].name, ava.name);
            i++;
        }

        system.debug('accGetAv: '+ accGetAv);
        system.debug('AccList: '+ accList);
        Assert.areEqual(accList.size(), accGetAv.size());        
        // Test Error
        Assert.isNull(CadastroAvaliacaoController.getAv(usr.Id));
        
        // ALDO: reduz o numero de select no mesmo obj pra somente 1
    }
    
    @isTest
    public static void testUserName(){
        User usr = [select Id from User where LastName = 'da Silva 11111'];
        
        System.runAs(usr) {
            string nomeUser = CadastroAvaliacaoController.getCompleteUserName();
            Assert.areEqual(nomeUser, 'Teste da Silva 11111');
        }
    }
    
    @isTest
    public static void testAccName(){
        Account acc = [select Id, Name from Account where Name = 'Nova Squad'];
        
        string nomeAcc = CadastroAvaliacaoController.getAccName(acc.Id);
        Assert.areEqual(nomeAcc, acc.Name);
        
        // Test Error
        Assert.isNull(CadastroAvaliacaoController.getAccName(null));
    }
    
    @isTest
    public static void getMenorNota(){
        Account acc = [select Id, Name from Account where Name = 'Nova Squad'];
        
        Decimal menor = CadastroAvaliacaoController.getMenorNota(acc.Id);
        Assert.areEqual(menor, 2);
        
        //Test Error
        Assert.isNull(CadastroAvaliacaoController.getMenorNota(null));
    }
    
    @isTest
    public static void getMaiorNota(){
        Account acc = [select Id, Name from Account where Name = 'Nova Squad'];
        
        Decimal maior = CadastroAvaliacaoController.getMaiorNota(acc.Id);
        Assert.areEqual(maior, 5);
        
        //Test Error
        Assert.isNull(CadastroAvaliacaoController.getMaiorNota(null));
    }
}