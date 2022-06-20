LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY counter IS
PORT
(
	S, R, Enable,res : IN STD_LOGIC ; -- Latch's in input
	hex0,hex1:OUT STD_LOGIC_VECTOR (7 downto 0);
	OnLed: OUT STD_LOGIC
);
END counter;
ARCHITECTURE a OF counter IS
	SIGNAL Q,nQ : STD_LOGIC;
	SIGNAL digit0, digit1: INTEGER RANGE 0 to 9;
	SIGNAL display0,display1:STD_LOGIC_VECTOR (7 downto 0); -- debounced control signal
BEGIN
-- Gated SR NAND latch to debounce pushbotton gitter
	Q <= ((not S) NAND Enable) NAND nQ;
	nQ <= ((not R) NAND Enable) NAND Q;
	OnLed <=Q;
	pro0: PROCESS(Q,res)
	BEGIN
	IF (Enable='1' and res='0')  THEN
		digit0 <= 0; 
		digit0 <= 0;  
		ELSIF (Q'EVENT and Q='1' ) THEN -- Handle counter
		-- two-digit counter
		digit0 <= digit0 + 1; -- advance the digit0 by one
			IF(digit0 >= 9 ) THEN
			digit1 <= digit1 + 1;
			digit0 <= 0;
			IF(digit1>=9 ) THEN -- reset the digit1 to 0 (overflow)
			digit1 <= 0;
			END IF;
		END IF;
	END IF;
	END PROCESS pro0;
	
WITH digit0 SELECT
hex0 <= "00000011" WHEN 0,-- 0 displayed
		"10011111" WHEN 1,-- 1
		"00100101" WHEN 2,-- 2
		"00001101" WHEN 3,-- 3
		"10011001" WHEN 4,-- 4
		"01001001" WHEN 5,-- 5
		"11000001" WHEN 6,-- 6
		"00011111" WHEN 7,-- 7
		"00000001" WHEN 8,-- 8
		"00011001" WHEN 9,-- 9
		"11111111" WHEN OTHERS;

WITH digit1 SELECT
hex1 <= "00000011" WHEN 0,-- 0 displayed
		"10011111" WHEN 1,-- 1
		"00100101" WHEN 2,-- 2
		"00001101" WHEN 3,-- 3
		"10011001" WHEN 4,-- 4
		"01001001" WHEN 5,-- 5
		"11000001" WHEN 6,-- 6
		"00011111" WHEN 7,-- 7
		"00000001" WHEN 8,-- 8
		"00011001" WHEN 9,-- 9
		"11111111" WHEN OTHERS;
END a;





