 

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

    -- Shift register to control which row to display
    signal row_shift_register : STD_LOGIC_VECTOR (7 downto 0) := "11111110";
    
    signal red_intensity    : STD_LOGIC_VECTOR(63 downto 0) := x"0000000000000000"; 
    signal green_intensity  : STD_LOGIC_VECTOR(63 downto 0) := x"0000000000000000";
    signal blue_intensity   : STD_LOGIC_VECTOR(63 downto 0) := x"0000000000000000";
begin

-- Write shift register to output
row <= row_shift_register;

--with row_shift_register select
--    red_intensity <= x"0000000000000000" when "11111110",
--                     x"0022222222222222" when "11111101", 
--                     x"0044444444444444" when "11111011", 
--                     x"0066666666666666" when "11110111", 
--                     x"0088888888888888" when "11101111", 
--                     x"00AAAAAAAAAAAAAA" when "11011111", 
--                     x"00CCCCCCCCCCCCCC" when "10111111",
--                     x"00EEEEEEEEEEEEEE" when "01111111",
--                     x"00FFFFFFFFFFFFFF" when others;
                
red_intensity   <= x"FFFFFFFFFFFFFFFF";     
green_intensity <= x"0022446688AACCEF";
blue_intensity  <= x"FFFFFFFFFFFFFFFF";
 

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
-- 125MHz / 2^14 = 7629kHz
   if rising_edge(prescaler(10)) then
        counter <= counter + 1;
   end if;
end process;


--column_process:
--process (prescaler)
--begin
--   if rising_edge(prescaler(5)) then
--        -- Shift rows one spot down
--        row_shift_register(6 downto 0) <= row_shift_register(7 downto 1);
--        row_shift_register(7)          <= row_shift_register(0);
--   end if;
--end process;



row0:m_row
port map(
    counter     => counter,
    red         => red_intensity,
    green       => green_intensity,
    blue        => blue_intensity,
    red_pwm     => red,
    green_pwm   => green,
    blue_pwm    => blue
);





end Behavioral;
