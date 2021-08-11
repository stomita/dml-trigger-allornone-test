trigger SampleTrigger on SampleObject__c(before update) {
  System.debug(
    'Sample Trigger: before update: record length = ' + Trigger.new.size()
  );
  if (!SampleTriggerHandler.triggerCalled) {
    SampleTriggerHandler.triggerCalled = true;
    SampleTriggerHandler.handleBeforeUpdate(Trigger.new);
  }
}
