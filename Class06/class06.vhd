LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY class06 IS
PORT (CLK: IN STD_LOGIC;
      Hex0, Hex1, Hex2, Hex3: OUT STD_LOGIC_VECTOR(0 to 7));
END class06;

ARCHITECTURE a OF class06 IS
SIGNAL Ticks : INTEGER;
TYPE MMSS is array (0 to 3) of INTEGER RANGE 0 to 9;
SIGNAL OneSecondTicks: INTEGER := 500000;
SIGNAL digits: MMSS :=(3,4,5,6);
TYPE SEVENSEGMENT is array (0 to 3) of STD_LOGIC_VECTOR(0 to 7);
SIGNAL ss: SEVENSEGMENT;
FUNCTION PlusOne (a:INTEGER RANGE 0 to 9) RETURN INTEGER IS
VARIABLE result : INTEGER RANGE 0 to 9;
BEGIN
result := a + 1;
RETURN (result);
END;
BEGIN
Hex0 <= ss(3);
Hex1 <= ss(2);
Hex2 <= ss(1);
Hex3 <= ss(0);
PROCESS(CLK)
BEGIN
    IF(RISING_EDGE(CLK)) THEN
    Ticks <= Ticks + 1;
    IF(Ticks >= OneSecondTicks-1) THEN
        Ticks <= 0;
        digits(3) <= PlusOne(digits(3));
    IF(digits(3)>=9) THEN
        digits(2) <= PlusOne(digits(2));
        digits(3) <= 0;
    IF(digits(2)>=5) THEN
        digits(1) <= PlusOne(digits(1));
        digits(2) <= 0;
    IF(digits(1)>=9) THEN
        digits(0) <= PlusOne(digits(0));
        digits(1) <= 0;
    IF(digits(0)>=5) THEN
        digits(0) <= 0;
    END IF;
    END IF;
    END IF;
    END IF;
    END IF;
    END IF;

    FOR i IN 0 to 3 LOOP
    CASE digits(i) IS
    WHEN 0=> ss(i)<="00000011"; -- 0
    WHEN 1=> ss(i)<="10011111"; -- 1
    WHEN 2=> ss(i)<="00100101"; -- 2
    WHEN 3=> ss(i)<="00001101"; -- 3
    WHEN 4=> ss(i)<="10011001"; -- 4
    WHEN 5=> ss(i)<="01001001"; -- 5
    WHEN 6=> ss(i)<="11000001"; -- 6
    WHEN 7=> ss(i)<="00011111"; -- 7
    WHEN 8=> ss(i)<="00000001"; -- 8
    WHEN 9=> ss(i)<="00011001"; -- 9
    WHEN others =>ss(i)<="11111111";
    END CASE;
END LOOP;
ss(1)(7) <= '0'; -- display "dot"
END PROCESS;
END a;