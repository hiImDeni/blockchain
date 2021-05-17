pragma solidity >=0.5.0 <0.6.0;

contract ChickenFarm {
  uint public price = 100 wei;
  address payable owner;


  function checkStatus() public pure returns (string memory) {
    return 'Farm is working';
  }

  mapping(uint => Chicken) chickens;
  uint public counter = 0;
  uint public soldCounter=0;

  struct Chicken {
    uint id;
    string name;
  } 

  function _setOwner() private {
      owner = msg.sender;
  }

  constructor() public {
      _setOwner();
  }

  function addChicken(string memory name) public {
    counter += 1;
    chickens[counter] = Chicken(counter, name);
  }

  function getChicken(uint id) public view returns (uint chickenId, string memory name) {
    return (chickens[id].id, chickens[id].name);
  }

  function getCounterAndSoldCounter() public view returns (uint chickenCounter, uint soldChickenCounter){
      return (counter,soldCounter);
  }

  function buyChicken() public payable {
      require(msg.value >= price);
      soldCounter++;
      require(soldCounter<=counter);
      owner.transfer(price);
      uint rest = msg.value - price;
      if (rest > 0) {
          msg.sender.transfer(rest);
      }
      delete chickens[soldCounter];
  }


}