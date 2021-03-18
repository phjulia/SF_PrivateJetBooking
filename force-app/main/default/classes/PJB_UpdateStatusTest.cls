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
            System.debug(booking.Customer__r.Total_Flown_Hours__c);
        System.debug(booking.Jet__r.Min_Amount_of_Hours__c);
        System.debug(booking.Status__c);
        system.assertEquals('Automatically approved',booking.Status__c, 'The status of the jet booking should have been auto-approved');
 
        }
        List<Jet_Booking__c> manualBookingsCopy = [SELECT Id, Status__c,Customer__r.Total_Flown_Hours__c,Jet__r.Min_Amount_of_Hours__c FROM Jet_Booking__c WHERE Id IN: manualBookings];
    for(Jet_Booking__c booking: manualBookingsCopy){
        System.debug(booking.Customer__r.Total_Flown_Hours__c);
        System.debug(booking.Jet__r.Min_Amount_of_Hours__c);
        System.debug(booking.Status__c);
        system.assertEquals('Submitted for approval',booking.Status__c, 'The status of the jet booking should have been sent for approval');

    }

    }
    @isTest
    public static void statusUpdate(){
        Test.startTest();
        List<Jet_Booking__c> autoBooking = PJB_UpdateStatusTestData.createTestDataAutoApprove(1);
        List<Jet_Booking__c> manualBooking=PJB_UpdateStatusTestData.createTestDataManualApprove(1);
        Test.stopTest();
        Jet_Booking__c booking = [SELECT Id, Status__c,Customer__r.Total_Flown_Hours__c,Jet__r.Min_Amount_of_Hours__c FROM Jet_Booking__c WHERE Id=:autoBooking.get(0).Id];
        System.debug(booking.Customer__r.Total_Flown_Hours__c);
        System.debug(booking.Jet__r.Min_Amount_of_Hours__c);
        System.debug(booking.Status__c);
        system.assertEquals('Automatically approved',booking.Status__c, 'The status of the jet booking should have been auto-approved');
        system.assertEquals('Submitted for approval',manualBooking.get(0).Status__c, 'The status of the jet booking should have been sent for approval');
        
    }
}
