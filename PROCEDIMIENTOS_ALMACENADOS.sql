--1.--   /*==============TABLA TIPO_CATEGORIA==============*/
/*==========Insertar procedimiento almacenado==============*/
create or replace PROCEDURE PA_INSERTAR_TIPO_CATEGORIA(ID_TIPO_CATEGORIA in INTEGER, DESCRIPCION in VARCHAR)

AS 
BEGIN 
  INSERT into TIPO_CATEGORIA values(ID_TIPO_CATEGORIA, DESCRIPCION);
END PA_INSERTAR_TIPO_CATEGORIA;

--2.- /*==============TABLA HOTEL==============*/
/*==============Insertar procedimiento almacenado==============*/
create or replace PROCEDURE PA_INSERTAR_HOTEL(ID_HOTEL in INTEGER, ID_TIPO_CATEGORIA in INTEGER, NOMBRE in VARCHAR2,
                                              DIRECCION in VARCHAR2, TELEFONO in INTEGER)

AS 
BEGIN 
  INSERT into HOTEL values(ID_HOTEL, ID_TIPO_CATEGORIA, NOMBRE, DIRECCION, TELEFONO);
END PA_INSERTAR_HOTEL;

--3.--    /*==============TABLA CLIENTE==============*/
/*==============Insertar procedimiento almacenado==============*/
create or replace PROCEDURE PA_INSERTAR_CLIENTE(ID_CLIENTE in INTEGER, NOMBRE in VARCHAR2,
                                        APELLIDO in VARCHAR2, CEDULA in VARCHAR2, DIRECCION in VARCHAR2, CIUDAD in VARCHAR2, EDAD IN NUMBER)

AS 
BEGIN 
  INSERT into CLIENTE values(ID_CLIENTE, NOMBRE, APELLIDO, CEDULA, DIRECCION, CIUDAD, EDAD);
END PA_INSERTAR_CLIENTE;

--4.-- /*==============TABLA RESERVACION==============*/
/*==============Insertar procedimiento almacenado==============*/
create or replace PROCEDURE PA_INSERTAR_RESERVACION(ID_RESERVACION in INTEGER, ID_CLIENTE in INTEGER,
                                                      CANTIDAD_RESERVACION in INTEGER, PRECIO in NUMBER, FECHA_INICIO in DATE,
                                                      FECHA_FIN in DATE)

AS 
BEGIN 
  INSERT into RESERVACION values(ID_RESERVACION, ID_CLIENTE, CANTIDAD_RESERVACION, PRECIO, FECHA_INICIO, FECHA_FIN);
END PA_INSERTAR_RESERVACION;

--5.--/*==============TABLA TIPO_PAGO==============*/
/*==============Insertar procedimiento almacenado==============*/
create or replace PROCEDURE PA_INSERTAR_TIPO_PAGO(ID_TIPO_PAGO in INTEGER, DESCRIPCION in VARCHAR2)

AS 
BEGIN 
  INSERT into TIPO_PAGO values(ID_TIPO_PAGO, DESCRIPCION);
END PA_INSERTAR_TIPO_PAGO;

--6.--   /*==============TABLA FACTURA==============*/
/*==============Insertar procedimiento almacenado==============*/
create or replace PROCEDURE PA_INSERTAR_FACTURA(ID_FACTURA in INTEGER, ID_TIPO_PAGO IN INTEGER, ID_RESERVACION in INTEGER,
                                        TOTAL in NUMBER, FECHA in DATE, DESCUENTO IN NUMBER)

AS 
BEGIN 
  INSERT into FACTURA values(ID_FACTURA, ID_RESERVACION, ID_TIPO_PAGO, TOTAL, FECHA, DESCUENTO);
END PA_INSERTAR_FACTURA;

--7.-- /*==============TABLA HABITACION==============*/
/*==============Insertar procedimiento almacenado==============*/
create or replace PROCEDURE PA_INSERTAR_HABITACION(ID_HABITACION in INTEGER, ID_HOTEL in INTEGER,
                                       ID_RESERVACION in INTEGER, TIPO_HABITACION in VARCHAR2, CANTIDAD_HABITACION in INTEGER, ESTADO IN VARCHAR2)

AS 
BEGIN 
  INSERT into HABITACION values(ID_HABITACION, ID_HOTEL, ID_RESERVACION, TIPO_HABITACION, CANTIDAD_HABITACION, ESTADO);
END PA_INSERTAR_HABITACION;

--8.--/*=======ELIMINAR REGISTROS==========*/
/*===========Procedimiento almacenado==============*/
create or replace PROCEDURE PA_ELIMINAR_REGISTROS
AS 
BEGIN 
  DELETE FROM FACTURA;
  DELETE FROM TIPO_PAGO;
  DELETE FROM HABITACION;
  DELETE FROM RESERVACION;
  DELETE FROM CLIENTE;
  DELETE FROM HOTEL;
  DELETE FROM TIPO_CATEGORIA;
END PA_ELIMINAR_REGISTROS;

--9.--/*=======ELIMINAR REGISTRO DE LA TABLA FACTURA==========*/
   /*==============Procedimiento almacenado==============*/
create or replace PROCEDURE PA_ELIMINAR_FACTURA

AS 
BEGIN 
        DELETE FROM FACTURA;
END  PA_ELIMINAR_FACTURA;

--10.--/*===ACTUALIZAR REGISTRO DE LA TABLA CLIENTE======*/
   /*==============Procedimiento almacenado==============*/
create or replace PROCEDURE PA_ACTUALIZAR_DIRE_CLIENTE(COD IN INTEGER, DIRECCION_ACTU in VARCHAR2)

AS 
BEGIN 
  UPDATE CLIENTE SET DIRECCION = DIRECCION_ACTU WHERE ID_CLIENTE = COD;
END PA_ACTUALIZAR_DIRE_CLIENTE;
