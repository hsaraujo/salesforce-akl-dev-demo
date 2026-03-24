import { LightningElement, track } from 'lwc';
import onboard from '@salesforce/apex/CustomerOnboardingController.onboard';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class AccountOnboarding extends NavigationMixin(LightningElement) {
    companyName = '';
    countryCode = 'NZ';
    website = '';

    contactFirstName = '';
    contactLastName = '';
    contactEmail = '';

    isLoading = false;
    @track result;

    countryOptions = [
        { label: 'New Zealand', value: 'NZ' },
        { label: 'Australia', value: 'AU' },
        { label: 'Other', value: 'OT' }
    ];

    get disableSubmit() {
        return this.isLoading
            || !this.companyName?.trim()
            || !this.countryCode
            || !this.contactLastName?.trim();
    }

    get hasMessages() {
        return this.result?.messages && this.result.messages.length > 0;
    }

    get statusClass() {
        const s = this.result?.status;
        if (s === 'CREATED') return 'status created';
        if (s === 'DUPLICATE') return 'status duplicate';
        if (s === 'REJECTED') return 'status rejected';
        return 'status';
    }

    handleCompanyName(e) { this.companyName = e.detail.value; }
    handleCountryCode(e) { this.countryCode = e.detail.value; }
    handleWebsite(e) { this.website = e.detail.value; }

    handleContactFirstName(e) { this.contactFirstName = e.detail.value; }
    handleContactLastName(e) { this.contactLastName = e.detail.value; }
    handleContactEmail(e) { this.contactEmail = e.detail.value; }

    handleReset() {
        this.companyName = '';
        this.countryCode = 'NZ';
        this.website = '';

        this.contactFirstName = '';
        this.contactLastName = '';
        this.contactEmail = '';

        this.result = null;
    }

    async handleOnboard() {
        this.isLoading = true;
        this.result = null;

        try {

            let requestObj = {
                account: {
                    name: this.companyName,
                    countryCode: this.countryCode,
                    website: this.website
                },
                contact: {
                    firstName: this.contactFirstName,
                    lastName: this.contactLastName,
                    email: this.contactEmail,
                }
            }
            
            const res = await onboard({ 
                requestJSON: JSON.stringify(requestObj)
            });

            this.result = res;

            this.dispatchEvent(new ShowToastEvent({ title: 'Created', message: 'Customer onboarded', variant: 'success' }));
        } catch (err) {
            const msg = this.reduceError(err);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: msg,
                variant: 'error'
            }));
        } finally {
            this.isLoading = false;
        }
    }

    navigateToAccount() {
        if (!this.result?.accountId) return;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.result.accountId,
                objectApiName: 'Account',
                actionName: 'view'
            }
        });
    }

    reduceError(err) {
        
        if (!err) {
            return 'Unknown error';
        }

        // UI API / Apex can return an array of errors
        if (Array.isArray(err.body)) {
            return err.body
                .map(e => e && e.message)
                .filter(Boolean)
                .join(', ');
        }

        // Page-level errors (UI API / LDS)
        const pageErrors = err.body?.output?.errors;
        if (Array.isArray(pageErrors) && pageErrors.length) {
            return pageErrors
                .map(e => e && e.message)
                .filter(Boolean)
                .join(', ');
        }

        // Field-level errors (UI API / LDS)
        const fieldErrors = err.body?.output?.fieldErrors;
        if (fieldErrors && typeof fieldErrors === 'object') {
            const messages = [];
            Object.keys(fieldErrors).forEach(fieldName => {
                const errs = fieldErrors[fieldName];
                if (Array.isArray(errs)) {
                    errs.forEach(e => {
                        if (e?.message) messages.push(e.message);
                    });
                }
            });
            if (messages.length) return messages.join(', ');
        }

        // Apex / AuraHandledException single message
        if (err.body?.message) {
            return err.body.message;
        }

        // JS error message
        if (err.message) {
            return err.message;
        }

        return 'Unknown error';
    }
}