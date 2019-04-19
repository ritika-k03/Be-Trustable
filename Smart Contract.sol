pragma solidity ^0.4.18;

contract betrustable {

    uint id=0;

    struct company {
        uint c_id;
        string name;
        uint no_of_donations;
    }

    struct reciever {
        uint r_id;
        string name;
        string department;
        address add;
        uint no_of_recieved;
    }

    struct donation {
        uint d_id;
        address sender;
        address reciever;
        uint amount;
        bool approval;
    }

    mapping (uint => company) companymapping;
    mapping (uint => reciever) recievermapping;
    mapping (uint => uint) tokenbalance;
    mapping (uint => donation) donationmapping;
    mapping (address => company) addresscompany;

    function get_next_id() public {
        id++;
    }

    function register_company(uint cid, string _name) public {
        companymapping[cid]=company(cid,_name,0);
        addresscompany[msg.sender] = company(cid,_name,0);
    }

     function register_reciever(uint rid, string _name,string _department) public {
        recievermapping[rid]=reciever(rid,_name,_department,msg.sender,0);
    }

    function add_donation(uint _reciever) public payable {
        get_next_id();
        donationmapping[id]=donation(id,msg.sender,recievermapping[_reciever].add,msg.value,false);
    }

    function approve_donation(uint did) public {
        donationmapping[did].approval=true;
        address com = donationmapping[did].sender;
        tokenbalance[addresscompany[com].c_id]+=donationmapping[did].amount;

    }

    function view_tokens(uint cid_)public view returns(uint) {
        return tokenbalance[cid_];
    }

    function getid() public view returns(uint){
        return id;
    }


}
