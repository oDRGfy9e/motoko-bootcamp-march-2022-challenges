/* Motoko Bootcamp March 2022 Challenges
** Day 6 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_6/GUIDE.MD
*/

import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import Cycles "mo:base/ExperimentalCycles";

actor {
    
    // Challenge 1
    type TokenIndex = Nat;
    
    public type MintingErrors = {
        #Anonymous;
        #Balance;
        #Restricted;
    };

    // Challenge 2
    var registry = HashMap.HashMap<TokenIndex, Principal>(0, Nat.equal, Hash.hash);
    stable var entries : [(TokenIndex, Principal)] = [];

    system func preupgrade() {
        // Do something before upgrade
        entries := Iter.toArray(registry.entries());
    };

    system func postupgrade() {
        // Do something after upgrade
        registry := HashMap.fromIter<TokenIndex, Principal>(entries.vals(), 1, Nat.equal, Hash.hash);
        entries := [];
    };

    // Challenge 3
    stable var nextTokenIndex : Nat = 0;
    
    public shared ({caller}) func mint() : async Result.Result<(), Text> {
        if(Principal.isAnonymous(caller)) {
            return #err("You cannot mint as Anonymous");
        } else {
            registry.put(nextTokenIndex,caller);
            nextTokenIndex += 1;
            Debug.print(debug_show(nextTokenIndex));
            return #ok;
        };
    };

    // Challenge 4
    let price : Nat = 100_000;
    public shared ({caller}) func transfer(to : Principal, tokenIndex : Nat) : async Result.Result<Text, MintingErrors> {
        if(Principal.isAnonymous(caller)) {
            return #err(#Anonymous);
        } else {
            let cycles = Cycles.available();
            if(cycles < price) {
                return #err(#Balance);
            };            
        };
        //let r = favoriteNumber.replace(caller,n);
        let r = registry.replace(tokenIndex, to);
        return #ok("New Principal owner : " # Principal.toText(to));
    };

    // Moved to core project :( one day to go!
    
};