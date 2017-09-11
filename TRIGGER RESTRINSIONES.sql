--1.- /*****Desarrollar un trigger que permita ingresar solo 9 números en el campo 'teléfono')****/
create or replace trigger TR_B_IU_HOTEL
BEFORE
    insert or update on HOTEL
    for each row
declare
begin
    IF :NEW.TELEFONO < -1 OR length(:NEW.TELEFONO) <> 9 THEN
    raise_application_error(-20001, 'INGRESO DE TELEFONO INVALIDO');
    END IF;
end;

--2.- /*Desarrollar un trigger que permita solo ingresar tres parámetros que son 'Presidencial', 'Personal', 'Matrimonial' o 'familiar'.),
                             --en caso que se quiera añadir otro campo este saldrá error.*/
create or replace trigger TR_B_IU_HABITACION
BEFORE
    insert or update on HABITACION
    FOR EACH ROW
declare
begin
    IF (:NEW.TIPO_HABITACION <> 'PRESIDENCIAL' AND :NEW.TIPO_HABITACION <> 'PERSONAL' AND
    :NEW.TIPO_HABITACION <> 'MATRIMONIAL' AND :NEW.TIPO_HABITACION <> 'FAMILIAR') THEN 
    raise_application_error(-20002, 'INGRESO DE TIPO_HABITACION INVALIDO');
    END IF;
end;

--3.- /*****Desarrollar un triger en la cual me permita solo ingresar el tipo de categoria que tiene el hotel, 
              --en este caso esta de la categoria 1 estrella hasta la categoria 5 estrella).******/
create or replace TRIGGER TR_B_IU_TIPO_CATEGORIA
BEFORE
    INSERT OR UPDATE ON TIPO_CATEGORIA
    FOR EACH ROW
DECLARE
BEGIN
    IF (:NEW.DESCRIPCION <> '1 ESTRELLA' AND :NEW.DESCRIPCION <> '2 ESTRELLA' AND 
    :NEW.DESCRIPCION <> '3 ESTRELLA' AND :NEW.DESCRIPCION <> '4 ESTRELLA' AND :NEW.DESCRIPCION <> '5 ESTRELLA') THEN 
    RAISE_APPLICATION_ERROR(-20003, 'INGRESO DE TIPO_CATEGORIA INVALIDO');
    END IF;
END;

--4.- /***Desarrollar un trigger que me permita ingresar los números de la cedula del cliente de un rango de hasta 9 o 10 dígitos).***/
create or replace TRIGGER TR_B_IU_CLIENTE
BEFORE
    INSERT OR UPDATE ON CLIENTE
    FOR EACH ROW
DECLARE 
BEGIN
    IF LENGTH(:NEW.CEDULA) <> 10 AND LENGTH(:NEW.CEDULA) <> 9  THEN 
    RAISE_APPLICATION_ERROR(-20006, 'INGRESO DE CEDULA INVALIDO');
    END IF;
END;

--5.- /***********Desarrollar un trigger en la cual se pueda realizar un pago a través de efectivo o de tarjeta**********/
create or replace TRIGGER TR_B_IU_TIPO_PAGO
BEFORE
    INSERT OR UPDATE ON TIPO_PAGO
    FOR EACH ROW
DECLARE
BEGIN
    IF (:NEW.DESCRIPCION <> 'EFECTIVO' AND :NEW.DESCRIPCION <> 'TARJETA') THEN 
    RAISE_APPLICATION_ERROR(-20004, 'INGRESO DE TIPO_PAGO INVALIDO');
    END IF;
END;

--6.- /***********Desarrollar un trigger en la cual se pueda actualizar el campo precio al momento de insertar una habitacion**********/
create or replace TRIGGER TR_B_IU_PRECIO_RESERVACION
BEFORE
    INSERT OR UPDATE ON HABITACION
    FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.TIPO_HABITACION = 'PRESIDENCIAL' THEN
    UPDATE RESERVACION SET PRECIO = 100 where ID_RESERVACION = :NEW.ID_RESERVACION;
    END IF;
    IF :NEW.TIPO_HABITACION = 'PERSONAL' THEN
    UPDATE RESERVACION SET PRECIO = 50 where ID_RESERVACION = :NEW.ID_RESERVACION ;
    END IF;
    IF :NEW.TIPO_HABITACION = 'FAMILIAR' THEN
    UPDATE RESERVACION SET PRECIO = 300 where ID_RESERVACION = :NEW.ID_RESERVACION ;
    END IF;
    IF :NEW.TIPO_HABITACION = 'MATRIMONIAL' THEN
    UPDATE RESERVACION SET PRECIO = 250 where ID_RESERVACION = :NEW.ID_RESERVACION ;
    END IF;
