----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:06:32 03/16/2019 
-- Design Name: 
-- Module Name:    elevator - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity elevator is
    Port ( valid : in STD_LOGIC;
			  em_stop : in STD_LOGIC;
			  clk : in STD_LOGIC;
           ELE : in  STD_LOGIC_VECTOR (6 downto 0);
			  F0 : in STD_LOGIC_VECTOR (1 downto 0);
           F1 : in STD_LOGIC_VECTOR (1 downto 0);
           F2 : in STD_LOGIC_VECTOR (1 downto 0);
           F3 : in STD_LOGIC_VECTOR (1 downto 0);
           F4 : in STD_LOGIC_VECTOR (1 downto 0);
           F5 : in STD_LOGIC_VECTOR (1 downto 0);
           F6 : in STD_LOGIC_VECTOR (1 downto 0);
  			  fl : out  STD_LOGIC_VECTOR (2 downto 0));
end elevator;

architecture Behavioral of elevator is
--type state_type is (f0, f1, f2, f3, f4, f5, f6);
---signal pst,nst : state_type:=f0;
signal pst, nst : STD_LOGIC_VECTOR (2 downto 0):="000";
signal ELE1, CALL1U, CALL1D : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
--type memory_type is array (0 to 6) of std_logic_vector(2 downto 0);
type memory_type is array (0 to 14) of integer;
signal memory : memory_type := (others => 0);
signal n,count,ccount : integer := 0;
signal q : integer := 7;
signal counter :STD_LOGIC := '0';
begin

process(clk)
begin
	if(rising_edge(clk)) then
		if(ccount < 9) then
			ccount <= ccount + 1;
			if (ccount < 5) then
				counter <= '0';
			else
				counter <= '1';
			end if;
		else
			ccount <= 0;
		end if;	
	end if;
end process;


SEQ: process(counter)
begin
	if(rising_edge(counter)) then
			pst <= nst;
			n <= conv_integer(nst);
	end if;
end process;

process(ELE, F0, F1, F2, F3, F4, F5, F6, n, valid)
begin	
	if (valid = '1') then	
		ELE1 <= ELE1 or ELE;
		CALL1U <= CALL1U or (F6(1) & F5(1) & F4(1) & F3(1) & F2(1) & F1(1) & F0(1));
		CALL1D <= CALL1D or (F6(0) & F5(0) & F4(0) & F3(0) & F2(0) & F1(0) & F0(0));
		ELE1(n) <= '0';
		if(not(n > q))then
			CALL1U(n) <= '0';
		end if;
		if(not(n < q))then
			CALL1D(n) <= '0';
		end if;
	end if;		
end process; 

process(ELE1, CALL1U, CALL1D, n)
	variable i: integer := 0;
	variable s : STD_LOGIC := '0';
begin 

		if(count = 0) then
			if(not(ELE1 = "0000000" and CALL1U = "0000000" and CALL1D = "0000000")) then
				check_s2 : for k in 0 to 6 loop 
				exit when k = 7-n;
				s := s or ELE1(k+n);
				end loop check_s2;
				check_s1 : for k in 0 to 6 loop
				exit when k = n;
					s := s and (not ELE1(n-1-k));
				end loop check_s1;	
				if (s = '1') then
					mem_add_up1 : for k in 0 to 6 loop
					exit when k = 7-n;
					if (ELE1(k+n) = '1' or CALL1U(k+n) = '1' or CALL1D(k+n) = '1') then
						memory(i) <= k+n;
						i := i + 1;
					end if;	
					end loop mem_add_up1;
					mem_add_down1 : for k in 0 to 6 loop
					exit when k = n;
					if (ELE1(n-1-k)='1' or CALL1U(n-1-k)='1' or CALL1D(n-1-k) = '1') then
						memory(i) <= n-1-k;
						i := i + 1;
					end if;	
					end loop mem_add_down1;
					count <= i;
					i := 0;
				else
					mem_add_down2 : for k in 0 to 6 loop
					exit when k = n;
					if (ELE1(n-1-k)='1' or CALL1U(n-1-k)='1' or CALL1D(n-1-k) = '1') then
						memory(i) <= n-1-k;
						i := i + 1;
					end if;	
					end loop mem_add_down2;
					mem_add_up2 : for k in 0 to 6 loop
					exit when k = 7-n;
					if (ELE1(k+n)='1' or CALL1U(k+n)='1' or CALL1D(k+n) = '1') then
						memory(i) <= k+n;
						i := i + 1;
					end if;	
					end loop mem_add_up2;
					count <= i;
					i := 0;
				end if;	
			end if;
		elsif(n < memory(0)) then
			mem_add_up3 : for k in 0 to 6 loop
			exit when k = 7-n;	
			if (ELE1(k+n)='1' or CALL1U(k+n)='1') then
					memory(i) <= k+n;
					i := i + 1;
				end if;	
			end loop mem_add_up3;
			mem_add_down30 : for k in 0 to 6 loop
			exit when k = 7-n;
			if (CALL1D(6-k)='1') then
				memory(i) <= 6-k;
				i := i + 1;
			end if;	
			end loop mem_add_down30;
			mem_add_down3 : for k in 0 to 6 loop
			exit when k = n;
				if (ELE1(n-1-k)='1' or CALL1D(n-1-k) = '1') then
					memory(i) <= n-1-k;
					i := i + 1;
				end if;	
			end loop mem_add_down3;
			mem_add_up30 : for k in 0 to 6 loop
			exit when k = n;
			if (CALL1U(k) = '1') then
				memory(i) <= k;
				i := i + 1;
			end if;
			end loop mem_add_up30;
			count <= i;
			i := 0;
		elsif(n > memory(0)) then
			mem_add_down4 : for k in 0 to 6 loop
			exit when k = n;
				if (ELE1(n-1-k)='1' or CALL1D(n-1-k)='1') then
					memory(i) <= n-1-k;
					i := i + 1;
				end if;		
			end loop mem_add_down4;
			mem_add_up40 : for k in 0 to 6 loop
			exit when k = n;
			if (CALL1U(k) = '1') then
				memory(i) <= k;
				i := i+1;
			end if;
			end loop mem_add_up40;
			mem_add_up4 : for k in 0 to 6 loop
			exit when k = 7-n;
				if (ELE1(k+n)='1' or CALL1U(k+n)='1') then
					memory(i) <= k+n;
					i := i + 1;
				end if;	
			end loop mem_add_up4;
			mem_add_down40 : for k in 0 to 6 loop
			exit when k = 7-n;
			if(CALL1D(6-k)='1') then
				memory(i) <= 6-k;
				i := i+1;
			end if;
			end loop mem_add_down40;
			count <= i;
			i := 0;
		elsif(n = memory(0)) then
			mem_shift : for k in 0 to 6 loop
			exit when k = count-1;
				memory(k) <= memory(k+1);					
			end loop mem_shift;
			count <= count-1;	
		end if;	
