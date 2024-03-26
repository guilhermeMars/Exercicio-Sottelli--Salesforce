@isTest
public class TestDataFactory {
    public static User criaUser(string Fname, string Lname){
        User usr = new User();
        usr.ProfileId = [SELECT Id FROM Profile WHERE Name != 'System Administrator' limit 1].Id;
        usr.FirstName = Fname;
        usr.LastName = Lname;
        usr.Email = 'test@test.com';
        usr.Username = 'test@test.com' + System.currentTimeMillis();
        usr.CompanyName = 'Salesforce';
        usr.Title = 'Title';
        usr.Alias = 'Roger';
        usr.TimeZoneSidKey = 'America/Los_Angeles';
        usr.EmailEncodingKey = 'UTF-8';
        usr.LanguageLocaleKey = 'en_US';
        usr.LocaleSidKey = 'en_US';
        return usr;
    }
    
    public static Avaliacao__c criaAv(string Nome, Id accId, Decimal Nota){
        Avaliacao__c ava = new Avaliacao__c(
        	Name = Nome,
            Nota__c = Nota,
            Descricao__c = 'Um teste unitario comum',
            Account__c = accId
        );
        return ava;
    }
    
    public static Account criaAcc(string Nome){
        Account acc = new Account(
        	Name = Nome
        );
        return acc;
    }
}