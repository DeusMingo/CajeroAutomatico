Changelog Banco (V0.5) :

- Usuario de prueba
 
- Cedula : 30488638

 - Pass : j 
 -(esta pass ignora el l�mite m�nimo ya que es directamente declarada en el procedure datosprueba y no es registrada en el sistema Mediante el procedure registrar_usuario)



>A�adida Pantalla post-login (pantalla de sesi�n activa) una vez que el usuario se autentica correctamente

+A�adido indicador de operaciones por sesi�n restantes.



>Mejora al sistema de inicio de sesi�n. Ya no es necesario utilizar el usuario para autenticarse, solo la c�dula.

+Di�logos mejorados con mejores proporciones visuales.



>Mejora al sistema de registro de usuario sustituyendo algunos par�metros obsoletos como : nombre de usuario

+A�adida constante que limita el n�mero m�nimo de car�cteres que necesita una contrase�a para ser validad.



>A�adido un nuevo tipo de variable : acct

Con el fin de funcionar como una variable temporal al tipo de variable acc



>A�adidas constantes que permiten modificar el sistema a la preferencia del desarrollador encargado.

Tales como maps, mpl e historysize.



>Generate_ref y registro_op : A�adido sistema de generaci�n de referencias �nico universal, con la peculiar habilidad de siempre emitir una referencia distinta y valida basado en un n�mero de operaci�n universal. Esto con el fin de reflejarse en el hist�rico de operaciones que se implementar� m�s adelante.

+Cuenta con la habilidad de cambiar los primeros 4 d�gitos de acuerdo al tipo de operaci�n a la que se va a referencia

-Es funcional, aunque, en esta version no se utiliza en ninguna parte del c�digo. Se escribi� primero ya que es fundamental para empezar con el resto.

+Como un plus, est� tambi�n test_ref que permite probar la funcion conjunta de generar una referencia



>A�adido procedures placeholders de dep�sito, transferencia, retiro,  configuraci�n, ver hist�rico y Logout.

+A estos se les hace menci�n dentro del men� post-login, y por ahora solo restan operaciones del contador de operaciones por sesi�n.
 Este, al llegar a 0, cierra la sesi�n.

++En este caso, al no haber ning�n bucle que inicie todo de nuevo, el programa terminar�.

+++Puedes probar esto f�cilmente modificando la constante maps a 1 > ejecutando el programa> reducir el contador a 0.



>Tama�o del archivo : 5.67 kb > 12.62 kb (unas 294 l�neas agregadas + algunos Arrays)


Commit realizado por: Raimundo Amilibia
