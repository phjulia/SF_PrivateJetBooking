@isTest
public with sharing class PJB_JetTriggerTest {
    @isTest static void setInspDateTestManyJets(){
        
        Test.startTest();
        List<Jet__c> jets=PJB_JetTriggerTestData.createTestData(300);
        
        Jet__c[] updated =[SELECT Id,Next_Inspection__c FROM Jet__c WHERE Id IN: jets]; 
        // System.debug(updated.Next_Inspection__c);
        
        Date nextInspection = System.today().AddDays(14);
        Datetime dt = (DateTime)nextInspection;
        String dayOfWeek = dt.format('EEE');
        if(dayOfWeek == 'Sat'){
            nextInspection=nextInspection.AddDays(2);
        }else if(dayOfWeek == 'Sun'){
            nextInspection=nextInspection.AddDays(1);
        }
        for(Jet__c j: updated){
            
            system.assertEquals(nextInspection,j.Next_Inspection__c,'Bulk test failed. Wrong Next Inspection Date');
        }

    }
    @isTest static void setInspDateTestOneJet(){
        Test.startTest();
        Customer__c customer=new Customer__c(Name='Christopher Johnson',Birth_date__c=Date.parse('09/11/1987'),Pilot_License_Num__c='C432');
        insert customer;
        Jet__c jet = new Jet__c(Status__c='Active');
        insert jet;
        Jet_Booking__c booking= new Jet_Booking__c(Customer__c=customer.Id, Jet__c=jet.Id,
        DepartureDateTime__c=Datetime.now(),Arrival_Date_Time__c=Datetime.now().addDays(50));
        
        insert booking;
        Test.stopTest();
        List<Jet__c> updated =[SELECT Id,Next_Inspection__c FROM Jet__c WHERE Id=:jet.Id];

        Date nextInspection = System.today().AddDays(14);
				Datetime dt = (DateTime)nextInspection;
				String dayOfWeek = dt.format('EEE');
                if(dayOfWeek == 'Sat'){
                    nextInspection=nextInspection.AddDays(2);
                }else if(dayOfWeek == 'Sun'){
                    nextInspection=nextInspection.AddDays(1);
                }
      
        for(Jet__c j: updated){
            system.assertEquals(nextInspection,j.Next_Inspection__c,'Wrong next inspection date');
        }
    }
}