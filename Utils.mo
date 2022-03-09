import Iter "mo:base/Iter";

module {
    // function contains<A> takes 3 parameters : an array [A] , a of type A and a function f that takes a tuple of type (A,A) and returns a boolean.
    public func contains<A>(xs : [A], initial : A, f : (A,A) -> Bool): Bool {
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
};