/* Motoko Bootcamp March 2022 Challenges
*/

import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Nat "mo:base/Nat";

actor {

  var counter : Nat = 0;
  

//  function add takes two natural numbers n and m and returns the sum.
  public func add(n : Nat, m : Nat) : async Nat {
    return (n + m);
  };

// function square takes a natural number n and returns the area of a square of length n.
  public func square(n : Nat)  : async Nat {
    return (n * n);
  };

// function days_to_second takes a number of days n and returns the number of seconds.
// the function limist the number of days to be a natural number, can't convert 2.5 days to seconds for ex.
  public func days_to_second(days : Nat) : async Nat {
    var seconds : Nat = days * 24 * 60 * 60;
    return (seconds);
  };

// function increment_counter returns the incremented value of counter by n.
  public func increment_counter(n : Nat) : async () {
    counter +=  n;
  };

// clear_counter sets the value of counter to 0.
  public func clear_counter () : async () {
    counter := 0;
    Debug.print(debug_show("Clear counter, set to: ",counter));
  };

// function divide takes two natural numbers n and m and returns a boolean indicating if n divides m.
  public func divide (n : Nat, m : Nat) : async Bool {
    if (n % m == 0) {
      return true;
    } else {
      return false;
    };
  };

// function is_even takes a natural number n and returns a boolean indicating if n is even.
  public func is_even (n : Nat) : async Bool {
    if (n > 0 and n % 2 == 0) {
      return true;
    } else {
      return false;
    };
  };

// function sum_of_array takes an array of natural numbers and returns the sum. This function will returns 0 if the array is empty.
  public func sum_of_array (array : [Nat]) : async Nat {
    
    var sum : Nat = 0;

    if (array.size() == 0) {
      return 0;
    } else {
      for (value in array.vals()){
        sum += value;   
      };
      return sum;
    };
  };

// function maximum takes an array of natural numbers and returns the maximum value in the array. This function will returns 0 if the array is empty.
  public query func maximum (array : [Nat]) : async Nat {
    
    var maximum : Nat = 0;

    if (array.size() == 0) {
      return 0;
    } else {    
      for (value in array.vals()) {
        Debug.print(debug_show(value));
        if (value > maximum) {
          maximum := value;
        };
      };
      return maximum;
    };
  };

// remove_from_array takes 2 parameters : an array of natural numbers and a natural number n and returns a new array 
// where all occurences of n have been removed (order should remain unchanged).
  public func remove_from_array (array : [Nat], n : Nat) : async [Nat] {
    
    var _array : [Nat] = [];
    Debug.print(debug_show(array));

    for (value in array.vals()) {
      if (value != n) {
        _array := Array.append<Nat>(_array,[value]);
      };
    };
    
    return _array;
  };
    
 // selection_sort that takes an array of natural numbers and returns the sorted array
 // use what is offered https://smartcontracts.org/docs/base-libraries/Array.html 
  public func selection_sort (array : [Nat]) : async [Nat] {
    var _array : [Nat] = [];
    _array := Array.sort(array, Nat.compare);
    return _array;
  };

// function main to test
  public func main () : async () {
    //counter := 6;
    Debug.print(debug_show("Counter = ",counter));
  };

};
