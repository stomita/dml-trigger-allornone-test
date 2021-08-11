public with sharing class SampleTriggerHandler {
  public static boolean triggerCalled = false;
  public static void handleBeforeUpdate(List<SampleObject__c> recs) {
    for (SampleObject__c rec : recs) {
      System.debug('Status => ' + rec.Status__c);
      if (rec.Status__c == 'Completed') {
        rec.CompletedDate__c = System.now();
      }
    }
  }
}
