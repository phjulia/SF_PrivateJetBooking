@isTest
public with sharing class PJB_JetTriggerTestData {
    public static List<Jet__c> createTestData(Integer num){
        Customer__c customer=new Customer__c(Name='Christopher Johnson',Birth_date__c=Date.parse('09/11/1987'),Pilot_License_Num__c='C432');
        insert customer;

        List<Jet__c> jets=new List<Jet__c>();
        List<Jet_Booking__c> bookings=new List<Jet_Booking__c>();

        for(Integer i=0;i<num;i++) {
        Jet__c jet = new Jet__c(Status__c='Active');
        jets.add(jet);
        }
        insert jets;
        
        for(Jet__c jet:jets){
        Jet_Booking__c booking= new Jet_Booking__c(Customer__c=customer.Id, Jet__c=jet.Id,
        DepartureDateTime__c=Datetime.now(),Arrival_Date_Time__c=Datetime.now().addDays(50));
        bookings.add(booking);
        }
        insert bookings;
        
        
        return jets;
    }
}
