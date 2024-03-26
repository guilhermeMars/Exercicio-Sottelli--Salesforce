public with sharing class AvaliacaoTriggerHandler extends TriggerHandler{
    public override void afterInsert(){
        AvaliacaoBO.updateNota(Trigger.new);
    }
}