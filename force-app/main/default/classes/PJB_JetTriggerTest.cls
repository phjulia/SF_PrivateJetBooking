@isTest
public with sharing class PJB_JetTriggerTest {
    public static Integer counter=1;
    @isTest static void recoveredDateTestOne(){
        Test.startTest();
        List<Jet__c> jet = PJB_JetTriggerTestData.createTestData(1);
        DateTime oldDate = jet.get(0).Recovery_date__c;
        delete jet;
        undelete jet;
        Jet__c recovered =[SELECT Id, Recovery_date__c FROM Jet__c WHERE Id =:jet.get(0).Id];
        system.assertEquals(true,oldDate!=recovered.Recovery_date__c,'The recovery date was not updated');
        Test.stopTest();
         }

         @isTest static void recoveredDateBulkTest(){
            Test.startTest();
            List<Jet__c> jets = PJB_JetTriggerTestData.createTestData(300);
         
            DateTime oldDate = jets.get(0).Recovery_date__c;
            delete jets;
            undelete jets;
            //   
            List<Jet__c> recovered =[SELECT Id, Recovery_date__c FROM Jet__c WHERE Id IN :jets];
            for(Jet__c jet: recovered){
            system.assertEquals(true,oldDate!=jet.Recovery_date__c,'The recovery date was not updated');
             }
             Test.stopTest();
            }
    @isTest static void setOnHoldTest(){
        Test.startTest();
        List<Jet__c> jet = PJB_JetTriggerTestData.sendNotifTestData(1);
        jet.get(0).Status__c='On Hold';
        update jet.get(0);
        List<Jet__c> updated =[SELECT Id FROM Jet__c WHERE Id IN :jet];
        Test.stopTest();
        system.assertEquals(1,updated.size(),'Notification wasnt sent');
    }
    @isTest static void setInspDateTestManyJets(){
        
        Test.startTest();
        List<Jet__c> jets=PJB_JetTriggerTestData.createTestData(300);
        Test.stopTest();
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
        List<Jet__c> jet=PJB_JetTriggerTestData.createTestData(1);
        Test.stopTest();
        List<Jet__c> updated =[SELECT Id,Next_Inspection__c FROM Jet__c WHERE Id IN :jet];

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