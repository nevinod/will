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

    function adjustPercentages(uint[] newPercentages) public restricted {
        require(newPercentages.length == recipients.length);

        for(uint i = 0; i < newPercentages.length; i++ ) {
            percentages[i] = newPercentages[i];
            amounts[i] = (address(this).balance / 100) * newPercentages[i];
        }


    }

    function executeWill() public {
        require(msg.sender == deathApprover);

        uint j = 0;
        for( j; j < recipients.length; j++) {
            recipients[j].transfer(amounts[j]);
        }

    }






}
