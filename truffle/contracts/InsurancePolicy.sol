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
        if (msg.value != 100) revert();
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

        if (userPolicy.nextPaymentTimestamp == 0) revert();

        if (now > userPolicy.endPolicy) revert();
        
        Payment(msg.value);

        userPolicy.currentBill = userPolicy.currentBill - msg.value;

        if (userPolicy.currentBill <= 0 && userPolicy.nextPaymentTimestamp != userPolicy.endPolicy){
            userPolicy.nextPaymentTimestamp = userPolicy.nextPaymentTimestamp + 30 days;
            userPolicy.currentBill = userPolicy.monthlyPremium; 
        }
        
        if (userPolicy.nextPaymentTimestamp >= userPolicy.endPolicy){
            userPolicy.nextPaymentTimestamp = userPolicy.endPolicy;
        }

        totalAmountInvested = totalAmountInvested + msg.value;
    }

    function claim() payable {
        var userPolicy = insurancePolicies[msg.sender];

        if (userPolicy.nextPaymentTimestamp == 0) revert();

        if (now > userPolicy.endPolicy) revert();

        if (now > userPolicy.nextPaymentTimestamp) revert();
        
        msg.sender.transfer(500);

        Claimed(500);

        userPolicy.totalClaims = userPolicy.totalClaims + 1;
        userPolicy.totalClaimsPayout = userPolicy.totalClaimsPayout + 500;
        userPolicy.currentBill = userPolicy.currentBill + 50;
        userPolicy.monthlyPremium = 150;

        totalClaims = totalClaims + 1;
        totalClaimsPayout = totalClaimsPayout + 500;

    }

    // funcs to grab Insurance Policy Info

    function getAllInsurancePolicies() {     
        // fix
    }

    function getTotalInsurancePolicies() constant returns (uint) {
        return totalInsurancePolicies;
    }

    function getTotalAmountInvested() constant returns (uint) {
        return totalAmountInvested;
    }
    
    function getTotalClaims() constant returns (uint) {
        return totalClaims;
    }

    function getTotalClaimsPayout() constant returns (uint){
        return totalClaimsPayout;
    }

    // func to grab individuals policy info

    function getCurrentPolicy() constant returns (uint, uint, uint, uint, uint, uint, uint) {        
        var userPolicy = insurancePolicies[msg.sender]; 
        return (userPolicy.startPolicy, userPolicy.endPolicy, userPolicy.nextPaymentTimestamp, userPolicy.currentBill, userPolicy.monthlyPremium, userPolicy.totalClaims, userPolicy.totalClaimsPayout );
    }

    function getStartPolicyDate() constant returns (uint) {
        var userPolicy = insurancePolicies[msg.sender];
        return userPolicy.startPolicy;
    }

    function getPolicyEndDate() constant returns (uint) {
        var userPolicy = insurancePolicies[msg.sender];
        return userPolicy.endPolicy;
    }

    function getNextPaymentDate() constant returns (uint) {
        var userPolicy = insurancePolicies[msg.sender];
        return userPolicy.nextPaymentTimestamp;
    }

    function getCurrentBill() constant returns (uint) {
        var userPolicy = insurancePolicies[msg.sender];
        return userPolicy.currentBill;
    }

    function getMonthlyPremium() constant returns (uint) {
        var userPolicy = insurancePolicies[msg.sender];
        return userPolicy.monthlyPremium;
    }

    function getUserTotalClaims() constant returns (uint) {
        var userPolicy = insurancePolicies[msg.sender];
        return userPolicy.totalClaims;
    }

    function getUserTotalClaimsPayout() constant returns (uint) {
        var userPolicy = insurancePolicies[msg.sender];
        return userPolicy.totalClaimsPayout;
    }

}

