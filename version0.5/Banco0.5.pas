program Banco; 

uses
  crt, jtools;


const
  max_users = 10;
  moneda = 'Bs. S';
  preg1 = '¿Cual fue tu primera mascota?';
  preg2 = '¿Cual es tu Golosina favorita?';
  preg3 = '¿Cual es tu cancion preferida?';
  max_intentos = 3;
  historysize = 10;
  MAPS = 50;
  //Max actions per session

  Mpl = 5;
  //minimum password length

  

type
  acc = record
    nombre, apellido, tipo, user, password, ID: string;
    saldo: Real;
    resp1, resp2, resp3: string;
    estado: string;
    intentos, cedula: integer;
    current_op: integer;
    op: array [0..historysize] of String;
  end;
  acct = record
    nombre, apellido, tipo, user, password, ID, cedula: string;
    saldo: Real;
    resp1, resp2, resp3: string;
    estado: string;
    intentos: integer;
    current_op: integer;
    op: array [0..historysize] of String;
  end;


var
  total_users: integer;
  cuenta: array [0..max_users] of acc;
  active_session: boolean;
  user_id: integer;
  univer_ref: integer;

procedure registrar_usuario;

var
  temp: acct;
  temp2: string;
  temp3, i: integer;
  many: boolean;


begin
  clrscr;
  if total_users < max_users then
    begin
      repeat 
        many := false;
        writeln('>Introduce tu cédula de identidad');
        writeln('Introduce "menu" para volver al menú');
        readln(temp.cedula);
        temp3 := trunc(stn(temp.cedula, true));
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
              if trunc(stn(temp.cedula, true)) = cuenta[i].cedula then
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
          writeln('>Introduce tu primer nombre');
          readln(temp.nombre);
          writeln('>Introduce tu primer apellido');
          readln(temp.apellido);
          many := false;
          repeat 
            writeln('>Introduce una contraseña');
            readln(temp.password);
            if length(temp.password) < mpl then
              begin
                writeln;
                writeln('La contraseña debe contener un minimo de 5 carácteres');
                writeln('Intenta nuevamente');
                writeln;
                many := true;
              end 
            else 
              begin
                writeln('Confima tu contraseña');
                readln(temp2);
                if temp.password <> temp2 then
                  begin
                    many := true;
                    writeln('Las contraseñas no coinciden, intenta de nuevo');
                  end ;
              end;
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
          Writeln('Nombre y apellido: ', temp.nombre, ' ', temp.apellido);
          Writeln('Cedula : ', Temp.cedula);
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
          writeln('1 = Si. Cualquier otro carácter = No.');
          readln(temp2);
          if temp2 = '1' then
            begin
              cuenta[total_users].nombre := temp.nombre;
              cuenta[total_users].apellido := temp.apellido;
              cuenta[total_users].cedula := trunc(stn(temp.cedula, true));
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
              WRITELN('A través de tu nuevo usuario único, podrás disfrutar de todos nuestros servicios en línea');
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
    end 
  else 
    begin
      writeln('No se puede registrar más usuarios actualmente, intente más tarde');
      readln;
    end;
end; 
procedure iniciar_sesion;

var
  temp: acct;
  i, ii: integer;
  match, exist: boolean;


begin
  repeat 
    user_id := 0;
    active_session := false;
    exist := false;
    ii := 0;
    clrscr;
    writeln('>Introduce Tu Cedula');
    readln(temp.cedula);
    for i := 1 to max_users do 
      if trunc(stn(temp.cedula, true)) = cuenta[i].cedula then
        begin
          exist := true;
          ii := i;
          break ;
        end ;
    if trunc(stn(temp.cedula, true)) <= 0 then
      begin
        writeln;
        writeln('Esa cedula no es válida, verifica e intenta nuevamente');
        writeln;
        readln;
      end 
    else if exist = false then
      begin
        writeln;
        writeln('Ese usuario no se encuentra registrado en el sistema');
        writeln('Te invitamos a registrarte e intentar nuevamente');
        writeln;
        writeln('Si olvidaste tus datos de acesso, dirigete al Soporte Técnico en el menú');
        writeln;
        readln;
      end 
    else if cuenta[ii].estado = 'bloq' then
      begin
        writeln;
        writeln('Usuario Bloqueado');
        writeln('Dirijase al soporte técnico al apartado de recuperación');
        writeln;
      end 
    else 
      begin
        writeln('>Introduce tu contraseña');
        readln(temp.password);
        cuenta[ii].intentos := cuenta[ii].intentos + 1;
        if temp.password = cuenta[ii].password then
          match := true  
        else if cuenta[ii].intentos < max_intentos then
          begin
            writeln('>La contraseña, no coincide');
            writeln('Verifica e intenta de nuevo');
            writeln;
            writeln('>Al exceder los ', max_intentos, ' Intentos fallidos...');
            writeln('Se bloqueará el usuario como medida de seguridad');
            writeln;
            writeln('Te quedan ', max_intentos - cuenta[ii].intentos, ' Intento(s)');
            writeln;
            readln;
          end 
        else 
          begin
            writeln('Usuario bloqueado exceso de intentos fallidos');
            writeln('Dirigete al apartado de recuperación del servicio técnico');
            cuenta[ii].estado := 'bloq';
            readln;
          end;
        if match = true then
          begin
            active_session := true;
            cuenta[ii].intentos := 0;
            cuenta[ii].current_op := 0;
            user_id := ii;
          end ;
      end;
  until active_session = true;
