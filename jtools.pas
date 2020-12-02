unit jtools; 
{
Unit by Jeremy Reyes, Venezuela, Nueva Esparta 2020®
For contact or any code improvement :
jeremyreyes017@gmail.com
}
//Free to use anywhere but only with respective credits to me


interface


const
  version = '3.5a';

function stn(z: string) : real;
//String to number(Real).

//Before using, Consider the 8 number limit that Pascal have before writting an E plus a number.

function DV(a: real) : Integer;
//Decimal Verificator

{
0 = No value on input.
1 = Not a Decimal value.
2 = Decimal Value;
}
procedure writenum(num: real;
decimal, con: integer); 
//Write number

//A command that simplify the Output process of a real number, for example:

{
Input / Output
20.00 = 20
20.01 = 20.01
}
function nump(num: real;
modeselector: string) : integer; 
//Num Properties

//A function with multiples modes that output few properties of a given number

{
mode = a
1xx = negativo
2xx = positivo
  
mode = b
x1x = Odd 
x2x = Even

mode = c
xx1 = Entero
xx2 = decimal

mode = abc
all modes

error = 0
}
function StrNumVer(num: string) : integer;
//In-String Number Verification

//A function that output the characteristics of a number inside a string variable

{
1 = Positive
2 = Negative
3 = Positive with Decimals
4 = Negative with Decimals
6 = The String is Only 0's

5 = Not a only valid number variable

}
function jtoolsversion: string;

implementation


uses
  crt, math;

function jtoolsversion: string;

begin
  jtoolsversion := version;
end; 

function stn(z: string) : real;

var
  a, b, count, decimal: integer;
  s: string;
  dec_set, nega: Boolean;


begin
  count := 0;
  b := length(z);
  for a := 1 to b do 
    begin
      s := copy(z, a, 1);
      if s = '1' then
        count := count + 1  
      else if s = '2' then
        count := count + 1  
      else if s = '3' then
        count := count + 1  
      else if s = '4' then
        count := count + 1  
      else if s = '5' then
        count := count + 1  
      else if s = '6' then
        count := count + 1  
      else if s = '7' then
        count := count + 1  
      else if s = '8' then
        count := count + 1  
      else if s = '9' then
        count := count + 1  
      else if s = '0' then
        count := count + 1 ;
    end;
  for a := 1 to b do 
    begin
      count := count - 1;
      s := copy(z, a, 1);
      if s = '0' then continue
      else if s = '1' then
        stn := stn + (1 * (power(10, count)))  
      else if s = '2' then
        stn := stn + (2 * (power(10, count)))  
      else if s = '3' then
        stn := stn + (3 * (power(10, count)))  
      else if s = '4' then
        stn := stn + (4 * (power(10, count)))  
      else if s = '5' then
        stn := stn + (5 * (power(10, count)))  
      else if s = '6' then
        stn := stn + (6 * (power(10, count)))  
      else if s = '7' then
        stn := stn + (7 * (power(10, count)))  
      else if s = '8' then
        stn := stn + (8 * (power(10, count)))  
      else if s = '9' then
        stn := stn + (9 * (power(10, count)))  
      else if s = ',' then
          if dec_set = false then
            begin
              count := count + 1;
              decimal := count;
              dec_set := true;
            end 
      else continue 
      else
      if s = '.' then
          if dec_set = false then
            begin
              count := count + 1;
              decimal := count;
              dec_set := true;
        end else continue
      else if s = '-' then
        if a = 1 then
          begin
            nega := true;
            count := count + 1;
          end 
        else 
          continue
        else
        count:= count+1;
    end;
  if dec_set = true then
    stn := stn / (power(10, decimal)) ;
  if nega = true then
    stn := stn * - 1 ;
end; 

function DV(a: real) : Integer;

begin
  if a <> 0 then
    begin
      if a < 0 then
        a := a * - 1 ;
      if round(a) = a then
        dv := 1  
      else 
        dv := 2;
    end 
  else 
    dv := 0;
