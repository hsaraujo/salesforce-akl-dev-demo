@IsTest
private class CustomerMapperTest {

    @IsTest
    static void mapToAccountTest(){

        CustomerOnboardingRequest.Account accountRequest = new CustomerOnboardingRequest.Account();
        accountRequest.name = 'test';
        accountRequest.countryCode = 'NZ';
        accountRequest.website = 'http://test.com';

        Test.startTest();

        Account result = new CustomerMapper().mapToAccount(accountRequest);

        Test.stopTest();

        Assert.areEqual('test', result.Name);
        Assert.areEqual('http://test.com', result.Website);
        Assert.areEqual('New Zealand', result.BillingCountry);
    }

    @IsTest
    static void mapToContactTest(){

        CustomerOnboardingRequest.Contact contactRequest = new CustomerOnboardingRequest.Contact();
        contactRequest.firstName = 'first';
        contactRequest.lastName = 'last';
        contactRequest.email = 'test@test.com';

        Id fakeAccountId = FakeIdGenerator.generate(Account.SObjectType);

        Test.startTest();

        Contact result = new CustomerMapper().mapToContact(contactRequest, fakeAccountId);

        Test.stopTest();

        Assert.areEqual('first', result.FirstName);
        Assert.areEqual('last', result.LastName);
        Assert.areEqual('test@test.com', result.Email);
        Assert.areEqual(fakeAccountId, result.AccountId);
    }
}