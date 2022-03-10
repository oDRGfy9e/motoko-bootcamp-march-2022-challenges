module {
    public type Person = {
    name : Text;
    age : Nat;
    };

    public func reassigneToVariable(): async {age: Nat} {
        return {
            //name = "Test";
            age = 30;
        };
    };

};