/* Motoko Bootcamp March 2022 Challenges
** Day 5 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_5/GUIDE.MD
*/

// Receiver canister

import Cycles "mo:base/ExperimentalCycles";
import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";

shared ({ caller = creator }) actor class MyCanister () = {

    public func balance() : async Nat {
        return(Cycles.balance());
    };

    // deposit_cycles is called from the ATM canister
    public shared ({ caller }) func deposit_cycles () : async Nat {
        Debug.print("Current balance: " # Nat.toText(Cycles.balance()));
        let cycles = Cycles.available();
        return (Cycles.accept(cycles));
    };
};