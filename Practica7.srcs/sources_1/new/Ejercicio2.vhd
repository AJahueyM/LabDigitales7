----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2021 12:18:01 PM
-- Design Name: 
-- Module Name: Ejercicio2 - Behavioral
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

entity Ejercicio2 is
  Port (    clk : in STD_LOGIC;
            seg : out std_logic_vector(7 downto 0);
            an : out std_logic_vector(7 downto 0));
end Ejercicio2;

architecture Behavioral of Ejercicio2 is
component sSegDisplay is
    Port(
        ck : in  std_logic;                          -- 100MHz system clock
        number : in  std_logic_vector (63 downto 0); -- eight digit number to be displayed
        seg : out  std_logic_vector (7 downto 0);    -- display cathodes
        an : out  std_logic_vector (7 downto 0));    -- display anodes (active-low, due to transistor complementing)
end component;

component BCD2_Counter is
    Port (
    u_d : in STD_LOGIC;
    clk : in STD_LOGIC;
    DEC : out STD_LOGIC_VECTOR(0 to 3);
    UN : out STD_LOGIC_VECTOR(0 to 3));
end component;

type COUNTER_STATES is
    (UP, DOWN);
signal state : COUNTER_STATES := UP;
signal u_d : std_logic := '1';
signal num : std_logic_vector(63 downto 0) := (others => '1');
signal dec_h : std_logic_vector(0 to 3);
signal un_h : std_logic_vector(0 to 3);
signal div_clock : std_logic := '0';
begin

decoder : sSegDisplay port map(clk, num, seg, an);
counter : BCD2_Counter port map(u_d, div_clock, dec_h, un_h);

process (clk)
variable counter : Integer := 0;
begin

    case (state) is
        when UP => 
            if(dec_h = "1001" and un_h = "0001") then
                state <= DOWN;
                u_d <= '0';
            end if;
        when DOWN =>
            if(dec_h = "0000" and un_h = "1000") then
                state <= UP;
                u_d <= '1';
            end if;
    end case;
        
    if clk'event and clk = '1' then
        counter := counter + 1;
    end if;
    
    if counter = 3 then
        counter := 0;
        div_clock <= not div_clock;    
    end if;
    
    case (dec_h) is
      when "0000" => num(15 downto 8) <= "00000011";
      when "1000" => num(15 downto 8) <= "10011111";
      when "0100" => num(15 downto 8) <= "00100101";
      when "1100" => num(15 downto 8) <= "00001101";
      when "0010" => num(15 downto 8) <= "10011001";
      when "1010" => num(15 downto 8) <= "01001001";
      when "0110" => num(15 downto 8) <= "01000001";
      when "1110" => num(15 downto 8) <= "00011111";
      when "0001" => num(15 downto 8) <= "00000001";
      when "1001" => num(15 downto 8) <= "00001001";
      when others => num(15 downto 8) <= "11111111";
      end case;
         
         
   case (un_h) is
      when "0000" => num(7 downto 0) <= "00000011";
      when "1000" => num(7 downto 0) <= "10011111";
      when "0100" => num(7 downto 0) <= "00100101";
      when "1100" => num(7 downto 0) <= "00001101";
      when "0010" => num(7 downto 0) <= "10011001";
      when "1010" => num(7 downto 0) <= "01001001";
      when "0110" => num(7 downto 0) <= "01000001";
      when "1110" => num(7 downto 0) <= "00011111";
      when "0001" => num(7 downto 0) <= "00000001";
      when "1001" => num(7 downto 0) <= "00001001";
      when others => num(7 downto 0) <= "11111111";
      end case;
                  
end process;
end Behavioral;
