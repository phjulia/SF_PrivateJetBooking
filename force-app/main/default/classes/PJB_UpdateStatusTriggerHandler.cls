public with sharing class PJB_UpdateStatusTriggerHandler {
    public static void updateStatus(List<Jet_Booking__c> bookings){
        PJB_UpdateStatusTriggerHelper.updateStatus(bookings);
    }
    public static void sendForApproval(List<Jet_Booking__c> bookings){
        PJB_UpdateStatusTriggerHelper.sendForApproval(bookings);
    }
}
