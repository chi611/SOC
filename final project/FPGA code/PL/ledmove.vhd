----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:07:49 03/07/2022 
-- Design Name: 
-- Module Name:    ledmove - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ledmove is
    port(clk_1    :in std_logic;
	      rst      :in std_logic;
			state_led:in std_logic_vector(2 downto 0);
			led :out std_logic_vector(7 downto 0);
			flag:out std_logic
			);
end ledmove;

architecture Behavioral of ledmove is
signal led_r:std_logic_vector(7 downto 0);
begin
    led<=led_r;
	 process(clk_1,rst)begin
        if rst='0' then
	         led_r(7 downto 1)<=(others=>'0');
				led_r(0)<='1';
	     elsif clk_1='1' and clk_1'event then
	         case state_led is
		          when "000"=>--moving_left
				       led_r(7 downto 1)<=led_r(6 downto 0);
					    led_r(0)<='0';
				    when "001"=>--moving_right
				       led_r(6 downto 0)<=led_r(7 downto 1);
					    led_r(7)<='0';			
    				when "010"=>--win_left
					    led_r(7 downto 4)<=(others=>'1');
						 led_r(3 downto 0)<=(others=>'0');
	    			when "011"=>--win_right
					    led_r(7 downto 4)<=(others=>'0');
						 led_r(3 downto 0)<=(others=>'1');
				   when "100"=>--ready_left
	                led_r(7 downto 1)<=(others=>'0');
				       led_r(0)<='1';
				   when "101"=>--ready_right
	                led_r(6 downto 0)<=(others=>'0');
				       led_r(7)<='1';
		    		when others=>null;
            end case;	 
    	 end if;
    end process;
    
	 process(clk_1,rst)begin
	     if rst='0' then
		      flag<='0';
		  elsif clk_1='1' and clk_1'event then
	         case state_led is
				   when "100"=>--ready_left
					    flag<='1';
				   when "101"=>--ready_right
					    flag<='1';
		    		when others=>flag<='0';		  
		      end case;
		  end if;
	  end process;
end Behavioral;

