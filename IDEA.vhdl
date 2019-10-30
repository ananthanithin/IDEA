library IEEE;

use IEEE.STD_LOGIC_1164.ALL; entity idea is

Port ( X1 : in STD_LOGIC_VECTOR (15 downto 0); X2 : in STD_LOGIC_VECTOR (15 downto 0); X3 : in STD_LOGIC_VECTOR (15 downto 0); X4 : in STD_LOGIC_VECTOR (15 downto 0); key : in STD_LOGIC_VECTOR (127 downto 0); Y1 : out STD_LOGIC_VECTOR (15 downto 0); Y2 : out STD_LOGIC_VECTOR (15 downto 0); Y3 : out STD_LOGIC_VECTOR (15 downto 0); Y4 : out STD_LOGIC_VECTOR (15 downto 0));

end idea;

architecture Behavioral of idea is component round is

Port ( I1 : in STD_LOGIC_VECTOR (15 downto 0); I2 : in STD_LOGIC_VECTOR (15 downto 0);

I3 : in STD_LOGIC_VECTOR (15 downto 0); I4 : in STD_LOGIC_VECTOR (15 downto 0);

Z1	: in	STD_LOGIC_VECTOR (15	downto 0);
Z2 : in	STD_LOGIC_VECTOR (15 downto 0);
Z3	: in	STD_LOGIC_VECTOR (15	downto 0);
Z4 : in	STD_LOGIC_VECTOR (15 downto 0);
Z5	: in	STD_LOGIC_VECTOR (15	downto 0);
Z6	: in	STD_LOGIC_VECTOR (15	downto 0);

Y1 : out STD_LOGIC_VECTOR (15 downto 0); Y2 : out STD_LOGIC_VECTOR (15 downto 0);

Y3 : out STD_LOGIC_VECTOR (15 downto 0); Y4 : out STD_LOGIC_VECTOR (15 downto 0));

end component round;

component trafo is

Port ( X1 : in STD_LOGIC_VECTOR (15 downto 0); X2 : in STD_LOGIC_VECTOR (15 downto 0); X3 : in STD_LOGIC_VECTOR (15 downto 0); X4 : in STD_LOGIC_VECTOR (15 downto 0); Z1 : in STD_LOGIC_VECTOR (15 downto 0); Z2 : in STD_LOGIC_VECTOR (15 downto 0); Z3 : in STD_LOGIC_VECTOR (15 downto 0); Z4 : in STD_LOGIC_VECTOR (15 downto 0); Y1 : out STD_LOGIC_VECTOR (15 downto 0); Y2 : out STD_LOGIC_VECTOR (15 downto 0); Y3 : out STD_LOGIC_VECTOR (15 downto 0); Y4 : out STD_LOGIC_VECTOR (15 downto 0));



 
end component trafo;

TYPE partial_keys_array IS ARRAY(51 downto 0) OF std_logic_vector(15 downto 0);

SIGNAL partial_keys : partial_keys_array;

signal A1, A2, A3, A4, B1, B2, B3, B4, C1, C2, C3, C4, D1, D2, D3, D4, E1, E2, E3, E4, F1, F2, F3, F4, G1, G2, G3, G4, H1, H2, H3, H4 : STD_LOGIC_VECTOR (15 downto 0);

begin

generator : process(key)

variable temp_key : std_logic_vector(127 downto 0); variable idx : integer range 0 to 51;
begin

idx := 0; temp_key := key; for i in 0 to 5 loop

for j in 0 to 7 loop

partial_keys(idx) <= temp_key(127-j*16 downto 112-j*16); idx := idx+1;
end loop;
-- barrel switch by 25

temp_key := temp_key(102 downto 0) & temp_key(127 downto 103); end loop;

for j in 0 to 3 loop

partial_keys(idx) <= temp_key(127-j*16 downto 112-j*16); idx := idx+1;

end loop; end process;

r1 : round port map (
I1 => X1,
I2 => X2,
I3 => X3,
I4 => X4,

Z1 => partial_keys(0),
Z2 => partial_keys(1),
Z3 => partial_keys(2),
Z4 => partial_keys(3),
Z5 => partial_keys(4),
Z6 => partial_keys(5),
Y1 => A1,
Y2 => A2,



 
Y3 => A3,

Y4 => A4);

r2 : round port map (
I1 => A1,
I2 => A2,

I3 => A3,

I4 => A4,

Z1 => partial_keys(6),
Z2 => partial_keys(7),
Z3 => partial_keys(8),

Z4 => partial_keys(9),

Z5 => partial_keys(10),

Z6 => partial_keys(11),

Y1 => B1,

Y2 => B2,
Y3 => B3,
Y4 => B4);

r3 : round port map (
I1 => B1,
I2 => B2,
I3 => B3,
I4 => B4,

Z1 => partial_keys(12),
Z2 => partial_keys(13),
Z3 => partial_keys(14),
Z4 => partial_keys(15),
Z5 => partial_keys(16),
Z6 => partial_keys(17),

Y1 => C1,
Y2 => C2,
Y3 => C3,
Y4 => C4);

