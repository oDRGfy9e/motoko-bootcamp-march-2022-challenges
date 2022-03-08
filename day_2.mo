/* Motoko Bootcamp March 2022 Challenges
** Day 2 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_2/GUIDE.MD
*/

import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Char "mo:base/Char";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Iter "mo:base/Iter";


actor {

    // function nat8_to_nat converts a Nat8 n to a Nat.
    public func nat8_to_nat(n : Nat8) : async Nat {
        return(Nat8.toNat(n));
    };

    // function nat_to_nat8 converts a Nat n to a Nat8.
    public func nat_to_nat8(n : Nat) : async Nat8 {
        if (n > 255){
            Debug.trap("n is > maximum number 8-bits");
        } else {
            return Nat8.fromNat(n);
        };
    };

    // function max_number_with_n_bits takes a Nat n and returns the maximum number than can be represented with only n-bits.
    public func max_number_with_n_bits(n : Nat) : async Nat {
        // Naturtal numbers can be under 8,16,32,64 -bits max (or become simply Nat)
        return (2**n);
    };

    // function decimal_to_bits takes a Nat n and returns a Text corresponding to the binary representation of this number. 
    public func decimal_to_bits(n : Nat) : async Text {
        
        var natBit : Nat = 0;
        var p : Nat = 0;
        var temp : Nat = n;

        while (temp != 0) {
            natBit += (temp % 2) * (10 ** p);
            p += 1;
            temp /= 2;
            Debug.print(debug_show(temp));
        };

        return Nat.toText(natBit);
    };

     //	Return the character corresponding to the unicode value n.
    public func unicode_to_character(n : Nat32) : async Text {
    	let char : Char = Char.fromNat32(n);
    	return(Char.toText(char));
    };

    // function capitalize_character takes a Char c and returns the capitalized version of it.
    public func capitalize_character(c : Char) : async Char {
               
        if (Char.isAlphabetic(c) and Char.isLowercase(c)) {
            var upperCase : Nat32 = Char.toNat32(c) - 32;
            return Char.fromNat32(upperCase);
        } else {
            return c;
        };        
    };
    
    // function capitalize_text takes a Text t and returns the capitalized version of it.
    public func capitalize_text (t : Text) : async Text {

        var upperText : Text = "";
    
        for (char in t.chars()) {
            if (Char.isAlphabetic(char) and Char.isLowercase(char)) { 
                var upperCase = await capitalize_character(char);
                upperText := upperText # Char.toText(upperCase);
            } else {
                upperText := upperText # Char.toText(char);
            }
        };
     
        return upperText;
    };

    // function capitalize_character_2 takes a Char c and returns the capitalized version of it.
    private func capitalize_character_2(c : Char) : Char {
               
        if (Char.isAlphabetic(c) and Char.isLowercase(c)) {
            var upperCase : Nat32 = Char.toNat32(c) - 32;
            return Char.fromNat32(upperCase);
        } else {
            return c;
        };        
    };

    // function capitalize_text_2 takes a Text t and returns the capitalized version of it.
    public func capitalize_text_2 (t : Text) : async Text {
        return (Text.map(t, capitalize_character_2));
    };
    
    
    // function is_inside takes two arguments : a Text t and a Char c and returns a Bool indicating if c is inside t .
    public func is_inside (t : Text, c : Char) : async Bool {
        for (char in t.chars()) {
            if (char == c) {
                return true;
            };
        };
        return false;
    };

    // function trim_whitespace takes a text t and returns the trimmed version of t. 
    // Note : Trim means removing any leading and trailing spaces from the text : trim_whitespace(" Hello ") -> "Hello".
    public func trim_whitespace(t : Text) : async Text {
        
        var trimmedText : Text = "";
        let whitespace : Char = ' ';

        if (await is_inside(t, whitespace)) {
            for (char in t.chars()) {
                if (char != whitespace) {
                    trimmedText := trimmedText # Char.toText(char);
                };
            };
            return trimmedText;
        } else {
            return t;
        };
    };

    public func trim_whitespace_2(t : Text): async Text {
        return Text.trim(t, #text " ");
    };


    // function duplicated_character takes a Text t and returns the first duplicated character in t converted to Text.
    // Note : The function should return the whole Text if there is no duplicate character.
    // duplicated_character("Hello") -> "l" & duplicated_character("World") -> "World".
    public func duplicated_character(t : Text) : async Text {
        
        for (char in t.chars()) {

            var temp : Text = Text.trimStart(t, #char char);
            Debug.print(debug_show(temp));            
            
            if (is_inside(temp, char)) {
                return char;
            };
        };

        return t;
    };

    // function size_in_bytes takes Text t and returns the number of bytes this text takes when encoded as UTF-8.
    public func size_in_bytes(t : Text) : async Nat {
        return Text.encodeUtf8(t).size();
    };

    // function bubble_sort takes an array of natural numbers and returns the sorted array .
    public func bubble_sort(a : [Nat]) : async [Nat] {
        var _a : [var Nat] = Array.thaw(a);
        var last_id : Nat = _a.size() - 1;

        for (i in Iter.range(0, last_id)) {
            for (j in Iter.range(0, last_id - i -1)) {
                if (_a[j] > _a[j + 1]) {
                    var temp = _a [j];
                    _a[j] := _a[j + 1];
                    _a[j + 1] := temp;
                };
                Debug.print(debug_show(j));
            };
            
        };
        return Array.freeze(_a);
    };   

};