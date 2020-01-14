set version:doit/0 to 1.

make every fork height in forks.erl activate near the genesis block
test_height() -> 0.
get(1) -> common(0, test_height());
get(2) -> common(0, test_height());
get(3) -> common(0, test_height());
get(4) -> common(constants:retarget_frequency(), max(test_height(), constants:retarget_frequency()));
get(5) -> common(1, max(test_height(), 1));
get(6) -> common(0, test_height());
get(7) -> common(40, 40);%test_height()).
get(8) -> common(0, test_height());
get(9) -> common(0, test_height());
get(10) -> common(1, 1);
get(11) -> common(0, test_height).
