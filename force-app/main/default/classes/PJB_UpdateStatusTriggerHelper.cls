public with sharing class PJB_UpdateStatusTriggerHelper {

    public static void updateStatus(List<Jet_Booking__c> bookings){
       Set<Id> customers =  new Set<Id>();
       Set<Id> jets =  new Set<Id>();
       for (Jet_Booking__c booking: bookings) {
        if (booking.Customer__r.Id != null) {
            customers.add(booking.Customer__r.Id);
            System.debug('HI '+booking.Customer__r.Id);
        }
        if(booking.Jet__r.Id != null){
            jets.add(booking.Jet__r.Id);
            System.debug('Hi '+booking.Jet__r.Id);
        }
    }
        Map<Id,Customer__c> customersMap= new Map<Id, Customer__c>(
            [SELECT Id, Total_Flown_Hours__c FROM Customer__c WHERE Id IN :customers ]
        );
        Map<Id,Jet__c> jetsMap= new Map<Id, Jet__c>(
            [SELECT Id,Min_Amount_of_Hours__c FROM Jet__c WHERE Id IN :jets ]
        );

        for (Jet_Booking__c b : bookings) {
            if (b.Customer__r.Id != null && b.Jet__r.Id !=null && customersMap.get(b.Customer__r.Id)
            .Total_Flown_Hours__c>=jetsMap.get(b.Jet__r.Id).Min_Amount_of_Hours__c) {
                b.Status__c= 'Automatically approved';
            }else{
                b.Status__c= 'Submitted for approval';
            }
         }

    }
    public static void sendForApproval(List<Jet_Booking__c> bookings){
        Approval.ProcessSubmitRequest [] requestList = new Approval.ProcessSubmitRequest []{};

    for(Jet_Booking__c booking: bookings){
        if(booking.Status__c=='Submitted for approval'){
       Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
    
       req1.setComments('Submitting request for approval automatically using Trigger');
    
       req1.setObjectId(booking.id);
          }
          if(requestList.size()>0){
    Approval.ProcessResult[] result = Approval.process(requestList);
          }
    }
}
}

