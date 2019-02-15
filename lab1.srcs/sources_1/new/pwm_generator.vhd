

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity m_pwm_generator is
    Port ( 
            counter  : in  unsigned(7 downto 0)  := "00000000";
            ocr      : in  STD_LOGIC_VECTOR (7 downto 0);
            pwm      : out STD_LOGIC := '0'
           );
end m_pwm_generator;

architecture Behavioral of m_pwm_generator is

    -- Defines
    constant HIGH : STD_LOGIC := '1';
    constant LOW  : STD_LOGIC := '0';
    
    signal ocr_uint : unsigned(7 downto 0)  := "00000000";
begin

ocr_uint <= unsigned(ocr);


-- Process that generates PWM
pwm_process:
process(counter)
begin
    if counter > ocr_uint then
        pwm <= HIGH;
    else
        pwm <= LOW;
    end if;
end process;

end Behavioral;
