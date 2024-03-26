public with sharing class CadastroAvaliacaoController {

    @AuraEnabled
    public static Id setAv(Avaliacao__c av){
        try {
            insert av;
            return av.Id;
        } catch (Exception e) {
            system.debug(e.getMessage());
            return null;
        }
    }

    @AuraEnabled
    public static List<AvaliacaoVO> getAv(Id accountId){
        try {
            list<AvaliacaoVO> listAv = new List<AvaliacaoVO>();
            for(Avaliacao__c av : AvaliacaoDAO.getAv(accountId)){
                AvaliacaoVO avVo = new AvaliacaoVO(av);
                listAv.add(avVo);
            }
            return listAv;
        } catch (Exception e) {
            system.debug(e.getMessage());
            return null;
        }
    }

    @AuraEnabled
    public static String getCompleteUserName(){
        String completeName = UserInfo.getName(); //ALDO:  existe um metodo na userInfo que ja faz essa concatenação
        return completeName;
    }

    @AuraEnabled
    public static string getAccName(Id accountId){
        try {
            return AvaliacaoDAO.getNomeConta(accountId);
        } catch (Exception e) {
            system.debug(e.getMessage());
            return null;
        }
    }

    @AuraEnabled
    public static Decimal getMenorNota(Id accountId){
        try {
            return AvaliacaoDAO.getMenorNota(accountId);
        } catch (Exception e) {
            system.debug(e.getMessage());
            return null;
        }
    }

    @AuraEnabled
    public static Decimal getMaiorNota(Id accountId){
        try {
            return AvaliacaoDAO.getMaiorNota(accountId);
        } catch (Exception e) {
            system.debug(e.getMessage());
            return null;
        }
    }

    @AuraEnabled
    public static list<MediaVO> getMedias(Id accountId){
        try {
            list<MediaVO> returnMedias = new list<MediaVO>();
            for(AvaliacaoMediaDiaria__c media : AvaliacaoDAO.getMedias(accountId)){
                returnMedias.add( new MediaVO(media) );
            }
            system.debug(returnMedias);
            return returnMedias;
        } catch (Exception e) {
            system.debug(e.getMessage());
            return null;
        }
    }
}