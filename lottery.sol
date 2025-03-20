pragma solidity ^0.8.0;

contract BasicLottery {
    address[] public players;
    address public winner;

    // Function to enter the lottery
    function enterLottery() public payable {
        require(msg.value == 0.01 ether, "Entry fee is 0.01 ETH");
        players.push(msg.sender);
    }

    // Function to generate a pseudo-random number (not secure for production)
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players)));
    }

    // Function to pick a winner
    function pickWinner() public {
        require(players.length > 0, "No players in the lottery");
        uint index = random() % players.length;
        winner = players[index];

        // Transfer contract balance to the winner
        payable(winner).transfer(address(this).balance);

        // Reset the lottery for the next round
        delete players;
    }

    // Function to view the current contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Function to view the list of players
    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}
