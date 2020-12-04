Changelog Banco (V0.5) :

- Usuario de prueba
 
- Cedula : 30488638

 - Pass : j 
 -(esta pass ignora el límite mínimo ya que es directamente declarada en el procedure datosprueba y no es registrada en el sistema Mediante el procedure registrar_usuario)



>Añadida Pantalla post-login (pantalla de sesión activa) una vez que el usuario se autentica correctamente

+Añadido indicador de operaciones por sesión restantes.



>Mejora al sistema de inicio de sesión. Ya no es necesario utilizar el usuario para autenticarse, solo la cédula.

+Diálogos mejorados con mejores proporciones visuales.



>Mejora al sistema de registro de usuario sustituyendo algunos parámetros obsoletos como : nombre de usuario

+Añadida constante que limita el número mínimo de carácteres que necesita una contraseña para ser validad.



>Añadido un nuevo tipo de variable : acct

Con el fin de funcionar como una variable temporal al tipo de variable acc



>Añadidas constantes que permiten modificar el sistema a la preferencia del desarrollador encargado.

Tales como maps, mpl e historysize.



>Generate_ref y registro_op : Añadido sistema de generación de referencias único universal, con la peculiar habilidad de siempre emitir una referencia distinta y valida basado en un número de operación universal. Esto con el fin de reflejarse en el histórico de operaciones que se implementará más adelante.

+Cuenta con la habilidad de cambiar los primeros 4 dígitos de acuerdo al tipo de operación a la que se va a referencia

-Es funcional, aunque, en esta version no se utiliza en ninguna parte del código. Se escribió primero ya que es fundamental para empezar con el resto.

+Como un plus, está también test_ref que permite probar la funcion conjunta de generar una referencia



>Añadido procedures placeholders de depósito, transferencia, retiro,  configuración, ver histórico y Logout.

+A estos se les hace mención dentro del menú post-login, y por ahora solo restan operaciones del contador de operaciones por sesión.
 Este, al llegar a 0, cierra la sesión.

++En este caso, al no haber ningún bucle que inicie todo de nuevo, el programa terminará.

+++Puedes probar esto fácilmente modificando la constante maps a 1 > ejecutando el programa> reducir el contador a 0.



>Tamaño del archivo : 5.67 kb > 12.62 kb (unas 294 líneas agregadas + algunos Arrays)


Commit realizado por: Raimundo Amilibia