r4 : round port map (
I1 => C1,
I2 => C2,

I3 => C3,
I4 => C4,

Z1 => partial_keys(18),
Z2 => partial_keys(19),
Z3 => partial_keys(20),
Z4 => partial_keys(21),
Z5 => partial_keys(22),


 
Z6 => partial_keys(23),

Y1 => D1,

Y2 => D2,
Y3 => D3,
Y4 => D4);

r5 : round port map (

I1 => D1,

I2 => D2,
I3 => D3,
I4 => D4,

Z1 => partial_keys(24),

Z2 => partial_keys(25),

Z3 => partial_keys(26),
Z4 => partial_keys(27),
Z5 => partial_keys(28),
Z6 => partial_keys(29),

Y1 => E1,
Y2 => E2,
Y3 => E3,
Y4 => E4);

r6 : round port map (
I1 => E1,

I2 => E2,
I3 => E3,
I4 => E4,

Z1 => partial_keys(30),
Z2 => partial_keys(31),
Z3 => partial_keys(32),
Z4 => partial_keys(33),
Z5 => partial_keys(34),
Z6 => partial_keys(35),

Y1 => F1,
Y2 => F2,
Y3 => F3,
Y4 => F4);

r7 : round port map (
I1 => F1,
I2 => F2,
I3 => F3,
I4 => F4,

Z1 => partial_keys(36),



 
Z2 => partial_keys(37),

Z3 => partial_keys(38),

Z4 => partial_keys(39),

Z5 => partial_keys(40),
Z6 => partial_keys(41),

Y1 => G1,

Y2 => G2,

Y3 => G3,

Y4 => G4);


r8 : round port map (

I1 => G1,

I2 => G2,

I3 => G3,
I4 => G4,

Z1 => partial_keys(42),
Z2 => partial_keys(43),
Z3 => partial_keys(44),
Z4 => partial_keys(45),
Z5 => partial_keys(46),
Z6 => partial_keys(47),

Y1 => H1,
Y2 => H2,

Y3 => H3,
Y4 => H4);

t: trafo port map ( X1 => H1,

X2 => H2,
X3 => H3,
X4 => H4,

Z1 => partial_keys(48),
Z2 => partial_keys(49),
Z3 => partial_keys(50),
Z4 => partial_keys(51),

Y1 => Y1,
Y2 => Y2,
Y3 => Y3,

Y4 => Y4); end Behavioral;



 


ADDER:

library IEEE;

use IEEE.STD_LOGIC_1164.ALL; use IEEE.STD_LOGIC_ARITH.ALL; use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity addop is

Port ( A : in STD_LOGIC_VECTOR (15 downto 0); B : in STD_LOGIC_VECTOR (15 downto 0); Z : out STD_LOGIC_VECTOR (15 downto 0));

end addop;

architecture Behavioral of addop is begin

Z <= A + B; end Behavioral;


MULTIPLICATION:

library IEEE;

use IEEE.STD_LOGIC_1164.ALL; use IEEE.STD_LOGIC_ARITH.ALL; use IEEE.STD_LOGIC_UNSIGNED.ALL; use IEEE.NUMERIC_STD.ALL; entity mulop is

Port ( A : in STD_LOGIC_VECTOR (15 downto 0); B : in STD_LOGIC_VECTOR (15 downto 0); Z : out STD_LOGIC_VECTOR (15 downto 0));

end mulop;
architecture Behavioral of mulop is

signal AB : std_logic_vector (33 downto 0); signal AB_mod : std_logic_vector (15 downto 0); signal AB_div : std_logic_vector (15 downto 0); signal A2, B2 : std_logic_vector (16 downto 0); signal a_zero, b_zero : std_logic;

begin

zeros : process(A, B) begin

if A = "0000000000000000" then A2 <= '1' & A;
else

A2 <= '0' & A; end if;

if B = "0000000000000000" then B2 <= '1' & B;



 
else

B2 <= '0' & B; end if;

end process; AB <= A2 * B2;

AB_mod <= AB(15 downto 0); AB_div <= AB(31 downto 16);

result : process(AB_mod, AB_div)

variable res : std_logic_vector(31 downto 0); begin

res := "0000000000000000" & (AB_mod - AB_div); if AB_mod < AB_div then
res := res + "00000000000000010000000000000001";

elsif A = "0000000000000000" and B = "0000000000000000" then res := "00000000000000000000000000000001";
end if;

Z <= res(15 downto 0); end process;
end Behavioral;




XOR:

library IEEE;

use IEEE.STD_LOGIC_1164.ALL; entity xorop is

Port ( A : in STD_LOGIC_VECTOR (15 downto 0); B : in STD_LOGIC_VECTOR (15 downto 0); O : out STD_LOGIC_VECTOR (15 downto 0));

end xorop;

architecture Behavioral of xorop is begin

O <= A xor B; end Behavioral;
