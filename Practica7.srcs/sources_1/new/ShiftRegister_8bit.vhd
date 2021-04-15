----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2021 09:04:12 AM
-- Design Name: 
-- Module Name: ShiftRegister_8bit - Behavioral
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

entity ShiftRegister_8bit is
        Port ( serial_right : in STD_LOGIC;
        serial_left : in STD_LOGIC;
        s1 : in STD_LOGIC;
        s0 : in STD_LOGIC;
        clk : in STD_LOGIC;
        parallel_in : in STD_LOGIC_VECTOR(0 to 7);
        clear : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR (0 to 7));
end ShiftRegister_8bit;

architecture Behavioral of ShiftRegister_8bit is
component IC_74LS194 is
        Port ( serial_right : in STD_LOGIC;
       serial_left : in STD_LOGIC;
       s1 : in STD_LOGIC;
       s0 : in STD_LOGIC;
       clk : in STD_LOGIC;
       parallel_in : in STD_LOGIC_VECTOR(0 to 3);
       clear : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (0 to 3));
end component;

signal sr1Q : STD_LOGIC_VECTOR(0 to 3) := "0000";
signal sr2Q : STD_LOGIC_VECTOR(0 to 3) := "0000";

begin
    sr1 : IC_74LS194 port map(serial_right, sr2Q(0), s1, s0, clk, parallel_in(0 to 3), clear, sr1Q);
    sr2 : IC_74LS194 port map(sr1Q(3), serial_left, s1, s0, clk, parallel_in(4 to 7), clear, sr2Q);
    Q <= sr1Q & sr2Q;
end Behavioral;
