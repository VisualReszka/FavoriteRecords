// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/FavoriteRecords.sol";

contract FavoriteRecordsScript {
    FavoriteRecords favoriteRecords;

    function deploy() public {
        favoriteRecords = new FavoriteRecords();
        // Additional interaction logic can be added here
    }

    function addFavorite(string memory albumName) public {
        favoriteRecords.addRecord(albumName);
    }

    function getFavorites(address user) public view returns (string[] memory) {
        return favoriteRecords.getUserFavorites(user);
    }

    function resetFavorites() public {
        favoriteRecords.resetUserFavorites();
    }
}

