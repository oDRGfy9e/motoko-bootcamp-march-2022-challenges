/* Motoko Bootcamp March 2022 Challenges
** Day 5 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_5/GUIDE.MD
*/

import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";

actor {

    public shared({caller}) func whoami() : async Principal {
        return(caller);
    };

    // Challenge 1
    // function is_anonymous takes no arguments but returns true is the caller is anonymous and false otherwise.
    public shared ({caller}) func is_anonymous() : async Bool {
        let principal_caller : Text = Principal.toText(caller);
        switch(principal_caller) {
            case("2vxsx-fae") {
                return true;
            };
            case(_) {
                return false;
            };
        };
    };

    // Alternative
    // https://github.com/dfinity/motoko-base/blob/master/src/Principal.mo
    public shared ({caller}) func is_anonymous_2() : async Bool {
        Principal.isAnonymous(caller);
    };

    // Challenge 2
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

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

    // Delete favorite number only if exist, else invite user to Add first
    public shared ({caller}) func delete_favorite_number() : async Result.Result<Text, Text> {
        switch(favoriteNumber.get(caller)) {
            case(null) {
                return #err("You do not have favorite number to delete");
            };
            case(_) {
                let r = favoriteNumber.remove(caller);
                return #ok("Your favorite number has been deleted");
            };
        }; 
    };

    // Challenge 8
    // function increment_counter returns the incremented value of counter by n.

    stable var versionNumber : Nat = 0;

    // function increment_counter returns the incremented value of counter by n.
    func _increment_counter(n : Nat) : () {
        versionNumber +=  n;
    };

    system func preupgrade() {
        Debug.print("Current upgrade ver: " # debug_show(versionNumber));
        // Do something before upgrade
    };

    system func postupgrade() {
        _increment_counter(1);
        Debug.print("Upgrade ver: " # debug_show(versionNumber));
        // Do something after upgrade
    };
};

