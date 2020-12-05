program Banco; 

uses
  crt, jtools;


const
  max_users = 10;
  moneda = 'Bs.S';
  preg1 = '¿Cual fue tu primera mascota?';
  preg2 = '¿Cual es tu Golosina favorita?';
  preg3 = '¿Cual es tu cancion preferida?';
  max_intentos = 3;
  historysize = 10;
  MAPS = 10;
  nombrebank = 'LectroBank';
  //Max actions per session

  Mpl = 5;
  //minimum password length

  wdl = 8;
  //withdrawal digit limit 

  

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
  session_op: integer;
  user_id: integer;
  univer_ref: integer;
  option: integer;
total_end : boolean;
temps : String;
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
          
          repeat 
          many := false;
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
              readln
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
  match, exist, ok: boolean;


begin
  repeat 
 ok := false;
    user_id := 0;
    active_session := false;
    exist := false;
    ii := 0;
    clrscr;
    writeln('>Introduce Tu Cedula');
    writeln('Introduce "menu" para volver al menú');
    writeln;
    readln(temp.cedula);
   if (temp.cedula) = 'menu' then begin
ok:= true;
writeln;
writeln ('Operacion Anulada por el usuario');
writeln ('Volviendo al menu principal');

writeln;
readln;
end
else
begin
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
        readln;
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
            user_id := ii;
            session_op := 0;
           ok:= true;
          end ;
      end;
  
end; 
until ok = true;
end;
procedure datosprueba;

begin
  cuenta[1].password := 'melee';
  cuenta[1].ID := '01913030';
  cuenta[1].nombre := 'Domingo';
  cuenta[1].apellido :='Avendaño';
  cuenta[1].cedula := 28189778;
  cuenta[1].resp1 := 'melee';
  cuenta[1].resp2 := 'melee';
  cuenta[1].resp3 := 'melee';
  total_users := 1 ;
  
end; 
procedure recuperar_acceso;

var
  i, id: integer;
  temp, temp2: string;
  match, error, recover: Boolean;
  ok, nok: integer;


begin
  clrscr;
  writeln('Introduce tu cedula');
  readln(temp);
  for i := 1 to max_users do 
    if trunc(stn(temp, true)) = cuenta[i].cedula then
      begin
        match := true;
        Id := i;
        break ;
      end ;
  if match = false then
    begin
      writeln;
      writeln('Esta cédula no se encuentra asociada a ningún usuario');
      writeln('Verifica e intentalo de nuevo');
      writeln;
      readln;
    end 
  else 
    begin
      repeat 
        clrscr;
        error := false;
        writeln('Que deseas recuperar?');
        writeln('1 = Desbloquear Usuario');
        Writeln('2 = Recuperar Contraseña');
        writeln;
        writeln('9 = Volver al menú principal');
        writeln;
        readln(temp);
        if temp = '9' then
          begin
            WRITELN('Operacion Anulada por el usuario');
            writeln('Volviendo al menu');
            readln;
          end 
        else 
          case trunc(stn(temp, true)) of 
            1: recover := true;
            2: recover := true;
            else 
            begin
              writeln;
              writeln('Opción invalida');
              writeln('Verifica e intenta nuevamente');
              writeln;
              readln;
              error := true;
            end;
          end;
      until error = false;
    end;
  if recover = true then
    begin
      clrscr;
      ok := 0;
      nok := 0;
      WRITELN('RECUPERACION MEDIANTE PREGUNTAS DE SEGURIDAD');
      writeln('De : ', cuenta[ID].cedula);
      WRITELN;
      writeln('Puedes saltar solo 1 pregunta escribiendo "skip"');
      writeln;
      WRITELN('Se necesitan mínimo, 2 respuestas correctas');
      writeln;
      writeln(preg1);
      readln(temp2);
      if temp2 = cuenta[ID].resp1 then
        ok := ok + 1  
      else if temp2 = 'skip' then
        nok := nok + 1 ;
      writeln(preg2);
      readln(temp2);
      if temp2 = cuenta[ID].resp2 then
        ok := ok + 1  
      else if temp2 = 'skip' then
        nok := nok + 1 ;
      writeln(preg3);
      readln(temp2);
      if temp2 = cuenta[ID].resp3 then
        ok := ok + 1  
      else if temp2 = 'skip' then
        nok := nok + 1 ;
      if nok >= 2 then
        begin
          writeln;
          Writeln('Proceso anulado');
          writeln('No se puede saltar una respuesta en más de una ocasión');
          writeln;
          readln;
        end 
      else if ok < 2 then
        begin
          WRITELN;
          writeln('2 o mas preguntas de seguridad, son incorrectas');
          writeln('Verifica e intentalo de nuevo');
          writeln;
          writeln('Volviendo al menu');
          WRITELN;
          readln;
        end 
      else if ok >= 2 then
        begin
          writeln;
          if trunc(stn(temp, true)) = 1 then
            begin
              WRITELN;
              if cuenta[ID].estado = 'bloq' then
                begin
                  cuenta[ID].estado := 'unbloq';
                  writeln('El usuario : ', cuenta[ID].cedula, ' Ha sido desbloqueado satisfactoriamente');
                cuenta[ID].intentos:= 0; 
                end 
              else 
                WRITELn('El usuario : ', cuenta[ID].Cedula, ' No estaba bloqueado. ._.XD');
              WRITELN;
              readln;
              cuenta[ID].intentos:= 0; 
            end 
          else if trunc(stn(temp, true)) = 2 then
            begin
              WRITELN;
              writeln('La contraseña del usuario : ', cuenta[ID].cedula);
              writeln('Es : ', cuenta[ID].password);
              WRITELN;
              writeln('Anotala en un lugar seguro, y ten más cuidado');
              WRITELN;
              readln;
              cuenta[ID].intentos:= 0; 
            end ;
        end ;
    end ;
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
    3: generate_ref := 'RTRE' + opernum;
  end;
