public with sharing class PJB_UpdateStatusTriggerHelper {

    public static void updateStatus(List<Jet_Booking__c> bookings){
        Set<Id> customerIds = new Set<Id>();
        Set<Id> jetIds = new Set<Id>();
for (Jet_Booking__c booking : bookings){ 
    customerIds.add(booking.Customer__c);
    jetIds.add(booking.Jet__c);
}
Map<Id, Customer__c> customers = new Map<Id, Customer__c>([
    SELECT Total_Flown_Hours__c FROM Customer__c WHERE Id IN :customerIds
]);
Map<Id, Jet__c> jets = new Map<Id, Jet__c>([
    SELECT Min_Amount_of_Hours__c FROM Jet__c WHERE Id IN :jetIds
]);
for (Jet_Booking__c booking : bookings)
{
    Customer__c customer = customers.get(booking.Customer__r.Id);
    Jet__c jet = jets.get(booking.Jet__r.Id);
    if (booking.Customer__c != null && booking.Jet__c !=null && customers.get(booking.Customer__c)
    .Total_Flown_Hours__c>=jets.get(booking.Jet__c).Min_Amount_of_Hours__c) {
        booking.Status__c= 'Automatically approved';
    }else{
        booking.Status__c= 'Submitted for approval';
    }
}
    }
    public static void sendForApproval(List<Jet_Booking__c> bookings){
        Approval.ProcessSubmitRequest [] requestList = new Approval.ProcessSubmitRequest []{};

    for(Jet_Booking__c booking: bookings){
        if(booking.Status__c.equals('Submitted for approval')){
     
       Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
       req1.setComments('Submitting request for approval automatically using Trigger');
    req1.setProcessDefinitionNameOrId('Approve Booking');
       req1.setObjectId(booking.id);
          }
        }
          if(requestList.size()>0){
             Approval.ProcessResult[] result = Approval.process(requestList);
          }
    }

}

