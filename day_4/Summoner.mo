/* Motoko Bootcamp March 2022 Challenges
** Day 4 Challenge
** https://github.com/motoko-bootcamp/bootcamp/blob/main/daily_challenges/day_4/GUIDE.MD
**
    _____                                                     
    /  ___|                                                    
    \ `--. _   _ _ __ ___  _ __ ___   ___  _ __   ___ _ __ ___ 
    `--. \ | | | '_ ` _ \| '_ ` _ \ / _ \| '_ \ / _ \ '__/ __|
    /\__/ / |_| | | | | | | | | | | | (_) | | | |  __/ |  \__ \
    \____/ \__,_|_| |_| |_|_| |_| |_|\___/|_| |_|\___|_|  |___/

**
*/

module {
    public type Summoner = {
        name : Text;
        id : Nat;
        level : Nat;
        energy : Nat;
        strenght : Nat;
        dexterity : Nat;
        intelligence : Nat;
    };
};