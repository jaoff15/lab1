

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity m_color_channel is
    Port ( 
            counter   : in  unsigned(7 downto 0)            := "00000000";
            red       : in  STD_LOGIC_VECTOR (7 downto 0)   := "00000000";
            green     : in  STD_LOGIC_VECTOR (7 downto 0)   := "00000000";
            blue      : in  STD_LOGIC_VECTOR (7 downto 0)   := "00000000";
            red_pwm   : out STD_LOGIC := '0';
            green_pwm : out STD_LOGIC := '0';
            blue_pwm  : out STD_LOGIC := '0'
           );
end m_color_channel;

architecture Behavioral of m_color_channel is
    component m_pwm_generator is
    Port (  
            counter : in  unsigned(7 downto 0)  := "00000000";
            ocr     : in  STD_LOGIC_VECTOR(7 downto 0);
            pwm     : out STD_LOGIC := '0'
           );
    end component;
begin

-- The red LED
pwm_generator_r:m_pwm_generator
port map(
    counter => counter,
    ocr     => red,
    pwm     => red_pwm
);

-- The green LED
pwm_generator_g:m_pwm_generator
port map(
    counter => counter,
    ocr     => green,
    pwm     => green_pwm
);

-- The blue LED
pwm_generator_b:m_pwm_generator
port map(
    counter => counter,
    ocr     => blue,
    pwm     => blue_pwm
);

end Behavioral;