end; 
procedure plusop(uid: integer);

begin
  cuenta[uid].current_op := cuenta[uid].current_op + 1;
  if cuenta[uid].current_op >= historysize then
    cuenta[uid].current_op := 1 ;
end; 
procedure Depositar;

var
  temp: array [1..10] of String;
  tempi: array [1..10] of integer;
  error: boolean;
  monto: real;


begin
  repeat 
    clrscr;
    error := false;
    writeln('Cuanto dinero vas a depositar?');
    writeln;
    writeln('Escribe "menu" para volver al menú');
    readln(temp[1]);
    monto := stn(temp[1], false);
    if temp[1] = 'menu' then
      begin
        writeln;
        writeln('Operacion cancelada por el usuario');
        writeln('volviendo al menú');
        writeln;
        readln;
      end 
    else if monto <= 0 then
      begin
        writeln('Este monto es invalido, intenta de nuevo');
        readln;
        error := true;
      end 
    else if length(temp[2]) - 2 > wdl then
      begin
        writeln;
        writeln('Limite de cifras detectado');
        writeln('Asegurate que el número introducido sea menor a ', wdl, ' cifras.');
        writeln;
        error := true;
        readln;
      end 
    else 
      begin
        writeln;
        writeln('Deseas agregar : ', monto, ' ', moneda, ' a tu cuenta?');
        writeln;
        writeln('1=Si');
        writeln('Cualquier otro carácter = No');
        writeln;
        readln(temp[3]);
        case trunc(stn(temp[3], true)) of 
          1: 
          begin
            clrscr;
            cuenta[user_id].saldo := cuenta[user_id].saldo + monto;
            session_op := session_op + 1;
            writeln;
            cuenta[user_id].OP[cuenta[user_id].current_op] := registro_op(1, user_id, '+', monto, 'DEPOSIT', generate_ref(1));
            plusop(user_id);
            writeln('Se han agregado ', monto, ' ', moneda, ' a tu cuenta satisfactoriamente');
            writeln('Volviendo al menú');
            readln;
            error := false;
          end
          else 
          begin
            writeln;
            writeln('Operacion Anulada por el usuario');
            WRITELn('Volviendo al menu');
            writeln;
            readln;
          end;
        end;
      end;
  until error = false;
end; 

procedure transferencia;

var
  tempa: array [0..10] of string;
  a, b, i, error: integer;
  match: boolean;
  tempstr: string;


begin
  if cuenta[user_id].saldo <= 0 then
    begin
