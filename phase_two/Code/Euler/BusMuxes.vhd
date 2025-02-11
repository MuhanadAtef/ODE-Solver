library ieee;
use ieee.std_logic_1164.all;

Entity M1Add1Mux is
	generic (num : integer := 16);
	port( Init, E, Ti, A, Xstore, XS1, XS2: IN std_logic_vector (num-1 downto 0);
	      selector: IN std_logic_vector (2 downto 0);
	      Var1, Var2, Var3: In std_logic ;
	      Add:      OUT std_logic_vector (num-1 downto 0));
end  M1Add1Mux;

Architecture behavioral of M1Add1Mux is

begin
	process (selector)
		begin 
			if selector = "001" then Add <= Init; 
			elsif selector = "010" then Add <= E;
			elsif selector = "011" then Add <= Ti;
			elsif selector = "100" then Add <= A;
			elsif selector = "110" then 
				if Var1 ='0' and Var2 = '0' and Var3 ='0' then Add <= Xstore;
				elsif Var1 ='1' and Var2 ='0' and Var3 = '0' then Add <= XS1;
				elsif Var1 ='0' and Var2 ='1' and Var3 = '0' then Add <= XS2; 
				else Add <= (others=>'0'); end if;
			elsif selector = "111" then Add <= XS1;
			else Add <= (others=>'0');
			end if;
		end process;
end Architecture;

library ieee;
use ieee.std_logic_1164.all;

Entity M1Add2Mux is
	generic (n : integer := 16);
	port(H,Xn, Xprev, Xs2 : IN std_logic_vector (n-1 downto 0);
	      selector: IN std_logic_vector (2 downto 0);
	      Add:      OUT std_logic_vector (n-1 downto 0));
end  M1Add2Mux;

Architecture behavioral of M1Add2Mux is

begin
	process (selector)
		begin 
			if selector = "010" then Add <= H;
			elsif selector = "100" then Add <= Xn;
			elsif selector = "110" then Add <= Xprev;
			elsif selector = "111" then Add <= Xs2;
			else Add <= (others=>'0');
			end if;
		end process;
end Architecture;

library ieee;
use ieee.std_logic_1164.all;
	
Entity M2Add1Mux is
	generic (n : integer := 16);
	port(Ucalc, Un, Ustore : IN std_logic_vector (n-1 downto 0);
	      selector: IN std_logic_vector (2 downto 0);
	      firstRaw: IN std_logic;
	      Add:      OUT std_logic_vector (n-1 downto 0));
end  M2Add1Mux;

Architecture Address of M2Add1Mux is

begin
	process (selector)
		begin 
			if selector = "100" then
				if firstRaw= '0' then Add <= Ucalc; else Add <= Un; end if;
			elsif selector = "101" then Add <= Ustore;
			else Add <= (others=>'0');
			end if;
		end process;
end Architecture;

library ieee;
use ieee.std_logic_1164.all;
	
Entity M2Add2Mux is
	generic (n : integer := 16);
	port(B, Uz : IN std_logic_vector (n-1 downto 0);
	      selector: IN std_logic_vector (2 downto 0);
	      firstRaw: IN std_logic;
	      Add:      OUT std_logic_vector (n-1 downto 0));
end  M2Add2Mux;

Architecture Address of M2Add2Mux is

begin
	process (selector)
		begin 
			if selector = "100" then
				if firstRaw= '0' then Add <= B; else Add <= Uz; end if;
			else Add <= (others=>'0');
			end if;
		end process;
end Architecture;

library ieee;
use ieee.std_logic_1164.all;
	
Entity twoInpMux is
	generic (n : integer := 16);
	port(In0, In1: IN std_logic_vector (n-1 downto 0);
	      selector: IN std_logic;
	      out1:      OUT std_logic_vector (n-1 downto 0));
end  twoInpMux;

Architecture seq of twoInpMux is
begin
	out1 <= In0 when selector = '0' else In1;
end Architecture;

library ieee;
use ieee.std_logic_1164.all;
	
Entity TimeMux is
	generic (n : integer := 16);
	port(half_h, h, h_new: IN std_logic_vector (n-1 downto 0);
	      Var1,Var2,Var3, Var4, Var5: IN std_logic;
	      Plus: out std_logic;
	      out1:      OUT std_logic_vector (n-1 downto 0));
end  TimeMux;

Architecture seq of TimeMux is
begin
	process(Var1, Var2, Var3, Var4, Var5)
		begin
			if Var1 ='0' and Var2 ='0' and Var3 ='0' and Var4 ='0' and Var5 ='0' then plus <='0'; out1 <= h; 
			elsif Var1 = '1' then plus <= '0'; out1 <= half_h;
			elsif Var2 = '0' then plus <='1'; out1<= half_h;
			elsif Var3 = '0' then plus <= '1'; out1 <="0000000000000000";
			else plus <= '1'; out1 <= h;
			end if;
		end process;
end Architecture;
