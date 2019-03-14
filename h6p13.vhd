library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h6p13 is
    port (X1, X2, clk : in std_logic;
          CS, RD: out std_logic
          Y : out std_logic_vector (2 downto 0)); --one-hot encoding
end h6p13;

architecture Behavioral of h6p13 is
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
        CS <= '0';
        RD <= '0';
        case PS is

            when ST1 =>
               Y <= "001";
                if (X1 = '1') then
                    NS <= ST3;
                    CS <= '1';
                    RD <= '0';
                else
                    NS <= ST2;
                    CS <= '0';
                    RD <= '1';
                end if;
                
            when ST2 =>
                Y <= "010";
                    NS <= ST3;
                    CS <= '1';
                    RD <= '1';
                
            when ST3 =>
                Y <= "100";
                if (X2 = '1') then
                    NS <= ST3;
                    CS <= '0';
                    RD <= '1';
                else
                    NS <= ST1;
                    CS <= '0';
                    RD <= '0';
                end if;
            
        end case;
    end process comb;
end Behavioral;
