

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity pwm_generator is
    Port ( counter  : in  unsigned(7 downto 0)  := "00000000";
           ocr      : in  STD_LOGIC_VECTOR (7 downto 0);
           pwm      : out STD_LOGIC);
end pwm_generator;

architecture Behavioral of pwm_generator is

pwm_process:
process(counter)
begin
    if (counter > unsigned(ocr) then
        pwm <= '1';
    else
        pwm <= '0';
    end if;
end process;

end Behavioral;
