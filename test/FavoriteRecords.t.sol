// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FavoriteRecords.sol";

contract FavoriteRecordsTest is Test {
    FavoriteRecords favoriteRecords;

    function setUp() public {
        favoriteRecords = new FavoriteRecords();
    }

    function testApprovedRecords() public view {
        string[] memory approved = favoriteRecords.getApprovedRecords();
        assertEq(approved.length, 9);
        assertTrue(favoriteRecords.approvedRecords("Thriller"));
        assertTrue(favoriteRecords.approvedRecords("Back in Black"));
    }

    function testAddRecord() public {
        favoriteRecords.addRecord("Thriller");
        string[] memory favorites = favoriteRecords.getUserFavorites(address(this));
        assertEq(favorites.length, 1);
        assertEq(favorites[0], "Thriller");
    }

    function testAddRecordNotApproved() public {
        vm.expectRevert(abi.encodeWithSelector(FavoriteRecords.NotApproved.selector, "Unknown Album"));
        favoriteRecords.addRecord("Unknown Album");
    }

    function testResetUserFavorites() public {
        favoriteRecords.addRecord("Thriller");
        favoriteRecords.resetUserFavorites();
        string[] memory favorites = favoriteRecords.getUserFavorites(address(this));
        assertEq(favorites.length, 0);
    }
}