clrscr; 
      writeln;
      writeln('No puedes realizar transferencias si tú saldo es igual a 0');
      WRITELn('Verifica e intentalo de nuevo');
      writeln;
      readln;
    end 
  else 
    begin
clrscr;
      writeln('Introduce la cédula del destinatario');
      WRITELn;
      writeln('Introduce "menu" para volver al menú');
      writeln;
      readln(tempa[1]);
      if tempa[1] = 'menu' then
        begin
          writeln;
          writeln('Operación anulada por el usuario, Volviendo al menú');
          writeln;
          readln;
        end 
      else 
        begin
          writeln('Introduce el monto a transferir');
          readln(tempa[2]);
          writeln('Introduce el numero de cuenta del destinatario');
          readln(tempa[3]);
          writeln('Introduce el concepto de la transferencia');
          readln(tempa[4]);
          clrscr;
          Writeln('VERIFICACION DE DATOS');
          Writeln;
          WRITELn('Cedula destinatario : ', tempa[1]);
          writeln('Nro. de cuenta destino : ', tempa[2]);
          writeln;
          writeln('Concepto : ', tempa[4]);
          writeln;
          writeln('Estos datos son correctos?');
          writeln('1 = Si');
          writeln('Otra tecla = No');
          readln(tempa[5]);
          match := false;
          case trunc(stn(tempa[5], True)) of 
            1: 
            begin
              for i := 1 to total_users do 
                if trunc(stn(tempa[5], true)) = cuenta[i].cedula then
                  begin
                    b := i;
                    break ;
                    match := true;
                  end 
                else 
                  error := 5;
              if match = true then
                begin
                  error := 0;
                  if stn(tempa[2], false) <= 0 then
                    error := 1  
                  else if stn(tempa[2], false) > cuenta[user_id].saldo then
                    error := 1  
                  else if tempa[3] <> cuenta[b].id then
                    error := 2 ;
                  if error > 0 then
                    begin
                      clrscr;
                      writeln;
                      writeln('OPERACION FALLIDA');
                      WRITELN;
                      case error of 
                        1: writeln('Monto Invalido, verifica e intenta nuevamente');
                        2: writeln('Numero de cuenta no coincide con el del Usuario');
                        5: writeln('Usuario no afiliado al Sistema');
                      end;
                      writeln;
                      writeln('Error code = ', error);
                      writeln;
                      writeln('Volviendo al menú');
                      readln;
                    end 
                  else 
                    begin
clrscr;
                      tempa[6] := generate_ref(2);
                      cuenta[user_id].saldo := cuenta[user_id].saldo - stn(tempa[2], false);
                      cuenta[b].saldo := cuenta[b].saldo + stn(tempa[2], false);
                      cuenta[user_id].OP[cuenta[user_id].current_op] := registro_op(2, user_id, '-', stn(tempa[2], false), tempa[4], tempa[5]);
                      plusop(user_id);
                      cuenta[b].OP[cuenta[b].current_op] := registro_op(2, b, '+', stn(tempa[2], false), tempa[4], tempa[5]);
                      plusop(b);
                      Writeln('OPERACION EXITOSA');
                      writeln;
                      writeln('Ref : '  , Tempa[6]);
                      writeln;
                      writeln('Monto : ', stn(tempa[2], false));
                      writeln('Destino : ', stn(tempa[1], true));
                      WRITELN('Concepto :', tempa[4]);
                      writeln;
                      session_op := session_op + 1;
                     readln;
                    end;
                
                end;
              end
              else 
              begin
                writeln;
                writeln('Operación anulada por el usuario, Volviendo al menú');
                writeln;
                readln;
              
            end;
          end;
        end;
    end;
 end;
procedure retiro;

var
  temp: array [1..10] of String;
  tempi: array [1..10] of integer;
  error: boolean;
  monto: real;


