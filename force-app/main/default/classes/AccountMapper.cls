public with sharing class AccountMapper {

    public Account mapToAccount(AccountOnboardingRequest req){
        return new Account(
            Name = req.name,
            BillingCountry = getCountry(req.countryCode),
            Website = req.website
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