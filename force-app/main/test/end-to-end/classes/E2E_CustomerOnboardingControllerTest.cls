@IsTest
private class E2E_CustomerOnboardingControllerTest {

    @IsTest
    static void onboardSuccess(){
        
        CustomerOnboardingRequest req = new CustomerOnboardingRequest();
        req.account = new CustomerOnboardingRequest.Account();
        req.account.name = 'test';
        req.account.countryCode = 'NZ';
        req.account.website = 'http://test.com';

        req.contact = new CustomerOnboardingRequest.Contact();
        req.contact.firstName = 'test';
        req.contact.lastName = 'test';
        req.contact.email = 'test@test.com';
        
        Test.startTest();
        CustomerOnboardingResult res = CustomerOnboardingController.onboard(JSON.serialize(req));
        Test.stopTest();

        Assert.isNotNull(res.accountId);
        Assert.isNotNull(res.contactId);
    }
}