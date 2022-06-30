----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:36:28 03/07/2022 
-- Design Name: 
-- Module Name:    FSM - Behavioral 
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


entity FSM is
    port(clk_100M   :in std_logic;
         rst        :in std_logic;
         btn_left   :in std_logic;
         btn_right  :in std_logic;
         led        :out std_logic_vector(7 downto 0);
         IRQ        :out std_logic
    );			
end FSM;

architecture Behavioral of FSM is
    component ledmove is
    port(clk_1    :in std_logic;
	      rst      :in std_logic;
			state_led:in std_logic_vector(2 downto 0);
			led :out std_logic_vector(7 downto 0);
			flag:out std_logic
			);  
    end component;
	 
    component divclk is
	 port(clk_100M : in std_logic;
	      rst     : in std_logic;
	      clk_1   : out std_logic); 
    end component;	 
	 
type state is (moving_left,moving_right,win_left,win_right,ready_left,ready_right);
signal state_r:state;
signal led_r:std_logic_vector(7 downto 0);
signal state_led:std_logic_vector(2 downto 0);
signal clk_1:std_logic;
signal led_flag:std_logic;
begin
    com_led:ledmove port map(clk_1=>clk_1,rst=>rst,state_led=>state_led,led=>led_r,flag=>led_flag);
	 com_divclk:divclk port map(clk_100M,rst,clk_1);
    led<=led_r;
	 IRQ<=btn_left or btn_right or clk_1;
	 process(clk_100M,rst,led_r,btn_left,btn_right)
	 begin
	     if rst='0' then
		      state_r<=moving_left;			
		  elsif clk_100M='1' and clk_100M'event then
		      case state_r is
			       when moving_left=>
					     if btn_left='1' then--左邊玩家按下按鈕
						      if led_r(7)='1' then   
								    state_r<=moving_right;
								else
								    state_r<=win_right;
								end if;
						  end if;						  
						  if led_r="00000000" then--左邊玩家漏接
						      state_r<=win_right;
						  end if;
			  		 when moving_right=>
					     if btn_right='1' then--右邊玩家按下按鈕
						      if led_r(0)='1' then   
								    state_r<=moving_left;
								else
								    state_r<=win_left;
								end if;								
						  end if;
						  if led_r="00000000" then--右邊玩家漏接
						      state_r<=win_left;
						  end if;				
					 when win_left=>
					     if btn_left='1' then--左邊玩家按下按鈕
                        state_r<=ready_right;							
						  end if;
					 when win_right=>
					     if btn_right='1' then--右邊玩家按下按鈕
							   state_r<=ready_left;							
						  end if;
				    when ready_left=>
					     if led_flag='1' then--等待led compoent初始化
					         state_r<=moving_left;
					     end if;
					 when ready_right=>
					     if led_flag='1' then--等待led compoent初始化
					         state_r<=moving_right;
					     end if;
					 when others=>null;
			   end case;
        end if;
    end process;
	 
	 porcess_led_state:process(clk_100M,rst,state_r)
	 begin
	     if rst='0' then
		      state_led<="000";
		  elsif clk_100M='1' and clk_100M'event then
		      case state_r is
			       when moving_left=>
						  state_led<="000";
			  		 when moving_right=>		
						  state_led<="001";
					 when win_left=>
						  state_led<="010";--點亮左邊四顆led
					 when win_right=>
						  state_led<="011";--點亮右邊四顆led
				    when ready_left=>
						  state_led<="100";--點亮最右邊一顆led準備左移
					 when ready_right=>
						  state_led<="101";--點亮最左邊一顆led準備右移
					 when others=>null;
			   end case;		  
		  end if;	 
	 end process;
	 
	 
end Behavioral;
