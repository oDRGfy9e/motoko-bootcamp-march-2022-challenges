/* Motoko Bootcamp March 2022 Challenges
** Day 5 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_5/GUIDE.MD
*/

// This is the ATM canister: Feel free to withdraw and deposit Free cycles to your canister id!
// Money is sent to receiverCanister (--argument)
// set arg for principal (receiver) : 
// principal=$(dfx canister id receiver)
// dfx deploy --no-wallet atm --argument "(principal \"$principal\")"
// dfx deploy receiver
// dfx canister call atm withdraw_cycles "(100_900_000)"


import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Result "mo:base/Result";

shared ({ caller = creator }) actor class MyCanister (receiverCanister : Principal) = {

    public func balance() : async Nat {
        return(Cycles.balance());
    };

    public shared ({caller}) func withdraw_cycles(n : Nat ) : async Text {
        let user : actor { deposit_cycles : () -> async Nat; } = actor(Principal.toText(receiverCanister));
        Cycles.add(n);
        let deposit = await user.deposit_cycles();
        return ("Withdraw success, amount:" # Nat.toText(deposit) # " deposit to principal-id: " #Principal.toText(receiverCanister));
    };
};