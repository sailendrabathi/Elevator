--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:19:31 03/20/2019
-- Design Name:   
-- Module Name:   /home/labuser/GL5_1/elevator_tb.vhd
-- Project Name:  GL5_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: elevator
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY elevator_tb IS
END elevator_tb;
 
ARCHITECTURE behavior OF elevator_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT elevator
    PORT(
         valid : IN  std_logic;
         em_stop : IN  std_logic;
         clk : IN  std_logic;
         ELE : IN  std_logic_vector(6 downto 0);
         F0 : IN  std_logic_vector(1 downto 0);
         F1 : IN  std_logic_vector(1 downto 0);
         F2 : IN  std_logic_vector(1 downto 0);
         F3 : IN  std_logic_vector(1 downto 0);
         F4 : IN  std_logic_vector(1 downto 0);
         F5 : IN  std_logic_vector(1 downto 0);
         F6 : IN  std_logic_vector(1 downto 0);
         fl : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal valid : std_logic := '0';
   signal em_stop : std_logic := '0';
   signal clk : std_logic := '0';
   signal ELE : std_logic_vector(6 downto 0) := (others => '0');
   signal F0 : std_logic_vector(1 downto 0) := (others => '0');
   signal F1 : std_logic_vector(1 downto 0) := (others => '0');
   signal F2 : std_logic_vector(1 downto 0) := (others => '0');
   signal F3 : std_logic_vector(1 downto 0) := (others => '0');
   signal F4 : std_logic_vector(1 downto 0) := (others => '0');
   signal F5 : std_logic_vector(1 downto 0) := (others => '0');
   signal F6 : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal fl : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: elevator PORT MAP (
          valid => valid,
          em_stop => em_stop,
          clk => clk,
          ELE => ELE,
          F0 => F0,
          F1 => F1,
          F2 => F2,
          F3 => F3,
          F4 => F4,
          F5 => F5,
          F6 => F6,
          fl => fl
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
    

      -- insert stimulus here 
		valid <= '1';
		ELE <= "0100000";
		F6 <= "00";
		F5 <= "00";
		F4 <= "10";
		F3 <= "01";
		F2 <= "00";
		F1 <= "00";
		F0 <= "00";
		wait for 50 ns;
		valid <= '0';
		wait for 50 ns;
		
		valid <= '1';
		ELE <= "1000000";
		F6 <= "00";
		F5 <= "00";
		F4 <= "00";
		F3 <= "00";
		F2 <= "00";
		F1 <= "00";
		F0 <= "00";
		wait for 50 ns;
		valid <= '0';
		wait for 50 ns;
		
		valid <= '1';
		ELE <= "0000000";
		F6 <= "00";
		F5 <= "00";
		F4 <= "00";
		F3 <= "00";
		F2 <= "00";
		F1 <= "00";
		F0 <= "00";
		wait for 50 ns;
		valid <= '0';
		wait for 150 ns;
		
		valid <= '1';
		ELE <= "1000000";
		F6 <= "00";
		F5 <= "00";
		F4 <= "00";
		F3 <= "00";
		F2 <= "00";
		F1 <= "00";
		F0 <= "00";
		wait for 100 ns;
		
		valid <= '1';
		ELE <= "0000000";
		F6 <= "00";
		F5 <= "00";
		F4 <= "00";
		F3 <= "00";
		F2 <= "00";
		F1 <= "00";
		F0 <= "00";
		wait for 100 ns;
		
		valid <= '1';
		ELE <= "0000000";
		F6 <= "00";
		F5 <= "00";
		F4 <= "00";
		F3 <= "00";
		F2 <= "00";
		F1 <= "00";
		F0 <= "00";
		wait for 300 ns;
		
		valid <= '1';
		ELE <= "0000010";
		F6 <= "00";
		F5 <= "00";
		F4 <= "00";
		F3 <= "00";
		F2 <= "00";
		F1 <= "00";
		F0 <= "00";
		wait for 500 ns ;
		
		valid <= '1';
		ELE <= "0000000";
		F6 <= "00";
		F5 <= "00";
		F4 <= "00";
		F3 <= "00";
		F2 <= "00";
		F1 <= "00";
		F0 <= "00";

      wait;
   end process;

END;