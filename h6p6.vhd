library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h6p6 is
    port (X, clk : in std_logic;
          Z1, Z2: out std_logic
          state : out std_logic_vector (1 downto 0));
end h6p6;

architecture Behavioral of h6p6 is
type state_type is (ST0, ST1, ST2, ST3);
signal PS, NS : state_type;
begin
    sync: process(clk)
    begin
        if (rising_edge(clk)) then
        PS <= NS;
        end if;
    end process sync;
    
    comb: process(PS)
    begin
        Z1 <= '0';
        case PS is
            when ST0 =>
                state <= "00";
                Z1 <= '1';
                if (X = '1') then
                    NS <= ST0;
                    Z2 <= '0';
                else
                    NS <= ST2;
                    Z2 <= '0';
                end if;

            when ST1 =>
                state <= "01";
                Z1 <= '0';
                if (X = '1') then
                    NS <= ST1;
                    Z2 <= '0';
                else
                    NS <= ST3;
                    Z2 <= '0';
                end if;
                
            when ST2 =>
                state <= "10";
                Z1 <= '1';
                if (X = '1') then
                    NS <= ST0;
                    Z2 <= '0';
                else
                    NS <= ST1;
                    Z2 <= '0';
                end if;
                
            when ST3 =>
                state <= "11";
                Z1 <= '0';
                if (X = '1') then
                    NS <= ST1;
                    Z2 <= '0';
                else
                    NS <= ST0;
                    Z2 <= '1';
                end if;
            
        end case;
    end process comb;
end Behavioral;
