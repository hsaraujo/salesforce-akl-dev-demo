public with sharing class CustomerOnboardingResult {

    @AuraEnabled
    public Id accountId;

    @AuraEnabled
    public Id contactId;

    public CustomerOnboardingResult(){
        this(null, null);
    }

    public CustomerOnboardingResult(Id accountId, Id contactId){
        this.accountId = accountId;
        this.contactId = contactId;
    }
}