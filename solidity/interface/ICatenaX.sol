// SPDX-License-Identifier: MIT
// Contributors: 
pragma solidity >=0.8.2 <0.9.0;
import "./CatenaXConstantDefinition.sol";

interface ICatenaXRegistry {
    function registerOPCO(address _addressToAdd) external returns (bool);

    function approveOPCO(address _addressToApprove) external returns (bool);

    function deactivateOPCO(address _toBeDeleted) external returns (bool);

    function approveDeactivateOPCO(
        address _toBeDeleted
    ) external returns (bool);

    function registerParticipant(
        string calldata _name
    ) external returns (bool);

    function approveParticipant(string calldata _bpn) external returns (bool);

    function deactivateParticipant(
        string calldata _bpn
    ) external returns (bool);

    function approveDeactivateParticipant(
        string calldata _bpn
    ) external returns (bool);

    function registerIssuer(
        string calldata _bpn,
        address _issuer
    ) external returns (bool);

    function approveIssuer(
        string calldata _bpn,
        address _issuer
    ) external returns (bool);

    function deactivateIssuer(address _issuer) external returns (bool);

    function approveDeactivateIssuer(address _issuer) external returns (bool);

    function OPCOExist(address _address) external view returns (bool);

    function issuerExist(address _address) external view returns (bool);

    function bpnExist(string calldata _bpn) external view returns (bool);

    function getParticipantInfo(
        string calldata _participantBPN
    ) external view returns (CatenaXDefinition.Participant memory);

    function getIssuerInfo(
        address _issuer
    ) external view returns (CatenaXDefinition.Participant memory);
}

interface ICatenaXVerifiedCredentials {
    function registerVC(
        string calldata _vcId,
        string calldata _vcDoc
    ) external returns (bool);

    function findVC(
        string calldata _vcId,
        string calldata _did
    ) external returns (CatenaXDefinition.VC memory);
}

interface ICatenaXDID {
    function registerDIDbyAdmin(
        string calldata _did,
        string calldata _document,
        string calldata _bpn,
        address[] calldata _didControllers
    ) external returns (bool DID_REGISTERED);

    function registerDIDbySelf(
        string calldata _did,
        string calldata _document,
        string calldata _bpn,
        address[] calldata _didControllers
    ) external returns (bool DID_REGISTERED);

    function getDIDInfo(
        string calldata _did
    ) external view returns (CatenaXDefinition.DID memory);
}
