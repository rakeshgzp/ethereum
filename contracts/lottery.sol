pragma solidity ^0.4.17;
contract lottery {
    address public manager;
    address[] public players;
    function lottery() public{
        manager = msg.sender;
    }
    function enter() public payable{
        require(msg.value >= 0 ether);
        players.push(msg.sender);
    }
    function random() private view returns(uint){
        return uint(keccak256(block.difficulty,now,players));
    }
    function result() public{
        require(manager == msg.sender);
        uint index = random()%players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }
}