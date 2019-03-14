library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h6p4 is
    port (X1, X2, clk, init : in std_logic;
          Z1 : out std_logic);
end h6p4;

architecture Behavioral of h6p4 is
type state_type is (ST1, ST2, ST3);
signal PS, NS : state_type;
begin
    sync: process(clk)
    begin
        if (rising_edge(clk)) then
        if (init = '1') then
        PS <= ST1;
        else
        PS <= NS;
        end if;
    end process sync;
    
    comb: process(PS)
    begin
        Z1 <= '0';
        case PS is
            when ST1 =>
                if (X1 = '1') then
                    NS <= ST2;
                    Z2 <= '1';
                else
                    NS <= ST3;
                    Z1 <= '0';
                end if;
                
            when ST2 =>
                if (X2 = '1') then
                    NS <= ST1;
                    Z2 <= '0';
                else
                    NS <= ST3;
                    Z2 <= '1';
                end if;
                
            when ST3 =>
                if (X1 = '1') then
                    NS <= ST2;
                    Z2 <= '1';
                else
                    NS <= ST1;
                    Z2 <= '1';
                end if;
            
        end case;
    end process comb;
end Behavioral;
