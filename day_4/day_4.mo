/* Motoko Bootcamp March 2022 Challenges
** Day 4 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_4/GUIDE.MD
*/

import Debug "mo:base/Debug";
import Person "Person";
import Summoner "Summoner";
import Animal "Animal";
import List "mo:base/List";
import List2 "List";

actor {

    public type Person = Person.Person;
    let motokog : Person = {
        name = "Motok OG";
        age = 1;
    };

    public type Summoner = Summoner.Summoner;
    let barbarian : Summoner = {
        name = "Evil";
        id = 1;
        level = 1;
        energy = 100;
        strenght = 10;
        dexterity = 5;
        intelligence = 3;
    };

    // Challenge 1
    // function get_strenght that takes no argument but return a value of your custom type. 
    public func get_strenght () : async Nat {
        return barbarian.strenght;
    };

    // Challenge 2
    public type Animal = Animal.Animal;
    let horse : Animal = {
        specie = "Equidae";
        energy = 20;
    };

    // Challenge 4
    // function called create_animal_then_takes_a_break that takes two parameter : a specie of type Text, an number of energy point of type Nat and returns an animal.
    // create a new animal based on the parameters passed and then put this animal to sleep before returning it ! zzz
    public func create_animal_then_takes_a_break(s : Text, e : Nat) : async Animal {
        let animal : Animal = {
            specie = s;
            energy = e;
        };
        return(Animal.animal_sleep(animal));
    };

    // Challenge 5
    var listOfAnimals = List.nil<Animal>();

    // Challenge 6
    // function push_animal takes an animal as parameter and returns nothing this function should add this animal
    public func push_animal (animal : Animal) : async () {
        listOfAnimals := List.push<Animal>(animal, listOfAnimals);
        return;
    };

    // Challenge 6
    // function get_animals takes no parameter but returns an Array that contains all animals stored in the list.
    public func get_animals () : async [Animal] {
        return (List.toArray<Animal>(listOfAnimals));
    };

    public func test () : async () {
        //var listOfAnimals = List.nil<Animal>();
        //return(List2.is_null<Animal>(listOfAnimals));
        //return(List.last<Animal>(listOfAnimals));
        //return(List2.last<Animal>(listOfAnimals));
        //return(List2.size<Animal>(listOfAnimals));
        listOfAnimals := List2.reverse<Animal>(listOfAnimals);
        return;
    };

};