begin
  if cuenta[user_id].saldo <= 0 then
    begin
      clrscr;
      writeln;
      writeln('No puedes retirar efectivo si tú saldo es 0');
      WRITELn('Deposita e intentalo de nuevo');
      writeln;
      readln;
    end 
  else 
    repeat 
      clrscr;
      error := false;
      writeln('Saldo actual : ', cuenta[user_id].saldo, ' ', moneda);
      WRITELn;
      writeln('Cuanto dinero vas a retirar?');
      writeln;
      writeln('Escribe "menu" para volver al menú');
      readln(temp[1]);
      monto := stn(temp[1], false);
      if temp[1] = 'menu' then
        begin
          writeln;
          writeln('Operacion cancelada por el usuario');
          writeln('volviendo al menú');
          writeln;
          readln;
        end 
      else if monto > cuenta[user_id].saldo then
        begin
          writeln;
          writeln('Este monto es superior al balance actual de tu cuenta');
          writeln('Verifica e intenta de nuevo');
          writeln;
          readln;
          error := true;
        end 
      else if monto <= 0 then
        begin
          writeln;
          writeln('Este monto es invalido, intenta de nuevo');
          writeln;
          readln;
          error := true;
        end 
      else if length(temp[2]) - 2 > wdl then
        begin
          writeln;
          writeln('Limite de cifras detectado');
          writeln('Asegurate que el número introducido sea menor a ', wdl, ' cifras.');
          writeln;
          error := true;
          readln;
        end 
      else 
        begin
          writeln;
          writeln('Deseas retirar : ', monto, ' ', moneda, ' de tu cuenta?');
          writeln;
          writeln('1=Si');
          writeln('Cualquier otro carácter = No');
          writeln;
          readln(temp[3]);
          case trunc(stn(temp[3], true)) of 
            1: 
            begin
              clrscr;
              cuenta[user_id].saldo := cuenta[user_id].saldo - monto;
              session_op := session_op + 1;
              writeln;
              cuenta[user_id].OP[cuenta[user_id].current_op] := registro_op(1, user_id, '-', monto, 'RETIRO', generate_ref(3));
              plusop(user_id);
              writeln('Se ha retirado ', monto, ' ', moneda, ' de tu cuenta satisfactoriamente');
              writeln('Volviendo al menú');
              readln;
              error := false;
            end
            else 
            begin
              writeln;
              writeln('Operacion Anulada por el usuario');
              WRITELn('Volviendo al menu');
              writeln;
              readln;
            end;
          end;
        end;
    until error = false;
end; 
procedure ver_hist;

var
  i: integer;


begin
  clrscr;
  writeln('HISTORICO DE OPERACIONES : ', cuenta[user_id].cedula);
  WRITELn;
  for i := 1 to cuenta[user_id].current_op - 1 do 
    begin
      writeln(i, '.', cuenta[user_id].op[i]);
      session_op := session_op + 1;
    end;
  writeln;
  readln;
end; 
procedure Logout;

begin
  writeln;
  writeln('Muchas gracias por utilizar nuestros servicios');
  writeln('Esperamos verte pronto de nuevo!');
  active_session := false;
  writeln;
  readln;
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
      writeln;
      writeln('9 = Cerrar sesión');
      writeln;
      writeln('(', maps - session_op, ') Operaciones restantes.');
      writeln;
      readln(ans[1]);
      ansi := trunc(stn(ans[1], true));
      option := ansi;
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
procedure login;

begin
  repeat 
    if maps - session_op > 0 then
      afterloginmenu  
    else 
      begin
        clrscr;
        writeln;
        writeln('Limite de operaciones por sesión alcanzado');
        writeln('Cerrando sesión');
        writeln;
        writeln('Para continuar, inicia sesión nuevamente');
        writeln;
        readln;
        active_session := false;
      end;
  until active_session = false;
end; 

begin
  for total_users := 1 to max_users do 
    cuenta[total_users].current_op := 1;
  total_users := 1;
  univer_ref := 1;
  datosprueba;
  //while univer_ref < 10 do test_ref;
  repeat
clrscr;
writeln ('Bienvenido a ',nombrebank);
WRITELn ('¿Que quieres hacer?');
Writeln;
writeln ('1 = Iniciar Sesión');
writeln ('2 = Registrarse');
writeln;
writeln ('5 = Soporte técnico');
Writeln;
writeln ('9 = Salir');
readln(temps);
case trunc(stn(temps, true)) of 
1 :  begin
iniciar_sesion;
while active_session=true do login;
end;
2 : registrar_usuario;
5 : recuperar_acceso;
9 : Total_end := true;
else begin
writeln ('Opcion invalida');
writeln('Verifica e intenta nuevamente');
end;
end;
until total_end = true;
end.

