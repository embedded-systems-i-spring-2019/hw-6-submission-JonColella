library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h6p2 is
    port (X1, X2, clk : in std_logic;
          Y0, Y1, Z : out std_logic);
end h6p2;

architecture Behavioral of h6p2 is
type state_type is (ST1, ST2, ST3);
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
        Z <= '0';
        case PS is
            when ST1 =>
                Y0 <= '1';
                Y1 <= '0';
                if (X2 = '1') then
                    NS <= ST3;
                    Z <= '0';
                else
                    NS <= ST2;
                    Z <= '1';
                end if;
                
            when ST2 =>
                Y0 <= '0';
                Y1 <= '1';
                if (X1 = '1') then
                    NS <= ST1;
                    Z <= '0';
                else
                    NS <= ST2;
                    Z <= '1';
                end if;
                
            when ST3 =>
                Y0 <= '1';
                Y1 <= '1';
                if (X2 = '1') then
                    NS <= ST3;
                    Z <= '0';
                else
                    NS <= ST2;
                    Z <= '1';
                end if;
            
        end case;
    end process comb;
end Behavioral;
