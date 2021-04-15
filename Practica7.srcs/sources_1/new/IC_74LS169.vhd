----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2021 09:46:52 AM
-- Design Name: 
-- Module Name: IC_74LS169 - Behavioral
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

entity IC_74LS169 is
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
end IC_74LS169;

architecture Behavioral of IC_74LS169 is
type COUNTER_STATES is
    (Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine);
    
signal state : COUNTER_STATES := Zero;
signal Q_s : STD_LOGIC_VECTOR(0 to 3) := "0000";
begin

    Q <= Q_s;
process(clk, u_d)

begin
    if((state = Zero and u_d = '0') or (state = Nine and u_d = '1')) then
        co <= '1';
    else
        co <= '0';
    end if;
    
    if(clk = '1' and clk'event and (ep = '1' and et = '1')) then

        
        if(load = '1')then
            Q_s <= parallel_in;
        else 
        case (state) is
            when Zero => 
                if(u_d = '1') then
                    Q_s <= "1000";
                    state <= One;
                else
                    Q_s <= "1001";
                    state <= Nine;
                end if;
            when One => 
                if(u_d = '1') then
                    Q_s <= "0100";
                    state <= Two;
                else
                    Q_s <= "0000";
                    state <= Zero;
                end if;
            when Two => 
                if(u_d = '1') then
                    Q_s <= "1100";
                    state <= Three;
                else
                    Q_s <= "1000";
                    state <= One;
                end if;
            when Three => 
                if(u_d = '1') then
                    Q_s <= "0010";
                    state <= Four;
                else
                    Q_s <= "0100";
                    state <= Two;
                end if;
            when Four => 
                if(u_d = '1') then
                    Q_s <= "1010";
                    state <= Five;
                else
                    Q_s <= "1100";
                    state <= Three;
                end if;
            when Five => 
                if(u_d = '1') then
                    Q_s <= "0110";
                    state <= Six;
                else
                    Q_s <= "0010";
                    state <= Four;
                end if;
            when Six => 
                if(u_d = '1') then
                    Q_s <= "1110";    
                    state <= Seven;
                else
                    Q_s <= "1010";    
                    state <= Five;
                end if;
            when Seven => 
                if(u_d = '1') then
                    Q_s <= "0001";    
                    state <= Eight;
                else
                    Q_s <= "0110";    
                    state <= Six;
                end if;
            when Eight => 
                if(u_d = '1') then
                    Q_s <= "1001";    
                    state <= Nine;
                else
                    Q_s <= "1110";    
                    state <= Seven;
                end if;
            when Nine => 
                if(u_d = '1') then
                    state <= Zero;
                    Q_s <= "0000";  
                else
                    Q_s <= "0001";  
                    state <= Eight;
                end if;
        end case;            
        end if;

    end if;
end process;

end Behavioral;
