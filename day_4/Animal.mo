/* Motoko Bootcamp March 2022 Challenges
** Day 4 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_4/GUIDE.MD
*/

module {
    public type Animal = {
        specie : Text;
        energy : Nat; // Maximum 100 energy
    };

    // Challenge 3
    // Function animal_sleep takes an Animal and returns the same Animal where the field energy has been increased by 10
    public func animal_sleep(animal : Animal) : Animal {
        
        let current_energy : Nat = animal.energy;
        
       if (current_energy >= 90){
           return {
               specie = animal.specie;
               energy = 100;
           }
       } else {
           return {
               specie = animal.specie;
               energy = current_energy + 10;
           }
       };
        
    };


};