end process;

process(counter, count, memory, ELE1, CALL1U, CALL1D,n)
begin
 if (rising_edge(counter)) then
 if (em_stop = '1') then
	q <= n;
 else	
 if (count = 0) then
	if (ELE1 = "0000000" and CALL1U="0000000" and CALL1D="0000000") then
		q <= 7;
	else
		q <= n;
	end if;
 else
	q <= memory(0);
 end if;
 end if;
 end if;
end process;

process(pst, q)
begin
	fl <= pst;
	case pst is
		when "000" =>
			if (q = 0) then
				nst <= pst;
			elsif (q = 1) then
				nst <= "001";
			elsif (q = 2) then
				nst <= "001";
			elsif (q = 3) then
				nst <= "001";
			elsif (q = 4) then
				nst <= "001";
			elsif (q = 5) then
				nst <= "001";
			elsif (q = 6) then
				nst <= "001";
			elsif (q = 7) then
				nst <= "000";
			end if;

		when "001" =>
			if (q = 0) then
				nst <= "000";
			elsif (q = 1) then
				nst <= pst;
			elsif (q = 2) then
				nst <= "010";
			elsif (q = 3) then
				nst <= "010";
			elsif (q = 4) then
				nst <= "010";
			elsif (q = 5) then
				nst <= "010";
			elsif (q = 6) then
				nst <= "010";
			elsif (q = 7) then
				nst <= "000";
			end if;
		
		when "010" =>
			if (q = 0) then
				nst <= "001";
			elsif (q = 1) then
				nst <= "001";
			elsif (q = 2) then
				nst <= pst;
			elsif (q = 3) then
				nst <= "011";
			elsif (q = 4) then
				nst <= "011";
			elsif (q = 5) then
				nst <= "011";
			elsif (q = 6) then
				nst <= "011";
			elsif (q = 7) then
				nst <= "001";
			end if;

		when "011" =>
			if (q = 0) then
				nst <= "010";
			elsif (q = 1) then
				nst <= "010";
			elsif (q = 2) then
				nst <= "010";
			elsif (q = 3) then
				nst <= pst;
			elsif (q = 4) then
				nst <= "100";
			elsif (q = 5) then
				nst <= "100";
			elsif (q = 6) then
				nst <= "100";
			elsif (q = 7) then
				nst <= "010";
			end if;
				
		when "100" =>
			if (q = 0) then
				nst <= "011";
			elsif (q = 1) then
				nst <= "011";
			elsif (q = 2) then
				nst <= "011";
			elsif (q = 3) then
				nst <= "011";
			elsif (q = 4) then
				nst <= pst;
			elsif (q = 5) then
				nst <= "101";
			elsif (q = 6) then
				nst <= "101";
			elsif (q = 7) then
				nst <= "011";
			end if;

		when "101" =>
			if (q = 0) then
				nst <= "100";
			elsif (q = 1) then
				nst <= "100";
			elsif (q = 2) then
				nst <= "100";
			elsif (q = 3) then
				nst <= "100";
			elsif (q = 4) then
				nst <= "100";
			elsif (q = 5) then
				nst <= pst;
			elsif (q = 6) then
				nst <= "110";
			elsif (q = 7) then
				nst <= "100";
			end if;
				
		when "110" =>
			if (q = 0) then
				nst <= "101";
			elsif (q = 1) then
				nst <= "101";
			elsif (q = 2) then
				nst <= "101";
			elsif (q = 3) then
				nst <= "101";
			elsif (q = 4) then
				nst <= "101";
			elsif (q = 5) then
				nst <= "101";
			elsif (q = 6) then
				nst <= pst;
			elsif (q = 7) then
				nst <= "101";
			end if;
		when others =>
			nst <= "000";
	end case;				
end process;
end Behavioral;

