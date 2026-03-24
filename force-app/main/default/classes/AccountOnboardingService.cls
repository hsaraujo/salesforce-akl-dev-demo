public class AccountOnboardingService {
    
    @TestVisible
    private final AccountRepository repository = new AccountRepository();

    @TestVisible
    private final AccountMapper mapper = new AccountMapper();

    public Account onboardNewCustomer(AccountOnboardingRequest req) {
        validate(req);

        Account acc = mapper.mapToAccount(req);

        acc = repository.create(acc);

        return acc;
    }

    private void validate(AccountOnboardingRequest req) {
        if (req == null) {
            throw new OnboardingException('Request is required.');
        }
        if (String.isBlank(req.name)) {
            throw new OnboardingException('Company Name is required.');
        }
        if (String.isBlank(req.countryCode)) {
            throw new OnboardingException('Country is required.');
        }
        if (req.website != null && req.website.length() > 255) {
            throw new OnboardingException('Website is too long.');
        }
    }

}