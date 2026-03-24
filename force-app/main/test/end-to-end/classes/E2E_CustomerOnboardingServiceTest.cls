@IsTest
private class E2E_CustomerOnboardingServiceTest {

    @IsTest
    static void onboardNewCustomerSuccess(){

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
        CustomerOnboardingResult res = new CustomerOnboardingService().onboardNewCustomer(req);
        Test.stopTest();

        Assert.isNotNull(res.accountId);
        Assert.isNotNull(res.contactId);
    }

    @IsTest
    static void onboardNewCustomerError(){

        CustomerOnboardingRequest req = new CustomerOnboardingRequest();
        req.account = new CustomerOnboardingRequest.Account();
        req.account.name = 'test';
        req.account.countryCode = 'NZ';
        req.account.website = 'http://test.com';

        req.contact = new CustomerOnboardingRequest.Contact();
        req.contact.firstName = 'test';
        req.contact.lastName = 'test';
        req.contact.email = 'very_long_string_ttttttttestttttt_very_long_string_ttttttttestttttttttt@testtttt.com';
        
        Test.startTest();
        Exception resultException;
        try{
            CustomerOnboardingResult res = new CustomerOnboardingService().onboardNewCustomer(req);
        }catch(Exception e){
            resultException = e;
        }
        Test.stopTest();

        Assert.isNotNull(resultException);
    }
}