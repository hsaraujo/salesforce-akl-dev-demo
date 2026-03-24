/**
 * @author Heitor Araujo
 * @description Controller for Account Onboarding LWC
 */
public with sharing class AccountOnboardingController {

    @TestVisible
    private static AccountOnboardingService service = new AccountOnboardingService();

    @AuraEnabled
    public static Account onboard(String name, String countryCode, String website){
        try {
            AccountOnboardingRequest request = new AccountOnboardingRequest(name, countryCode, website);
            return service.onboardNewCustomer(request);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}