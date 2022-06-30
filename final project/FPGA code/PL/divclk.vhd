----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:06:33 03/07/2022 
-- Design Name: 
-- Module Name:    divclk - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divclk is
	 port(clk_100M : in std_logic;
	      rst     : in std_logic;
	      clk_1   : out std_logic);
end divclk;

architecture Behavioral of divclk is
    signal clock :std_logic_vector(26 downto 0);
begin
    process(clk_100M,rst)
	 begin 
        if rst='0' then
            clock<=(others=>'0');
        elsif clk_100M='1' and clk_100M'event then
            if clock(26)='1' then
                clock<=(others=>'0');
            else
                clock<=clock+1;
            end if;
        end if;
    end process;
    clk_1<=clock(24);
end Behavioral;
