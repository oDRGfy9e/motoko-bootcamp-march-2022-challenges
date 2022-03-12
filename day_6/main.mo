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
import List "mo:base/List";

import HTTP "http";
import Text "mo:base/Text";
import Option "mo:base/Option";

shared ({ caller = creator }) actor class MyCanister() = {
    
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

    // Challenge 5
    public type List<TokenIndex> = ?(TokenIndex, List<TokenIndex>);
    
    public shared ({caller}) func balance() : async List<TokenIndex> {
        
        var listOfToken = List.nil<TokenIndex>();

        for((K,V) in registry.entries()) {
            if (caller == V) {
                listOfToken := List.push<TokenIndex>(K, listOfToken);
            };
        };

        return listOfToken;
    };

    // HTTP challenges
    // dfx canister call day_6 http_request '(record {"body"= blob "abc"; "headers"=vec{record{"field1";"field2"};record{"field3";"field4"}};"method"="method text";"url"="urlpath.com"})' 
    public query func http_request(request : HTTP.Request) : async HTTP.Response {
        let number = registry.size();
        let lastPrincipal = registry.get(number - 1); // Principal
        let lastPrincipalID = Option.get(lastPrincipal, Principal.fromText("2vxsx-fae"));
        let response = {
            //body = Text.encodeUtf8("Hello world");
            body = Text.encodeUtf8("Number of NFT minted : " # Nat.toText(number) # "\n Principal of the latest minter: " # Principal.toText(lastPrincipalID) ) ;
            headers = [("Content-Type", "text/html; charset=UTF-8")];
            status_code = 200 : Nat16;
            streaming_strategy = null
        };
        return(response)
    };
    
};