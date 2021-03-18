@isTest
public with sharing class PJB_UpdateStatusTestData {
    public static List<Jet_Booking__c> createTestDataAutoApprove(Integer num){
        Customer__c customer=new Customer__c(Name='Test Customer',Birth_date__c=Date.parse('09/11/1987'),Pilot_License_Num__c='C432',Total_Flown_Hours__c=55);
        insert customer;
        Jet__c jet = new Jet__c(Status__c='Active',Min_Amount_of_Hours__c=20);
        insert jet;
        List<Jet_Booking__c> bookings = new List<Jet_Booking__c>();

        for(Integer i=0;i<num;i++){
        Jet_Booking__c booking= new Jet_Booking__c(Customer__c=customer.Id, Jet__c=jet.Id,
        DepartureDateTime__c=Datetime.now(),Arrival_Date_Time__c=Datetime.now().addDays(1),Status__c='Created');
            bookings.add(booking);
        }
        
        insert bookings;

        return bookings;
    }
    public static List<Jet_Booking__c> createTestDataManualApprove(Integer num){
        Customer__c customer=new Customer__c(Name='Test Customer',Birth_date__c=Date.parse('09/11/1987'),Pilot_License_Num__c='C432',Total_Flown_Hours__c=25);
        insert customer;
        Jet__c jet = new Jet__c(Status__c='Active',Min_Amount_of_Hours__c=60);
        insert jet;
        List<Jet_Booking__c> bookings = new List<Jet_Booking__c>();

        for(Integer i=0;i<num;i++){
        Jet_Booking__c booking= new Jet_Booking__c(Customer__c=customer.Id, Jet__c=jet.Id,
        DepartureDateTime__c=Datetime.now(),Arrival_Date_Time__c=Datetime.now().addDays(1),Status__c='Created');
        bookings.add(booking);
        }
        insert bookings;

        return bookings;
    }
}
