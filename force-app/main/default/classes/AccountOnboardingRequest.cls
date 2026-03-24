public with sharing class AccountOnboardingRequest {

    @AuraEnabled
    public String name;

    @AuraEnabled
    public String countryCode;

    @AuraEnabled
    public String website;

    public AccountOnboardingRequest(){
        this(null, null, null);
    }

    public AccountOnboardingRequest(String name, String countryCode, String website){
        this.name = name;
        this.countryCode = countryCode;
        this.website = website;
    }
}