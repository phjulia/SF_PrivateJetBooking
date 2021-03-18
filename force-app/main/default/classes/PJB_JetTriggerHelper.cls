public with sharing class PJB_JetTriggerHelper {
  
    public static void setNextInspectionDate(List<Jet__c> jets){
        
        for(Jet__c jet: jets){
            if(jet.Total_Flown_Hours__c>1000 ){
                Date nextInspection = System.today().AddDays(14);
				Datetime dt = (DateTime)nextInspection;
				String dayOfWeek = dt.format('EEE');
                if(dayOfWeek == 'Sat'){
                    nextInspection=nextInspection.AddDays(2);
                }else if(dayOfWeek == 'Sun'){
                    nextInspection=nextInspection.AddDays(1);
                }
                
                jet.Next_Inspection__c=nextInspection;
            }else if(jet.Status__c=='On Hold'){
                Group g = [SELECT Id FROM Group WHERE Name='Jet Operators'];
                sendNotification(jet,jet.Id,
                 'This is Test Message', new set<String>{Id.valueOf(g.Id)});
            }
            
        } 
    }
    public static void sendNotification(Jet__c jet, String strTargetId, String strTitle, Set<String> setUserIds) {
       
        Messaging.CustomNotification obj = new Messaging.CustomNotification();
        CustomNotificationType notification = [SELECT Id, CustomNotifTypeName, DeveloperName from CustomNotificationType WHERE DeveloperName = 'CustomNotification'];
        obj.setNotificationTypeId(notification.Id);
        obj.setTargetId(strTargetId);
        obj.setTitle(strTitle);
        User user =[SELECT Name FROM User WHERE ID=:jet.LastModifiedById];
        obj.setBody(jet.Model_Name__c+ ' marked on hold by '+ user.Name +'. Please review this jet.');
        obj.send(setUserIds);
    }
    public static void addWhenRecovered(List<Jet__c> jets){
        List<Jet__c> jetsToUpdate = new List<Jet__c>();
        for(Jet__c jet: jets){ 
            jetsToUpdate.add(new Jet__c(Id=jet.Id,Recovery_date__c=DateTime.Now()));
        }
        update jetsToUpdate;
    }
}
