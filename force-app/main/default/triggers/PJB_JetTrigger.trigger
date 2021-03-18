trigger PJB_JetTrigger on Jet__c (before insert, before update,after undelete) {
  if(trigger.isUpdate || trigger.isInsert ){
  PJB_JetTriggerHandler.onCreateOrUpdate(Trigger.new);
  }else if(trigger.isUndelete){
    PJB_JetTriggerHandler.onAfterUndelete(Trigger.new);
  }
} 