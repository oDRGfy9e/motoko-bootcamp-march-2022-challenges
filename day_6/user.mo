/* Motoko Bootcamp March 2022 Challenges
** Day 6 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_6/GUIDE.MD
*/

// User canister
// set arg for principal (day_6) : 
// dfx deploy day_6
// principal=$(dfx canister id day_6)
// dfx deploy --no-wallet day_6_user --argument "(principal \"$principal\")"
// dfx canister call atm withdraw_cycles "(100_900_000)"

import Cycles "mo:base/ExperimentalCycles";
import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";

shared ({ caller = creator }) actor class MyCanister (mainCanister : Principal) = {

    public shared ({ caller }) func callMint () : async Result.Result<(), Text> {
        let main : actor { mint : () -> async Result.Result<(), Text>; } = actor(Principal.toText(mainCanister));
        let minted = await main.mint();
        minted;
    };

};