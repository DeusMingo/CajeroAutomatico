program Banco; 

uses
  crt, jtools;


const
  max_users = 50;
  preg1 = '¿Cual fue tu primera mascota?';
  preg2 = '¿Cual es tu Golosina favorita?';
  preg3 = '¿Cual es tu cancion preferida?';


type
  acc = record
    nombre, tipo, user, password, ID, cedula: string;
    saldo: Real;
    resp1, resp2, resp3: string;
  end;


var
  total_users: integer;
  cuenta: array [0..max_users] of acc;
  temp: acc;
  temp2: string;
  i, temp3: integer;
  many: boolean;

procedure registrar_usuario;

begin
clrscr;
  if total_users < max_users then
    begin
      repeat 
        many := false;
        writeln('>Introduce tu cédula de identidad');
        writeln('Introduce "menu" para volver al menú');
        readln(temp.cedula);
        temp3 := trunc(stn(temp.cedula));
        if temp.cedula = 'menu' then
          begin
            writeln('Entendido, Volviendo al menú');
            readln;
            many := false;
          end 
        else if temp3 <= 0 then
          begin
            writeln('Cedula invalida, Intenta de nuevo usando carácteres válidos');
            many := true;
          end 
        else 
          begin
            temp.cedula := '';
            temp.cedula := temp.cedula + temp3;
            many := false;
            for i := 1 to max_users do 
              if temp.cedula = cuenta[i].cedula then
                begin
                  writeln('Ciudadano ya se encuentra registrado en el sistema');
                  writeln('Si olvidaste tus datos, Consulta el soporte tecnico');
                  many := true;
                  break ;
                end ;
          end;
      until many = false;
      if temp.cedula = 'menu' then
        many := true ;
      if many = false then
        begin
          temp.cedula := '';
          temp.cedula := temp.cedula + temp3;
          writeln('>Introduce tu nombre');
          readln(temp.nombre);
          many := false;
          repeat 
            writeln('>Introduce Un nombre de Usuario');
            readln(temp.user);
            for i := 1 to max_users do 
              if temp.user = cuenta[i].user then
                begin
                  writeln('Ese Nombre de usuario ya está en uso, intenta nuevamente');
                  many := true;
                  break ;
                end ;
          until not many = true;
          many := false;
          repeat 
            writeln('>Introduce una contraseña');
            readln(temp.password);
            writeln('Confima tu contraseña');
            readln(temp2);
            if temp.password <> temp2 then
              begin
                many := true;
                writeln('Las contraseñas no coinciden, intenta de nuevo');
              end ;
          until many = false;
          writeln('>Preguntas De Seguridad');
          WRITELn('Esto será útil en caso de que pierdas tus datos de acceso');
          Writeln(preg1);
          readln(temp.resp1);
          writeln(preg2);
          readln(temp.resp2);
          Writeln(preg3);
          readln(temp.resp3);
          Clrscr;
          Writeln('||DATOS DEL CIUDADANO||');
          Writeln('Nombre : ', temp.nombre);
          Writeln('Cedula : ', Temp.cedula);
          writeln;
          WRITELn('•DATOS DE USUARIO');
          writeln('Usuario : ', Temp.user);
          writeln;
          writeln('>Preguntas De Seguridad');
          Writeln(preg1);
          writeln('R : ', temp.resp1);
          Writeln(preg2);
          writeln('R : ', temp.resp2);
          Writeln(preg3);
          writeln('R : ', temp.resp3);
          WRITELn;
          writeln('Estos datos se registrarán en el sistema');
          WRITELn('¿Estas de acuerdo de eso?');
          writeln;
          writeln ('1 = Si. Cualquier otro carácter = No.');
          readln(temp2);
          if temp2 = '1' then
            begin
              cuenta[total_users].nombre := temp.nombre;
              cuenta[total_users].cedula := temp.cedula;
              cuenta[total_users].user := temp.user;
              cuenta[total_users].password := temp.password;
              cuenta[total_users].resp1 := temp.resp1;
              cuenta[total_users].resp2 := temp.resp2;
              cuenta[total_users].resp3 := temp.resp3;
              temp.id := '0191';
              repeat 
                for i := 1 to 4 do 
                  begin
                    temp3 := random(9) + 1;
                    temp.id := temp.id + temp3;
                  end;
                many := false;
                for i := 1 to max_users do 
                  if temp.id = cuenta[i].Id then
                    begin
                      many := true;
                      break 
                    end ;
              until many = false;
              cuenta[total_users].ID := temp.id;
              clrscr;
              WRITELn('¡Usuario registrado satisfactoriamente!');
              WRITELn('¡Bienvenido a bordo!');
              WRITELN ('A través de tu nuevo usuario único, podrás disfrutar de todos nuestros servicios en línea');
              
              WRITELn;
              WRITELn('Tu número de cuenta es : ', cuenta[total_users].ID);
              total_users := total_users + 1;
            end 
          else 
            begin
              clrscr;
              WRITELn('Operacion Anulada por el Usuario, Volviendo al menú');
              readln;
            end;
        end 
      else 
        continue ;
    end else
begin
            writeln('No se puede registrar más usuarios actualmente, intente más tarde');
            readln;
          end;
end; 

procedure datosprueba;
begin
cuenta[1].cedula := '1';
  cuenta[1].user := 'j';
  cuenta[1].ID := '01911010';
end;

begin
  total_users := 1;
  datosprueba;
  registrar_usuario;
end.
