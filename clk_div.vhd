----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:39:51 04/12/2012 
-- Design Name: 
-- Module Name:    clk_div - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_div is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           BASE : out  STD_LOGIC;
		 MINS : out  STD_LOGIC;
           DISP : out  STD_LOGIC);
end clk_div;

architecture Behavioral of clk_div is

signal disp_count : std_logic_vector(13 downto 0);
signal base_count : std_logic_vector(23 downto 0);
signal mins_count : std_logic_vector(31 downto 0);
constant MAX_BASE : std_logic_vector(23 downto 0):= "011110100001000111111111";
signal base_out : std_logic:='0';
signal mins_out : std_logic:='0';
begin

dcount: process(CLK, RST)
begin
	if(RST = '1') then
		disp_count <= (others => '0');
	elsif(rising_edge(CLK)) then
		disp_count <= disp_count + 1;
	end if;

end process;

scount: process(CLK, RST)
begin
	if(RST = '1') then
		base_count <= (others => '0');
	elsif(rising_edge(CLK)) then
		if(base_count = "011110100001000111111111") then --7999999
			base_count <= (others => '0');
		else
			base_count <= base_count + 1;
		end if;
		
		if(base_count < "001111010000100100000000") then --4000000
			base_out <= '0';
		else
			base_out <= '1';
		end if;			
	end if;
end process;

mcount: process(CLK, RST)
begin
	if(RST = '1') then
		mins_count <= (others => '0');
	elsif(rising_edge(CLK)) then
		if(mins_count = "00011100100111000011011111111111") then
			mins_count <= (others => '0');
		else
			mins_count <= mins_count + 1;
		end if;
		
		if(mins_count < "1110010011100001110000000000")then
			mins_out <= '0';
		else
			mins_out <= '1';
		end if;			
	end if;
end process;

MINS <= mins_out;
DISP <= disp_count(13);
BASE <= base_out;
end Behavioral;

