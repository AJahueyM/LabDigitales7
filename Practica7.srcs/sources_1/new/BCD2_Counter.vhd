----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2021 11:57:09 AM
-- Design Name: 
-- Module Name: BCD2_Counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD2_Counter is
  Port (    u_d : in STD_LOGIC;
            clk : in STD_LOGIC;
            DEC : out STD_LOGIC_VECTOR(0 to 3);
            UN : out STD_LOGIC_VECTOR(0 to 3));
end BCD2_Counter;

architecture Behavioral of BCD2_Counter is
component IC_74LS169 is
    Port ( 
      clk : in STD_LOGIC;
      u_d : in STD_LOGIC;
      parallel_in : in STD_LOGIC_VECTOR(0 to 3);
      load : in STD_LOGIC;
      ep : in STD_LOGIC;
      et : in STD_LOGIC;
      co : out STD_LOGIC;
      Q : out STD_LOGIC_VECTOR(0 to 3)
    );
end component;
signal carry_out : STD_LOGIC;
signal carry_out2 : STD_LOGIC;
begin
    count1 : IC_74LS169 port map(clk, u_d, "0000", '0', '1', '1', carry_out, UN);
    count2 : IC_74LS169 port map(clk, u_d, "0000", '0', '1', carry_out, carry_out2, DEC);

end Behavioral;
