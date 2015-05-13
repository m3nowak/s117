uses dos,crt;
var a:array [1..9, 1..9, 1..9] of boolean; //glowna tablica
    b:integer; //bufor na klawisze
    c:array [1..9,1..9] of byte;//tablica do wprowadzania
    d:array [1..9,1..9] of byte;//tablica do wyswietlania
    w,v,y,x,z:integer;//do petli
    p,q:byte;//pozycja wskaznika
    p0,q0:byte;//stara pozycja wskaznika
function wrk:integer; //funkcja do czytania klawiszy
var wrk0:char;
    wrk1:integer;
begin
 wrk1:=0;
 wrk0:=Readkey; 
 if ord(wrk0)=0
 then begin
  wrk1:=1000;
  wrk0:=Readkey;   
 end;    
 wrk1:=ord(wrk0)+wrk1;
 wrk:=wrk1;
end;

procedure liczenie;
begin
 for x:=1 to 9 do
  for y:=1 to 9 do
   for z:=1 to 9 do a[x][y][z]:=true;
 for x:=1 to 9 do
  for y:=1 to 9 do d[x][y]:=0;
 for x:=1 to 9 do
  for y:=1 to 9 do d[x][y]:=c[x][y]; 
 
 for x:=1 to 9 do
  for y:=1 to 9 do if d[x][y]<>0 then begin
   for w:=1 to 9 do a[x][y][w]:=false;
   a[x][y][d[x][y]]:=true;
  end;
  
  
 for z:=1 to 82 do begin
  for x:=1 to 9 do
   for y:=1 to 9 do if d[x][y]<>0 then begin
    for w:=1 to 9 do a[x][w][d[x][y]]:=false;
    a[x][y][d[x][y]]:=true;
   end;
   
  for y:=1 to 9 do
   for x:=1 to 9 do if d[x][y]<>0 then begin
    for w:=1 to 9  do a[w][y][d[x][y]]:=false;
    a[x][y][d[x][y]]:=true;
   end;
  
  for x:=1 to 9 do
   for y:=1 to 9 do if d[x][y]<>0 then 
    for w:=1 to 9 do
     for v:=1 to 9 do
      if ((w-1) div 3 = (x-1) div 3) and ((v-1) div 3 = (y-1) div 3) then begin a[w][v][d[x][y]]:=false;
       a[x][y][d[x][y]]:=true;
      end;
 
  for x:=1 to 9 do
   for y:=1 to 9 do begin
    v:=0;
    for w:=1 to 9 do
     if a[x][y][w] then inc(v);
    if v=1 then for w:=1 to 9 do if a[x][y][w] then d[x][y]:=w;
   end;
   
  for x:=1 to 9 do
   for w:=1 to 9 do begin
    b:=0;
    for y:=1 to 9 do
     if a[x][y][w] then inc(b);
    if b=1 then for y:=1 to 9 do
     if a[x][y][w] then begin 
      d[x][y]:=w;
      for v:=1 to 9 do a[x][y][v]:=false;
      a[x][y][w]:=true;
     end;
   end;
   
  for y:=1 to 9 do
   for w:=1 to 9 do begin
    b:=0;
    for x:=1 to 9 do
     if a[x][y][w] then inc(b);
    if b=1 then for x:=1 to 9 do
     if a[x][y][w] then begin 
      d[x][y]:=w;
      for v:=1 to 9 do a[x][y][v]:=false;
      a[x][y][w]:=true;
     end;
   end;
     
  for v:=1 to 9 do
   for w:=1 to 9 do begin
    b:=0;
    for x:=1 to 9 do
     for y:=1 to 9 do
      if (a[x][y][w]) and (((v-1) mod 3)=((x-1) div 3)) and (((v-1) div 3)=((y-1) div 3)) then inc(b);
    if b=1 then
     for x:=1 to 9 do
      for y:=1 to 9 do
       if (a[x][y][w]) and (((v-1) mod 3)=((x-1) div 3)) and (((v-1) div 3)=((y-1) div 3)) then begin
        for p0:=1 to 9 do a[x][y][p0]:=false;
        a[x][y][w]:=true;
        d[x][y]:=w;
       end;
   end;
   
 end; 
  
end;

 
 
function spr:boolean;
var spr0:boolean;

