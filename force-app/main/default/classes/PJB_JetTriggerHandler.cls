public with sharing class PJB_JetTriggerHandler {
    public static void onCreateOrUpdate(List<Jet__c> jets){
        PJB_JetTriggerHelper.setNextInspectionDate(jets);
        
    }  
    public static void onAfterUndelete(List<Jet__c> jets){
        PJB_JetTriggerHelper.addWhenRecovered(jets);
    } 
} 
