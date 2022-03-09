/* Motoko Bootcamp March 2022 Challenges
** Day 3 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_3/GUIDE.md
*/

import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Contains "Utils";

actor {

    // function swap takes 3 parameters : a mutable array , an index j and an index i 
    // and returns the same array but where value at index i and index j have been swapped.
    func _swap(a : [var Nat], i : Nat, j : Nat) : [var Nat] {
        
        let size : Nat = a.size();
        if (i > size or j > size)
            Debug.trap("index out of array size");

        var temp : Nat = a[i];
        a[i] := a[j];
        a[j] := temp;

        return a;
    };

    // function init_count takes a Nat n and returns an array [Nat] where value is equal to it's corresponding index.
    public func init_count(n : Nat) : async [Nat] {

        if (n == 0)
            return [];

        let result : [var Nat] = Array.init<Nat>(n, 0);
        var i : Nat = 0;
        while (i < result.size()) {
            result[i] := i;
            i += 1;
        };

        return Array.freeze(result);
    };

    // function init_count using .tabulate
    // https://smartcontracts.org/docs/base-libraries/Array.html#tabulate
    public func init_count_2(n : Nat) : async [Nat] {

        let result : [Nat] = Array.tabulate<Nat>(n, func _gen (i : Nat) : Nat {
                                                            return i;
                                                        }
                                                );
        
        return result;
    };

    // function seven takes an array [Nat] and returns "Seven is found" if one digit of ANY number is 7. 
    // Otherwise this function will return "Seven not found".
    public func seven(a : [Nat]) : async Text {

        let seven : Nat = 7;
        for (digit in Array.vals(a)) {
            Debug.print(debug_show(digit));
            if (digit == seven) {
                return "Seven is found";
            };
        };
        
        return "Seven not found";
    };

    // function nat_opt_to_nat takes two parameters : n of type ?Nat and m of type Nat . 
    // Returns the value of n if n is not null and if n is null it will default to the value of m.
    public func nat_opt_to_nat(n : ?Nat, m : Nat) : async Nat {
        switch(n) {
            case(null) {
                return m;
            };
            case (?something){
                return something;
            };
        };
    };

    // function day_of_the_week takes a Nat n and returns a Text value corresponding to the day. 
    // If n doesn't correspond to any day it will return null . 
    public func day_of_the_week(n : Nat) : async ?Text {
        
        let weekdays : [Text] = ["Mon","Tues","Wed","Thu","Fri","Sat","Sun"];

        if (n > 0 and n <= 7) {
            return ?weekdays[n-1];
        } else {
            return null;
        };
        
    };

    // function populate_array takes an array [?Nat] and returns an array [Nat] where all null values have been replaced by 0. 
    public func populate_array(a : [?Nat]) : async [Nat] {

        let _remove_null = func (n : ?Nat) : Nat {
            switch(n) {
                case(null){
                    return 0;
                };
                case(?something){
                    return something;
                }
            };
        };
        
        return(Array.map<?Nat,Nat>(a,_remove_null));
    };

    // function sum_of_array that takes an array [Nat] and returns the sum of a values in the array.
    public func sum_of_array(a : [Nat]) : async Nat {

        let _sum = func (n : Nat, m : Nat) : Nat {
            return n+m;
        };

        return(Array.foldRight<Nat,Nat>(a,0,_sum));
        
    };

    // function squared_array that takes an array [Nat] and returns a new array where each value has been squared.
    public func squared_array(a : [Nat]) : async [Nat] {

        let _squarred = func (n : Nat) : Nat {
            return n*n;
        };

        return(Array.map<Nat,Nat>(a, _squarred));
        
    };

    // function increase_by_index that takes an array [Nat] and returns a new array where each number has been increased by it's corresponding index.
    public func increase_by_index(a : [Nat]) : async [Nat] {

        var index : Nat = 0;

        let _sum_index = func (n : Nat) : Nat {
            var temp : Nat = index;
            index += 1;
            return(temp +n);
        };

        return(Array.map<Nat,Nat>(a, _sum_index));
    };

    // function contains<A> takes 3 parameters : an array [A] , a of type A and a function f that takes a tuple of type (A,A) and returns a boolean.
    func contains<A>(xs : [A], initial : A, f : (A,A) -> Bool): Bool {
        var a = initial;
        let size = xs.size();
        var i = size;
        while (i > 0) {
            i -= 1;
            if(f(xs[i],a))
                return true;
        };
        return false;
    };

    // Test function to call _private function with Candid UI (and canister call)
    public func test() : async (){
        
        var array : [var Nat] = [var 1, 4, 3, 2];

        Debug.print(debug_show(array));
        Debug.print(debug_show(_swap(array, 1, 3)));

        return;

    };

    public func test_contains(a : [Nat], n : Nat) : async Bool {
        let _contains = func (n : Nat, m : Nat) : Bool {
            if (n == m){
                return true;
            } else {
                return false;
            };
        };
        return(Contains.contains<Nat>(a,n,_contains));
    };

};