END;

--7.- /****Desarrollar un trigger en que me actualice el campo fecha de la tabla factura dependiendo de la fecha_fianl de reservacion****/
create or replace TRIGGER TR_B_IU_FECHA_F
AFTER
    INSERT OR UPDATE ON HABITACION
    FOR EACH ROW
DECLARE
    FECHA_F RESERVACION.FECHA_FIN%TYPE;
BEGIN
    SELECT FECHA_FIN INTO FECHA_F FROM RESERVACION WHERE ID_RESERVACION=:NEW.ID_RESERVACION;
    UPDATE FACTURA SET FECHA =FECHA_F WHERE ID_RESERVACION=:NEW.ID_RESERVACION;
END;

--8.- /****Desarrollar un trigger que me actualice al campo total, multiplicando el precio por cantidad_reservacion de la tabla reservacion****/
create or replace TRIGGER TR_B_IU_TOTAL_ACTU
AFTER
    INSERT OR UPDATE ON HABITACION
    FOR EACH ROW
DECLARE
    TOTAL_FAC NUMBER:=0; 
    PRECIO_FAC NUMBER;
    CANT_R NUMBER;
BEGIN
    SELECT PRECIO, CANTIDAD_RESERVACION INTO PRECIO_FAC, CANT_R FROM RESERVACION WHERE ID_RESERVACION =:NEW.ID_RESERVACION;
    TOTAL_FAC := (PRECIO_FAC * CANT_R);
    UPDATE FACTURA SET TOTAL = TOTAL_FAC where ID_RESERVACION = :NEW.ID_RESERVACION;
END;

DROP TRIGGER TR_B_IU_TOTAL_ACTU;


--9 --Desarrollar un trigger que me actualice el campo total, en funcion del descuento si el cliente tiene mas de 2 reservaciones------

create or replace TRIGGER TR_B_IU_DESCUENTO
AFTER
    INSERT OR UPDATE ON HABITACION
DECLARE
    TOTAL_FAC   NUMBER:=0; 
    TOTAL3      NUMBER;
    CANTIDAD    NUMBER:=0;
    TOTAL1      NUMBER:=0;
    TOTAL2      NUMBER:=0;
    DESCUENTO1  NUMBER;
BEGIN
    SELECT COUNT(*)INTO CANTIDAD FROM RESERVACION WHERE ID_CLIENTE=ID_CLIENTE;
    SELECT TOTAL INTO TOTAL1 FROM FACTURA WHERE ID_FACTURA=ID_FACTURA;

    IF CANTIDAD > 1 THEN
    UPDATE FACTURA SET DESCUENTO=5 WHERE ID_RESERVACION=ID_RESERVACION;
    SELECT TOTAL, DESCUENTO INTO TOTAL3, DESCUENTO1 FROM FACTURA WHERE ID_FACTURA=ID_FACTURA;
    TOTAL_FAC := TOTAL3 - ((TOTAL3*5)/100);
    UPDATE FACTURA SET TOTAL=TOTAL_FAC WHERE ID_RESERVACION=ID_RESERVACION;
    END IF;
END;

--10 --TRIGGER QUE NO PERMITA INGRESAR MENORES DE EDAD AL MOMENTO DE HACER UNA RESERVACION  
create or replace TRIGGER TR_B_IU_EDAD_CLIENTE
BEFORE
    INSERT OR UPDATE ON CLIENTE
    FOR EACH ROW
DECLARE
BEGIN
   IF :NEW.EDAD <18 THEN
   RAISE_APPLICATION_ERROR(-20007, 'INVALIDO, NO SE PERMITEN MENORES DE EDAD');
   END IF;
END;
