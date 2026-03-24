public with sharing class CustomerMapper {

    public Account mapToAccount(CustomerOnboardingRequest.Account accountRequest){
        return new Account(
            Name = accountRequest.name,
            BillingCountry = getCountry(accountRequest.countryCode),
            Website = accountRequest.website
        );
    }

    public Contact mapToContact(CustomerOnboardingRequest.Contact contactRequest, Id accountId){
        return new Contact(
            FirstName = contactRequest.firstName,
            LastName = contactRequest.lastName,
            Email = contactRequest.email,
            Id = accountId
        );
    }

    private String getCountry(String countryCode){
        switch on countryCode?.toUpperCase() {
            when 'AU' {
                return 'Australia';
            }
            when 'NZ' {
                return 'New Zealand';
            }
            when else {
                return 'Other';
            }
        }
    }
}