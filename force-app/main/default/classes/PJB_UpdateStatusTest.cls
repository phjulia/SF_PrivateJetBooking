@isTest
public with sharing class PJB_UpdateStatusTest {
    // public PJB_UpdateStatusTest() {
    // }
    @isTest
    public static void bulkStatusUpdate(){
        Test.startTest();
        List<Jet_Booking__c> autoBookings=PJB_UpdateStatusTestData.createTestDataAutoApprove(300);
        List<Jet_Booking__c> manualBookings=PJB_UpdateStatusTestData.createTestDataManualApprove(300);
       
        Test.stopTest();
        List<Jet_Booking__c> autoBookingsCopy = [SELECT Id, Status__c,Customer__r.Total_Flown_Hours__c,Jet__r.Min_Amount_of_Hours__c FROM Jet_Booking__c WHERE Id IN: autoBookings];
        for(Jet_Booking__c booking: autoBookingsCopy){
        system.assertEquals('Automatically Approved',booking.Status__c, 'The status of the jet booking should have been auto-approved');
 
        }
        List<Jet_Booking__c> manualBookingsCopy = [SELECT Id, Status__c,Customer__r.Total_Flown_Hours__c,Jet__r.Min_Amount_of_Hours__c FROM Jet_Booking__c WHERE Id IN: manualBookings];

    for(Jet_Booking__c booking: manualBookingsCopy){
        system.assertEquals('Submitted for approval',booking.Status__c, 'The status of the jet booking should have been sent for approval');
        List<ProcessInstance> processInstances = [select Id, Status from ProcessInstance WHERE TargetObjectId = :booking.id];
        List<ProcessInstanceWorkitem> pendingInstances =[SELECT ProcessInstanceId,ActorId FROM ProcessInstanceWorkitem];
        for(ProcessInstance p: processInstances){
            System.debug('processInstance '+p.Id+' status '+p.Status);
        }
        System.debug('here');
        for(ProcessInstanceWorkitem p: pendingInstances){
        System.debug('ProcessInstanceId '+p.ProcessInstanceId+' ActorId '+p.ActorId);
        }
        
    }

    }
    @isTest
    public static void statusUpdate(){
        Test.startTest();
        List<Jet_Booking__c> autoBooking = PJB_UpdateStatusTestData.createTestDataAutoApprove(1);
        List<Jet_Booking__c> manualBooking=PJB_UpdateStatusTestData.createTestDataManualApprove(1);
        Test.stopTest();
        Jet_Booking__c autoBookingCopy = [SELECT Id, Status__c,Customer__r.Total_Flown_Hours__c,Jet__r.Min_Amount_of_Hours__c FROM Jet_Booking__c WHERE Id=:autoBooking.get(0).Id];
        Jet_Booking__c manualBookingCopy = [SELECT Id, Status__c,Customer__r.Total_Flown_Hours__c,Jet__r.Min_Amount_of_Hours__c FROM Jet_Booking__c WHERE Id=:manualBooking.get(0).Id];
        system.assertEquals('Automatically Approved',autoBookingCopy.Status__c, 'The status of the jet booking should have been auto-approved');
        system.assertEquals('Submitted for approval',manualBookingCopy.Status__c, 'The status of the jet booking should have been sent for approval');
        List<ProcessInstance> processInstances = [select Id, Status from ProcessInstance WHERE TargetObjectId = :manualBookingCopy.id];
        List<ProcessInstanceWorkitem> pendingInstances =[SELECT ProcessInstanceId,ActorId FROM ProcessInstanceWorkitem];
        for(ProcessInstance p: processInstances){
            System.debug('processInstance '+p.Id+' status '+p.Status);
        }
        System.debug('here');
        for(ProcessInstanceWorkitem p: pendingInstances){
        System.debug('ProcessInstanceId '+p.ProcessInstanceId+' ActorId '+p.ActorId);
        }
        
       // system.assertEquals(1,PJB_UpdateStatusTriggerHelper.approvalProcesses,'An approval process was not started');
    }
}