end; 
procedure datosprueba;

begin
  cuenta[1].cedula := '1';
  cuenta[1].user := 'j';
  cuenta[1].password := 'j';
  cuenta[1].ID := '01911010';
  cuenta[1].nombre := 'Jeremy';
  cuenta[1].apellido := 'Reyes';
  cuenta[1].cedula := 30488638;
end; 
procedure recuperar_acceso;

begin
  writeln('Que deseas recuperar?');
  writeln('1 = Usuario');
  Writeln('2 = Contraseña');
  Writeln('3 = Preguntas de Seguridad');
  Writeln('3 = Desbloquear Usuario');
end; 
procedure befloginmenu;

begin
end; 
procedure Depositar;

var
  temp: array [1..10] of String;
  tempi: array [1..10] of integer;
  error: boolean;


begin
  repeat 
    clrscr;
    error := false;
    writeln('Cuanto dinero vas a depositar?');
    readln(temp[1]);
    if trunc(stn(temp[1], true)) <= 0 then
      begin
        writeln('Este monto es invalido, intenta de nuevo');
        readln;
        error := true;
      end 
    else 
      begin
      end;
  until error = false;
end; 
procedure transferencia;

begin
  cuenta[user_id].current_op := cuenta[user_id].current_op + 1;
end; 
procedure retiro;

begin
  cuenta[user_id].current_op := cuenta[user_id].current_op + 1;
end; 
procedure ver_hist;

begin
  cuenta[user_id].current_op := cuenta[user_id].current_op + 1;
end; 
procedure settings;

begin
end; 
procedure Logout;

begin
end; 
function Registro_op(mode: integer;
userid: integer; 
signo: string; 
monto: real; 
concepto: string; 
ref: string) : String; 

var
  vref: string;


begin
  vref := ref;
  case mode of 
    1: registro_op := vref + ' | ' + concepto + ' | ' + signo + monto;
    2: registro_op := vref + ' | ' + concepto + ' | ' + cuenta[userid].cedula + ' | ' + signo + monto;
  end;
  univer_ref := univer_ref + 1;
end; 
function generate_ref(mode: integer) : string;

var
  opernum: string;


begin
  str(univer_ref, opernum);
  if univer_ref < 10 then
    opernum := '000' + opernum  
  else if univer_ref < 100 then
    opernum := '00' + opernum  
  else if univer_ref < 1000 then
    opernum := '0' + opernum ;
  case mode of 
    1: generate_ref := 'DPST' + opernum;
    2: generate_ref := 'TRSF' + opernum;
    3: generate_ref := 'RTRF' + opernum;
  end;
end; 
procedure afterloginmenu;

var
  ans: array [1..3] of string;
  ansi: integer;


begin
  if user_id > 0 then
    begin
      clrscr;
      writeln('Bienvenido : ', upcase(cuenta[user_id].apellido), ', ', upcase(cuenta[user_id].nombre));
      writeln('Tu balance actual es : ', cuenta[user_id].saldo, ' ', moneda);
      writeln;
      Writeln('¿Que deseas realizar?');
      writeln('1 = Deposito');
      writeln('2 = Transferencia');
      writeln('3 = Retiro de efectivo');
      writeln;
      writeln('5 = Ver histórico de operaciones');
      WRITELn;
      writeln('7 = Ajustes de la cuenta');
      writeln;
      writeln('9 = Cerrar sesión');
      writeln;
      writeln('(', maps - cuenta[user_id].current_op, ') Operaciones restantes.');
      writeln;
      readln(ans[1]);
      ansi := trunc(stn(ans[1], true));
      if ansi < 0 then
        begin
          writeln('Opcion invalida, verifica e intenta de nuevo por favor');
          readln;
        end 
      else 
        case ansi of 
          1: Depositar;
          2: transferencia;
          3: retiro;
          5: ver_hist;
          7: settings;
          9: Logout;
          else 
          begin
            writeln('Opcion invalida, verifica e intenta de nuevo por favor');
            readln;
          end;
        end;
    end ;
end; 
procedure test_ref;

var
  temps, e: string;


begin
  temps := generate_ref(2);
  e := registro_op(2, 1, '+', 500, 'Test', temps);
  writeln(e);
  readln;
end; 

begin
  total_users := 1;
  univer_ref := 1;
  datosprueba;
  //while univer_ref < 10 do test_ref;
  if active_session = false then
    iniciar_sesion ;
  repeat 
    if cuenta[user_id].current_op < maps then
      afterloginmenu  
    else 
      begin
        cuenta[user_id].current_op := 1;
        clrscr;
        writeln;
        writeln('Limite de operaciones por sesión alcanzado');
        writeln('Cerrando sesión');
        writeln;
        writeln('Para continuar, inicia sesión nuevamente');
        writeln;
        active_session := false;
      end;
  until active_session = false;
end.