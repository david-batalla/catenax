// SPDX-License-Identifier: MIT
// Contributors: 
pragma solidity >=0.8.2 <0.9.0;
import "@openzeppelin/contracts/utils/Strings.sol";


library CatenaXDefinition{
    using Strings for string;
    enum ContractStatus {
        DEPRECATED,
        LIVE
    }

    enum VC_STATUS{
        ACTIVE,REVOKED
    }

    enum CURRENT_STATUS {
        
        BLOCKED,INUSE
    }


    enum REQUEST_STATUS{
        REQUESTED,APPROVED
    }

     //normal participants
    struct Participant {
        string bpn;
        string name;
        uint8 flag; //1 is existing
        address maker;
        address checker;
        CURRENT_STATUS currentStatus;
        REQUEST_STATUS requestStatus;
    }

    //admins
    struct CatenaX {
        string bpn;
        uint8 flag; //1 is existing
        address maker;
        address checker;
        CURRENT_STATUS currentStatus;
        REQUEST_STATUS requestStatus;
    }

    struct DID {
        string document;
        string bpn;
        address [] controllers;
    }

    struct VC {
        string vcdoc; //hash or not
        address createdBy;
        VC_STATUS credentialStatus;
    }

    struct ContractControl{
        uint version;
        address maker;
        address checker;
        CURRENT_STATUS currentStatus;
        REQUEST_STATUS requestStatus;
        ContractStatus status;
    }

    function substring(
        string memory str,
        uint256 startIndex,
        uint256 endIndex
    ) public pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }

    function stringToNumber(string memory _toBeConverted)
        private
        pure
        returns (uint256)
    {
        uint256 toBeReturn = 0;

        bytes memory strBytes = bytes(_toBeConverted);
        for (uint256 i = 0; i < strBytes.length; i++) {
            uint256 exp = strBytes.length - i;
            bytes1 ival = strBytes[i];
            uint8 uval = uint8(ival);
            uint256 jval = uval - uint256(0x30);

            toBeReturn += (uint256(jval) * (10**(exp - 1)));
        }
        return toBeReturn + 1;
    }

    function getLength(string memory _string) private pure returns (uint256) {
        bytes memory b = bytes(_string);
        return b.length;
    }

    function concatenate(string memory s1,string memory s2) private pure returns (string memory){
       return string(abi.encodePacked(s1,s2));
   }

    function generateNewBPN(string calldata _bpn)
        public
        pure
        returns (string memory)
    {
      
        require(getLength(_bpn) <= 16,concatenate(CatenaXErrorDefinition.ERRIN," MAXIMUM BPN HAVE BEEN REACHED."));
        uint256 maxLength = 13;
        string memory temp = substring(_bpn, 3, getLength(_bpn));
     
        uint256 cntNum = stringToNumber(temp);
   

        string memory newVal = Strings.toString(cntNum);

        uint256 len = getLength(newVal);

        for (uint256 i = len; i < maxLength; i++) {
            newVal = concatenate("0", newVal);
        }

        return concatenate("BPN",newVal);
    }

}




library CatenaXErrorDefinition{

    string constant DEPRECATED = "DEPRECATED SMART CONTRACT";
    string constant UNAUTH = "UNAUTHORIZED";
    string constant DUPLICATE = "DUPLICATE VALUE DETECTED";
    string constant CHECKERISMAKER = "CHECKER SHOULD NOT BE THE SAME AS SENDER";
    string constant NOTADD = "NOT A VALID ADDRESS";
    string constant NOTFOUND = "NO BPN/ADDRESS/DID/VC FOUND";
    string constant ERRBPN = "BPN MUST BE VALID";
    string constant ERRLEN32 = "DATA LENGTH GREATER THAN 32!";
    string constant ERRLEN0 = "DATA CANNOt BE EMPTY";
    string constant ONLYADMIN = "THIS ADDRESS/BPN IS USED BY ADMIN";
    string constant ERRAPPROVAL = "ONLY DATA WITH 'REQUESTED' STATUS CAN BE APPROVE";
    string constant INVALID ="BPN IS INVALID";
    string constant ERRIN = "INPUT ERROR";
    string constant OBJSTATE = "CURRENT OBJECT STATE IS INVALID";

}

