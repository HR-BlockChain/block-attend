pragma solidity ^0.4.10;

contract InsurancePolicy {

    uint public totalInsurancePolicies;
    uint public totalAmountInvested;
    uint public totalClaims;
    uint public totalClaimsPayout; 
    uint public basePremium;
    uint public maxPayout;

    mapping (address => PolicyData) public insurancePolicies;

    event Payment(uint payment);
    event Claimed(uint claim);

    struct PolicyData {
        uint startPolicy;
        uint endPolicy;
        uint nextPaymentTimestamp;
        uint currentBill;
        uint monthlyPremium;
        uint totalClaims;
        uint totalClaimsPayout; 
    }

    function setPolicy() payable {
        if (msg.value != 100) throw;
        var policy = PolicyData( now , now + 1 years, now + 30 days, 0, msg.value, 0 , 0 );

        Payment(msg.value);

        insurancePolicies[msg.sender] = policy;

        totalInsurancePolicies = totalInsurancePolicies + 1;
        totalAmountInvested = totalAmountInvested + msg.value;
        basePremium = 100;
        maxPayout = 500;
    }

    function payPremium() payable {
        
        var userPolicy = insurancePolicies[msg.sender];

        Payment(msg.value);

        userPolicy.currentBill = userPolicy.currentBill - msg.value;

        if (userPolicy.currentBill <= 0){
            userPolicy.nextPaymentTimestamp = userPolicy.nextPaymentTimestamp + 30 days;
            userPolicy.currentBill = userPolicy.monthlyPremium + userPolicy.currentBill;
        }

        totalAmountInvested = totalAmountInvested + msg.value;
    }

    function claim() {
        var userPolicy = insurancePolicies[msg.sender];

        if (userPolicy.nextPaymentTimestamp < now) throw;
        
        msg.sender.transfer(500);

        Claimed(500);

        userPolicy.totalClaims = userPolicy.totalClaims + 1;
        userPolicy.totalClaimsPayout = userPolicy.totalClaimsPayout + 500;
        userPolicy.currentBill = userPolicy.currentBill + 50;
        userPolicy.monthlyPremium = 150;

        totalClaims = totalClaims + 1;
        totalClaimsPayout = totalClaimsPayout + 500;

    }

}