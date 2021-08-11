@isTest
private class SampleTriggerHandlerTest {
  @isTest
  static void testSampleObjectUpdate() {
    SampleObject__c[] recs = new List<SampleObject__c>{
      new SampleObject__c(Status__c = 'New'),
      new SampleObject__c(Status__c = 'New'),
      new SampleObject__c(Status__c = 'New')
    };
    Database.insert(recs, false);
    recs[0].Status__c = 'InProcess';
    recs[1].Status__c = 'Completed';
    recs[2].Status__c = 'Completed';
    Database.SaveResult[] rets = Database.update(recs, false);
    System.assertEquals(
      rets[0].isSuccess(),
      true,
      'should be saved successfully'
    );
    System.assertEquals(
      rets[1].isSuccess(),
      true,
      'should be saved successfully'
    );
    System.assertEquals(
      rets[2].isSuccess(),
      true,
      'should be saved successfully'
    );
    for (SampleObject__c rec : [
      SELECT Id, Status__c, CompletedDate__c
      FROM SampleObject__c
      WHERE Status__c = 'Completed'
      LIMIT 3
    ]) {
      System.assert(
        rec.CompletedDate__c != null,
        'completed date is not set for records of completed status'
      );
    }
  }

  /**
   * This test fails because of the trigger is skipped in the retry of DML bulk exception
   * https://developer.salesforce.com/docs/atlas.ja-jp.apexcode.meta/apexcode/apex_dml_bulk_exceptions.htm
   */
  @isTest
  static void testSampleObjectUpdateWithFailure() {
    SampleObject__c[] recs = new List<SampleObject__c>{
      new SampleObject__c(Status__c = 'New'),
      new SampleObject__c(Status__c = 'New'),
      new SampleObject__c(Status__c = 'New')
    };
    Database.insert(recs, false);
    recs[0].Status__c = 'InProcess';
    recs[1].Status__c = 'Completed';
    recs[2].Status__c = 'InProcess';
    recs[2].CompletedDate__c = System.now(); // should not accept value if status is not completed
    Database.SaveResult[] rets = Database.update(recs, false);
    System.assertEquals(
      rets[0].isSuccess(),
      true,
      'should be saved successfully'
    );
    System.assertEquals(
      rets[1].isSuccess(),
      true,
      'should be saved successfully'
    );
    System.assertEquals(
      rets[2].isSuccess(),
      false,
      'should return error in save result'
    );
    for (SampleObject__c rec : [
      SELECT Id, Status__c, CompletedDate__c
      FROM SampleObject__c
      WHERE Status__c = 'Completed'
      LIMIT 3
    ]) {
      System.assert(
        rec.CompletedDate__c != null,
        'completed date is not set for records of completed status'
      );
    }
  }
}
