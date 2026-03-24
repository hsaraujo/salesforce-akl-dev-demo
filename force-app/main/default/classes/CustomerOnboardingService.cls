public class CustomerOnboardingService {
    
    @TestVisible
    private final DmlOperations dmlOperations = new DmlOperations();

    @TestVisible
    private final CustomerMapper mapper = new CustomerMapper();

    public CustomerOnboardingResult onboardNewCustomer(CustomerOnboardingRequest req) {
        validate(req);
        Account acc = mapper.mapToAccount(req.account);
        acc = (Account) dmlOperations.create(acc);
        Contact con = mapper.mapToContact(req.contact, acc.Id);
        con = (Contact) dmlOperations.create(con);
        
        CustomerOnboardingResult result = new CustomerOnboardingResult(acc.Id, con.Id);
        return result;
    }

    private void validate(CustomerOnboardingRequest req) {
        if (req == null) {
            throw new OnboardingException('Request is required.');
        }
        if (String.isBlank(req.account?.name)) {
            throw new OnboardingException('Company Name is required.');
        }
        if (String.isBlank(req.account?.countryCode)) {
            throw new OnboardingException('Country is required.');
        }
        if (req.account?.website?.length() > 255) {
            throw new OnboardingException('Website is too long.');
        }
    }
}