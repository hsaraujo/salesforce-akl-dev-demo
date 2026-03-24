public with sharing class CustomerOnboardingRequest {

    @AuraEnabled
    public CustomerOnboardingRequest.Account account;

    @AuraEnabled
    public CustomerOnboardingRequest.Contact contact;
    

    public CustomerOnboardingRequest(){
        this(null, null);
    }

    public CustomerOnboardingRequest(CustomerOnboardingRequest.Account account, CustomerOnboardingRequest.Contact contact){
        this.account = account;
        this.contact = contact;
    }

    public class Account {

        public Account(){
            this(null, null, null);
        }

        public Account(String name, String countryCode, String website){
            this.name = name;
            this.countryCode = countryCode;
            this.website = website;
        }

        @AuraEnabled
        public String name;

        @AuraEnabled
        public String countryCode;

        @AuraEnabled
        public String website;
    }

    public class Contact {

        public Contact(){
            this(null, null, null);
        }

        public Contact(String firstName, String lastName, String email){
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
        }

        @AuraEnabled
        public String firstName;

        @AuraEnabled
        public String lastName;

        @AuraEnabled
        public String email;
    }
}