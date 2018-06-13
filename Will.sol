pragma solidity ^0.4.0;


contract Will {

    address[] public recipients;
    uint[] public percentages;
    address public testator;
    address public deathApprover;
    uint[] public amounts;

    modifier restricted() {
        require(msg.sender == testator);
        _;
    }


    constructor(address firstRecipient) public payable {
        testator = msg.sender;
        recipients.push(firstRecipient);
        percentages.push(100);
        amounts.push(address(this).balance);
    }

    function setExecutor(address executor) public restricted {
        deathApprover = executor;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getRecipients() public view returns(address[]) {
        return recipients;
    }

    function getPercentages() public view returns (uint[]) {
        return percentages;
    }

    function getAmounts() public view returns (uint[]) {
        return amounts;
    }

    function addRecipient(address newRecipient) public restricted {
        recipients.push(newRecipient);
        percentages.push(0);
        amounts.push(0);
    }

    function addFunds() public payable restricted {
    }
    //necessary?

    function adjustPercentages(uint[] newPercentages) public restricted {
        require(newPercentages.length == recipients.length);

        for(uint i = 0; i < newPercentages.length; i++ ) {
            percentages[i] = newPercentages[i];
            amounts[i] = (address(this).balance / 100) * newPercentages[i];
        }


    }
    //percentages are saved in an array in the same order as the recipients
    //array. To adjust any single percentage the creator must give the full
    //array of full percentages

    function executeWill() public {
        require(msg.sender == deathApprover);

        uint j = 0;
        for( j; j < recipients.length; j++) {
            recipients[j].transfer(amounts[j]);
        }

    }
    //transfers the designated amounts to the recipients, and can
    //only be executed by the designated deathApprover

    function cancelWill() public restricted {
        testator.transfer(address(this).balance);
    }
    //not sure if this function is necessary as this would give the testator
    //incentive to cancel




}
