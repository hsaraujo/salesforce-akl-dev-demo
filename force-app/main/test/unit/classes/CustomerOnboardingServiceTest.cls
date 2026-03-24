@IsTest
private class CustomerOnboardingServiceTest {

    @IsTest
    static void onboardNewCustomerSuccess(){

        Mock dmlMock = Mock.forType(DmlOperations.class);
        DmlOperations dmlStub = (DmlOperations) dmlMock.stub;
        MethodSpy createSpy = dmlMock.spyOn('create');

        createSpy
            .whenCalledWith(Argument.ofType(Account.getSObjectType()))
            .thenReturn(
                new Account(Id = FakeIdGenerator.generate(Account.SObjectType))
            );

        createSpy
            .whenCalledWith(Argument.ofType(Contact.getSObjectType()))
            .thenReturn(
                new Contact(Id = FakeIdGenerator.generate(Contact.SObjectType))
            );

        Test.startTest();
            
            CustomerOnboardingService service = new CustomerOnboardingService();
            service.dmlOperations = dmlStub;

            CustomerOnboardingRequest req = new CustomerOnboardingRequest();
            req.account = new CustomerOnboardingRequest.Account();
            req.account.name = 'Some Name';
            req.account.countryCode = 'NZ';
            req.account.website = 'http://test.com';
            req.contact = new CustomerOnboardingRequest.Contact();
            req.contact.firstName = 'Some';
            req.contact.lastName = 'Name';
            req.contact.email = 'test@test.com';

            CustomerOnboardingResult result = service.onboardNewCustomer(req);

        Test.stopTest();

        Expect.that(createSpy).hasBeenCalledTimes(2);
        Assert.isNotNull(result.accountId);
        Assert.isNotNull(result.contactId);
    }

    @IsTest
    static void onboardNewCustomerError(){

        Mock dmlMock = Mock.forType(DmlOperations.class);
        DmlOperations dmlStub = (DmlOperations) dmlMock.stub;
        MethodSpy createSpy = dmlMock.spyOn('create');

        createSpy
            .whenCalledWith(Argument.ofType(Account.getSObjectType()))
            .thenReturn(
                new Account(Id = FakeIdGenerator.generate(Account.SObjectType))
            );

        createSpy
            .whenCalledWith(Argument.ofType(Contact.getSObjectType()))
            .thenThrow(new DmlException());

        Test.startTest();
            
            CustomerOnboardingService service = new CustomerOnboardingService();
            service.dmlOperations = dmlStub;

            CustomerOnboardingRequest req = new CustomerOnboardingRequest();
            req.account = new CustomerOnboardingRequest.Account();
            req.account.name = 'Some Name';
            req.account.countryCode = 'NZ';
            req.account.website = 'http://test.com';
            req.contact = new CustomerOnboardingRequest.Contact();
            req.contact.firstName = 'Some';
            req.contact.lastName = 'Name';
            req.contact.email = 'test@test.com';

            Exception exceptedException;
            try{
                CustomerOnboardingResult result = service.onboardNewCustomer(req);
            } catch (Exception e){
                exceptedException = e;
            }

        Test.stopTest();

        Expect.that(createSpy).hasBeenCalledTimes(2);
        Assert.isNotNull(exceptedException);
    }

    @IsTest
    static void validateTest(){

        CustomerOnboardingService service = new CustomerOnboardingService();

        CustomerOnboardingRequest req = new CustomerOnboardingRequest();

        Exception validateException;
        try{
            service.validate(req);
        }catch(Exception e){
            validateException = e;
        }
        Assert.isNotNull(validateException);

        req.account = new CustomerOnboardingRequest.Account();
        req.account.name = 'Company Name';
        try{
            validateException = null;
            service.validate(req);
        }catch(Exception e){
            validateException = e;
        }
        Assert.isNotNull(validateException);

        
        req.account.countryCode = 'NZ';
        req.account.website = 'http://superlongstring_superlongstring_superlongstring_superlongstring_superlongstring_superlongstring_superlongstring_superlongstrin_superlongstring_superlongstring_superlongstring_superlongstring_superlongstring_superlongstring_superlongstring_superlongstring.com';
        try{
            validateException = null;
            service.validate(req);
        }catch(Exception e){
            validateException = e;
        }
        Assert.isNotNull(validateException);

        req.account.website = 'http://test.com';
        try{
            validateException = null;
            service.validate(req);
        }catch(Exception e){
            validateException = e;
        }
        Assert.isNull(validateException);
    }
}