/**
 * @author Heitor Araujo
 * @description Controller for Customer Onboarding LWC
 */
public with sharing class CustomerOnboardingController {

    @TestVisible
    private static CustomerOnboardingService service = new CustomerOnboardingService();

    @AuraEnabled
    public static CustomerOnboardingResult onboard(String requestJSON){
        try {
            CustomerOnboardingRequest request = (CustomerOnboardingRequest) JSON.deserialize(requestJSON, CustomerOnboardingRequest.class);
            CustomerOnboardingResult result = service.onboardNewCustomer(request);
            return result;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}