end;
procedure writenum(num: real;
decimal, con: integer); 

var
  temp, temp2, i: integer;


begin
  temp := dv(num);
  temp2 := trunc(num);
  case temp of 
    1:     case con of 
      1: write(temp2);
      2: writeln(temp2);
      else write('The third parameter is invalid');
    end;
    2:     case con of 
      1: if decimal = 1 then
        write(num)  
      else 
        write(temp2);
      2: if decimal = 1 then
        writeln(num)  
      else 
        writeln(temp2);
      else write('The Third parameter is invalid');
    end;
    else     case con of 
      1: write(0);
      2: writeln(0);
      else write('The third parameter is invalid');
    end;
  end;
end; 

function nump(num: real;
modeselector: string) : integer; 

const
  modes = 3;


var
  temp, i: integer;
  tempb: boolean;
  mode: array [1..modes] of string;
  EnableMode: array [1..modes] of boolean;


begin
if num<>0 then begin 
  mode[1] := 'a';
  //Positive / Negative Verificator 
  mode[2] := 'b';
  //Odd / Even Verificator
  mode[3] := 'c';
  //Decimal Verificator
  for i := 1 to modes do 
    begin
      temp := pos(mode[i], modeselector);
      if temp >= 1 then
        EnableMode[i] := true ;
    end;
  if EnableMode[1] = true then
    if num < 0 then
      nump := nump + 100  
    else
      nump := nump + 200  ;
  if EnableMode[2] = true then
      if num < 0 then
        if odd(trunc(num * - 1)) = true then
          nump := nump + 10  
        else 
          nump := nump + 20 
          else
      if odd(trunc(num)) = true then
        nump := nump + 10  
      else 
        nump := nump + 20 ;
        
  if EnableMode[3] = true then
      if round(num) = num then
        nump := nump + 1  
      else 
        nump := nump + 2  ;
end;
end;

function StrNumVer(num: string) : integer;

var
  temp, i: integer;
  temp2: real;
  mixed, decimal, positive, negative, symbol, onv, onlyzero: boolean;
  s: string;


begin
  temp := length(num);
  for i := 1 to temp do 
    begin
      s := copy(num, i, 1);
      if s = '+' then
        if i = 1 then
          begin
            onv := true;
            positive := true;
            negative := false;
            symbol := true;
          end 
        else 
          mixed := true else if s = '-' then
          if i = 1 then
            begin
              onv := true;
              negative := true;
              positive := false;
              symbol := true;
            end 
          else 
            mixed := true else if s = '0' then
            onv := true  
          else if s = '1' then
            onv := true  
          else if s = '2' then
            onv := true  
          else if s = '3' then
            onv := true  
          else if s = '4' then
            onv := true  
          else if s = '5' then
            onv := true  
          else if s = '6' then
            onv := true  
          else if s = '7' then
            onv := true  
          else if s = '8' then
            onv := true  
          else if s = '9' then
            onv := true  
          else if s = '.' then
            if decimal = false then
              if symbol = true then
                if I >= 3 then
                  begin
                    decimal := true;
                    ONV := true;
                  end 
                else 
                  mixed := true else if i >= 2 then
                  begin
                    decimal := true;
                    ONV := true;
                  end 
                else 
                  mixed := true else mixed := true else mixed := true     ;
      if mixed = true then
        begin
          onv := false;
          break ;
        end ;
    end;
  temp2 := stn(num);
  if temp2 > 0 then
    positive := true  
  else if temp2 = 0 then
    begin
      onlyzero := true;
      positive := false;
      negative := false;
    end 
  else 
    negative := true;
  if onv = true then
    if onlyzero = false then
      begin
        if positive = true then
          if decimal = true then
            strnumver := 3  
          else 
            strnumver := 1 ;
        if negative = true then
          if decimal = true then
            strnumver := 4  
          else 
            StrNumVer := 2 ;
      end 
    else 
      StrNumVer := 6 else StrNumVer := 5 ;
end; 
end.
