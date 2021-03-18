trigger PJB_UpdateStatusTrigger on Jet_Booking__c (before update, before insert, after update, after insert) {
    if(Trigger.isBefore){
    PJB_UpdateStatusTriggerHandler.updateStatus(Trigger.new);
    }else if(Trigger.isAfter){
        PJB_UpdateStatusTriggerHelper.sendForApproval(Trigger.new);

    }
    
}