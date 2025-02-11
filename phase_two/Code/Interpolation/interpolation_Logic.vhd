LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Interpolation_Logic is
    generic (width:integer:=16);
  port (
    Un,Uz,DivResult : IN std_logic_vector(width-1 downto 0);
    EN :IN std_logic;
    Uk: OUT std_logic_vector(width-1 downto 0)
  ) ;
end Interpolation_Logic;
architecture Interpolation_LogicArch of Interpolation_Logic is
    signal temp,UnComp,Uz_Un,secondOperand,UkSignal:std_logic_vector(width-1 downto 0);
    signal Mul_OVF:std_logic;
    begin

temp<= not Un;      
add1:entity work.Carry_Look_Ahead(Behavioral) port map(A=>temp,B=>(others=>'0'),Cin=>'1',S=>UnComp);
Sub:entity work.Carry_Look_Ahead(Behavioral) port map(A=>Uz,B=>UnComp,Cin=>'0',S=>Uz_Un);
mul:entity work.booth_multiplier port map(m=>DivResult,r=>Uz_Un,result=>secondOperand,overflow=>Mul_OVF);
add:entity work.Carry_Look_Ahead(Behavioral) port map(A=>Un,B=>secondOperand,Cin=>'0',S=>Uk);
-- Uk <= UkSignal when EN ='1' 
-- else (others=>'Z');
end Interpolation_LogicArch ; 