/**
 * @author Heitor Araujo
 * @description Unit test class for CustomerOnboardingController
 */
@IsTest
private class CustomerOnboardingControllerTest {

    @IsTest
    static void onboardSuccess(){

        Mock serviceMock = Mock.forType(CustomerOnboardingService.class);
        CustomerOnboardingService serviceStub = (CustomerOnboardingService) serviceMock.stub;
        MethodSpy onboardSpy = serviceMock.spyOn('onboardNewCustomer');

        CustomerOnboardingResult mockedResult = new CustomerOnboardingResult(
            FakeIdGenerator.generate(Account.SObjectType),
            FakeIdGenerator.generate(Contact.SObjectType)
        );

        onboardSpy.returns(mockedResult);

        Test.startTest();
        CustomerOnboardingController.service = serviceStub;
        CustomerOnboardingResult res = CustomerOnboardingController.onboard('{"account": {}, "contact": {}}');
        Test.stopTest();

        Expect.that(onboardSpy).hasBeenCalled();
        Assert.isNotNull(res.accountId);
        Assert.isNotNull(res.contactId);
    }

    @IsTest
    static void onboardError(){

        Mock serviceMock = Mock.forType(CustomerOnboardingService.class);
        CustomerOnboardingService serviceStub = (CustomerOnboardingService) serviceMock.stub;
        MethodSpy onboardSpy = serviceMock.spyOn('onboardNewCustomer');
        onboardSpy.throwsException(new OnboardingException('Test'));

        CustomerOnboardingController.service = serviceStub;

        Test.startTest();
        Exception resultException;
        try{
            CustomerOnboardingResult res = CustomerOnboardingController.onboard('{"account": {}, "contact": {}}');
        }catch(Exception e){
            resultException = e;
        }
        Test.stopTest();

        Assert.isNotNull(resultException);
    }
}