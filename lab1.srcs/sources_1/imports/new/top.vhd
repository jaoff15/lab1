 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;


entity top is
    Port (  
            clk_8ns     : in  STD_LOGIC;
            red         : out STD_LOGIC_VECTOR (7 downto 0) := "00000000";
            green       : out STD_LOGIC_VECTOR (7 downto 0) := "00000000";
            blue        : out STD_LOGIC_VECTOR (7 downto 0) := "00000000";
            row         : out STD_LOGIC_VECTOR (7 downto 0) := "00000000"
           );
end top;

architecture Behavioral of top is

    
    
    -- Define interface with row
    component m_row is
    Port (  
            counter     : in  unsigned(7 downto 0)          := "00000000";
            red         : in  STD_LOGIC_VECTOR(63 downto 0) := x"0000000000000000"; 
            green       : in  STD_LOGIC_VECTOR(63 downto 0) := x"0000000000000000";
            blue        : in  STD_LOGIC_VECTOR(63 downto 0) := x"0000000000000000";
            red_pwm     : out STD_LOGIC_VECTOR(7  downto 0) := "00000000";
            green_pwm   : out STD_LOGIC_VECTOR(7  downto 0) := "00000000";
            blue_pwm    : out STD_LOGIC_VECTOR(7  downto 0) := "00000000"
           );
    end component;
    
    
    signal prescaler       : unsigned(31 downto 0) := x"00000000";
    signal counter         : unsigned(7 downto 0)  := "00000000";

    signal row_shift_register : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
begin

row <= row_shift_register;

prescaling_process:
process (clk_8ns)
begin
   if rising_edge(clk_8ns) then
        prescaler <= prescaler + 1;
   end if;
end process;


counter_process:
process (prescaler)
begin
-- 7.5kHz
   if rising_edge(prescaler(14)) then
        counter <= counter + 1;
   end if;
end process;


column_process:
process (prescaler)
begin
   if rising_edge(prescaler(25)) then
        -- Shift rows one spot down
        row_shift_register(6 downto 0) <= row_shift_register(7 downto 1);
        row_shift_register(7)          <= row_shift_register(0);
   end if;
end process;



row0:m_row
port map(
    counter     => counter,
    red         => x"22446688AACCDDFF",
    green       => x"FFFFFFFFFFFFFFFF",
    blue        => x"FFFFFFFFFFFFFFFF",
    red_pwm     => red,
    green_pwm   => green,
    blue_pwm    => blue
);





end Behavioral;
