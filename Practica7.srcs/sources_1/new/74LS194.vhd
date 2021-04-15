----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2021 07:08:09 PM
-- Design Name: 
-- Module Name: 74LS194 - Behavioral
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

entity IC_74LS194 is
    Port ( serial_right : in STD_LOGIC;
           serial_left : in STD_LOGIC;
           s1 : in STD_LOGIC;
           s0 : in STD_LOGIC;
           clk : in STD_LOGIC;
           parallel_in : in STD_LOGIC_VECTOR(0 to 3);
           clear : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (0 to 3));
end IC_74LS194;

architecture Behavioral of IC_74LS194 is
signal Q_s : STD_LOGIC_VECTOR(0 to 3) := "0000";
begin

Q <= Q_s;

process(clk, clear)
    begin
    if(clear = '1') then
        Q_s <= "0000";
    elsif (clk = '1' and clk'event) then
        if(s1 = '0' and s0 = '0') then
            
        elsif (s1 = '1' and s0 = '1') then
            Q_s <= parallel_in;
        elsif (s1 = '1' and s0 = '0') then
            Q_s <= Q_s(1 to 3) & serial_left;
        elsif (s1 = '0' and s0 = '1') then
            Q_s <= serial_right & Q_s(0 to 2);
        end if;
        
    end if;
end process;


end Behavioral;