procedure gam;
begin
 gotoxy(22+2*x,2+2*y);
 spr0:=false;
 textbackground(4);
 write(d[x][y]);
 gotoxy(30,23);
 textbackground(0);
end;

begin
 spr0:=true;
 for x:=1 to 9 do
  for y:=1 to 9 do begin
   for w:=1 to 9 do if (d[x][y]=d[x][w]) and (d[x][y]<>0) and (y<>w) then gam;
   for w:=1 to 9 do if (d[x][y]=d[w][y]) and (d[x][y]<>0) and (x<>w) then gam;
   for w:=1 to 9 do
    for v:=1 to 9 do if (d[x][y]=d[w][v]) and (d[x][y]<>0) and (((x-1) div 3) = ((w-1) div 3)) and (((y-1)div 3) = ((v-1) div 3)) and ((x<>w) and (y<>v)) then gam;
  end;
 spr:=spr0;

end;

begin
 for x:=1 to 9 do
  for y:=1 to 9 do c[x][y]:=0;
 
 clrscr;
 Writeln('Witaj w S117!');
 Writeln('Nacisnij ENT aby rozpoczac!');
 Writeln('Nacisnij ESC aby wyjsc!');
 repeat b:=wrk until (b=13) or (b=27);
 if b=27 then halt;
 Clrscr;
 Writeln('===S117=========================================================>');
 gotoxy(7,2);
 Writeln('WEJSCIE');
 gotoxy(29,2);
 Writeln('WYJSCIE');
 gotoxy(1,3);
 for y:=1 to 2 do begin 
  Write(#218);
  for v:=1 to 2 do begin
   for w:=1 to 5 do Write(#196);
   Write(#194);
  end;
  for w:=1 to 5 do Write(#196);
  write(#191);
  write('   ');
 end;
 
 gotoxy(1,4);
 for z:=1 to 2 do begin
  for w:=1 to 5 do writeln(#179+'     '+#179+'     '+#179+'     '+#179+'   '+#179+'     '+#179+'     '+#179+'     '+#179);

  for y:=1 to 2 do begin 
   Write(#195);
   for v:=1 to 2 do begin
    for w:=1 to 5 do Write(#196);
    Write(#197);
   end;
   for w:=1 to 5 do Write(#196);
   write(#180);
   write('   ');
  end;
  writeln;
 end;
 for w:=1 to 5 do writeln(#179+'     '+#179+'     '+#179+'     '+#179+'   '+#179+'     '+#179+'     '+#179+'     '+#179);
 
 for y:=1 to 2 do begin 
  Write(#192);
  for v:=1 to 2 do begin
   for w:=1 to 5 do Write(#196);
   Write(#193);
  end;
  for w:=1 to 5 do Write(#196);
  write(#217);
  write('   ');
 end;
 gotoxy(44,4);
 Write('ESC - Koniec');
 gotoxy(44,5);                        
 Write('ENT - Przelicz');
 gotoxy(44,6);
 Write('Strzalki - Kursor');
 gotoxy(44,7);
 Write('1-9 - Wprowadz wartosc');
 gotoxy(44,8);
 Write('0 - Usun wartosc');
 gotoxy(44,9);
 Write('HOME - Usun cale wejscie');
 gotoxy(44,10);
 Write('TAB - Przelicz + Pokaz mozliwe liczby');
 gotoxy(44,11);
 Write('C-Klonuj tab. wyj.');
 gotoxy(44,12);
 Write('F5-Sprawdz wynik');
 
 gotoxy(44,14);
 Write('TAB- , ');
 gotoxy(44,15);
 write(#218);
 for w:=1 to 5 do write(#196);
 write(#191);
 for w:=1 to 5 do begin
  gotoxy(44,15+w);
  write(#179+'     '+#179);
 end;
 gotoxy(44,21);
 write(#192);
 for w:=1 to 5 do write(#196);
 write(#217);
 
 
 
 p:=1;
 q:=1;
 gotoxy(2*p,2+2*q);
 TextBackground(1);
 write(' ');
 TextBackground(0);
 gotoxy(1,1);
 repeat 
  repeat
   b:=wrk;
  until (b=13) or (b=27) or (b=1072) or (b=1080) or (b=1075) or (b=1077) or ((b>47)and(b<58)) or (b=1071) or (b=9) or (b=99) or (b=67) or (b=1063);
  if b=27 then halt;
  if (b=1075) and (p<>1) then begin
   p0:=p;
   q0:=q;
   p:=p-1;
   gotoxy(2*p0,2+2*q0);
   TextBackground(0);
   if c[p0,q0]=0 then write(' ')
                 else write(c[p0,q0]);
   gotoxy(2*p,2+2*q);
   TextBackground(1);
   if c[p,q]=0 then write(' ')
                 else write(c[p,q]);
   gotoxy(1,1);
  end;              
  if (b=1077) and (p<>9) then begin
   p0:=p;
   q0:=q;
   p:=p+1;
   gotoxy(2*p0,2+2*q0);
   TextBackground(0);
   if c[p0,q0]=0 then write(' ')
                 else write(c[p0,q0]);
   gotoxy(2*p,2+2*q);
   TextBackground(1);
   if c[p,q]=0 then write(' ')
                 else write(c[p,q]);
   gotoxy(1,1);
  end;
  if (b=1072) and (q<>1) then begin
   p0:=p;
   q0:=q;
   q:=q-1;
   gotoxy(2*p0,2+2*q0);
   TextBackground(0);
   if c[p0,q0]=0 then write(' ')
                 else write(c[p0,q0]);
   gotoxy(2*p,2+2*q);
   TextBackground(1);
   if c[p,q]=0 then write(' ')
                 else write(c[p,q]);
   gotoxy(1,1);
  end;
  if (b=1080) and (q<>9) then begin
   p0:=p;
   q0:=q;
   q:=q+1;
   gotoxy(2*p0,2+2*q0);
   TextBackground(0);
   if c[p0,q0]=0 then write(' ')
                 else write(c[p0,q0]);
   gotoxy(2*p,2+2*q);
   TextBackground(1);
   if c[p,q]=0 then write(' ')
                 else write(c[p,q]);
   gotoxy(1,1);
  end;

 if ((b>47)and(b<58)) then begin
  gotoxy(2*p,2+2*q);
  c[p,q]:=b-48;
  TextBackground(1);
  if c[p,q]=0 then write(' ')
              else write(c[p,q]);
  gotoxy(1,1);
 end;
 
 if b=13 then begin
  liczenie;
  TextBackground(0);
  for x:=1 to 9 do 
   for y:=1 to 9 do begin
    gotoxy(22+2*x,2+2*y);
    if d[x,y]=0 then write(' ')
                else write(d[x,y]);
   end;
  gotoxy(30,23);
  write('     ');
  gotoxy(1,1);
  end;
 
 if b=1071 then begin
  TextBackground(0);
   for x:=1 to 9 do 
    for y:=1 to 9 do begin
     gotoxy(2*x,2+2*y);
     write(' ');
     c[x,y]:=0;
    end;
   gotoxy(30,23);
   write('     ');
   gotoxy(2*p,2+2*q);
   TextBackground(1);
   write(' ');
   gotoxy(1,1);
 end;
 
 if b=9 then begin 
  liczenie;
  TextBackground(0);
  for x:=1 to 9 do 
   for y:=1 to 9 do begin
    gotoxy(22+2*x,2+2*y);
    if d[x,y]=0 then write(' ')
                else write(d[x,y]);
   end;
  for x:=1 to 3 do
   for y:=1 to 3 do begin
    gotoxy(43+2*x,14+2*y);
    if a[p][q][x+3*(y-1)] then write(x+3*(y-1))
                          else write(' ');
   end;
  gotoxy(48,14);
  write(p);
  gotoxy(50,14);
  write(q);
  gotoxy(1,1);
 end;
 
 if (b=99) or (b=67) then begin
  textbackground(0);
  for x:=1 to 9 do
   for y:=1 to 9 do begin;
    c[x,y]:=d[x,y];
    gotoxy(2*x,2+2*y);
    if c[x,y]=0 then write(' ')
                else write(c[x,y]);
   end;
  gotoxy(2*p,2+2*q);
  textbackground(1);
  if c[p,q]=0 then write(' ')
              else write(c[p,q]);
  gotoxy(1,1);
 
 end;
 
 if b=1063 then begin
  textbackground(0);
  gotoxy(30,23);
  if spr then write('Dobr.')
         else write(' Zle ');
  gotoxy(1,1);
 end;
 
 until false;
end.