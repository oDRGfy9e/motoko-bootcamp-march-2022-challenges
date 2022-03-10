/* Motoko Bootcamp March 2022 Challenges
** Day 4 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_4/GUIDE.MD
**
** Source:
** https://github.com/dfinity/motoko-base/blob/master/src/List.mo
*/

import Debug "mo:base/Debug";

module {
    public type List<T> = ?(T, List<T>);
    
    // Challenge 7
    // function is_null takes l of type List<T> and returns a boolean indicating if the list is null . 
    // Tips : Try using a switch/case.
    public func is_null<T>(l : List<T>) : Bool {
        switch(l){
            case(null) {
                return true;
            };
            case(?list){
                return false;
            }
        };        
    };

    // Challenge 8
    // function last that takes l of type List<T> and returns the optional last element of this list.
    public func last<T>(l : List<T>) : ?T {
        switch (l) {
            case(null) { 
                return null;
            };
            case(?(i, null)) {
                return ?i;
            };
            case(?(_, t)) {
                last<T>(t);
            };
        };
    };

    // Challenge 9
    // function size that takes l of type List<T> and returns a Nat indicating the size of this list.
    // Note : If l is null , this function will return 0.
    public func size<T>(l : List<T>) : Nat {
        func recursive(l : List<T>, n : Nat) : Nat {
            switch(l) {
                case(null) {
                    return n;
                };
                case(?(_,t)) {
                    recursive(t, n + 1);
                };

            };
        };
        recursive(l,0);
    };

    // Challenge 10
    // function takes two arguments : l of type List<T> and n of type Nat this function should return the optional value at rank n in the list.
    // Access any item in a list, zero-based.
    public func get<T>(l : List<T>, n : Nat) : ?T {
        switch (n,l) {
            case(_,null){
                return null;
            };
            case(0, (?(h, t))) {
                return ?h;
            };
            case(_,(?(_,t))) {
                get<T>(t, n - 1);
            };
        };
    };

    // Challenge 11
    // function reverse takes l of type List and returns the reversed list.
    public func reverse<T>(l : List<T>) : List<T> {
        func recursive(l : List<T>, r : List<T>) : List<T> {
            switch(l) {
                case(null) {
                    return r;
                };
                case(?(h, t)) {
                    recursive(t, ?(h, r)) 
                };
            }
        };
        recursive(l, null);
    };

};