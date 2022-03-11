/* Motoko Bootcamp March 2022 Challenges
** Day 5 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_5/GUIDE.MD
*/

import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
import Iter "mo:base/Iter";


// Run some tests to confirm

actor {

   // Challenge 2
    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    stable var entries : [(Text, Nat)] = [];

    system func preupgrade() {
        entries := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        favoriteNumber := HashMap.fromIter<Text, Nat>(entries.vals(), 1, Text.equal, Text.hash);
        entries := [];
    };

    // Challenge 3
    // add_favorite_number takes n of type Nat and stores this value in the HashMap where the key is the principal of the caller.
    public shared ({caller}) func add_favorite_number(n : Nat) : async () {
        favoriteNumber.put(caller,n);
    };

    // show_favorite_number that takes no argument and returns n of type ?Nat, n is the favorite number of the person
    public shared ({caller}) func show_favorite_number() : async ?Nat {
        return(favoriteNumber.get(caller));
    };

    // Challenge 4
    // add_favorite_number: if the caller has already registered his favorite number, the value in memory isn't modified.
    public shared ({caller}) func add_favorite_number_2(n : Nat) : async Result.Result<Text, Text> {
        switch(favoriteNumber.get(caller)) {
            case(null) {
                favoriteNumber.put(caller,n);
                return #ok("Your favorite number has been added");
            };
            case(_) {
                return #err("You've already registered your number");
            };
        }; 
    };

    // Challenge 5
    // Update favorite number only if exist, else invite user to Add first
    public shared ({caller}) func update_favorite_number(n : Nat) : async Result.Result<Text, Text> {
        switch(favoriteNumber.get(caller)) {
            case(null) {
                return #err("You do not have favorite number to update. Try add_favorite_number_2 first");
            };
            case(_) {
                let r = favoriteNumber.replace(caller,n);
                return #ok("Your favorite number has been updated.");
            };
        }; 
    };
};