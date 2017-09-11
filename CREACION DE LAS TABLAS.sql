--TABLAS

create table TIPO_CATEGORIA 
(
   ID_TIPO_CATEGORIA    INTEGER         not null,
   DESCRIPCION          VARCHAR2(30),
   constraint PK_TIPO_CATEGORIA primary key (ID_TIPO_CATEGORIA)
);

create table HOTEL 
(
   ID_HOTEL             INTEGER         not null,
   ID_TIPO_CATEGORIA    INTEGER         not null,
   NOMBRE               VARCHAR2(40),
   DIRECCION            VARCHAR2(50),
   TELEFONO             INTEGER,
   constraint PK_HOTEL primary key (ID_HOTEL)
);

create table TIPO_PAGO
(
   ID_TIPO_PAGO      INTEGER         not null,
   DESCRIPCION          VARCHAR2(30),
   constraint PK_TIPO_PAGO primary key (ID_TIPO_PAGO)
);

create table CLIENTE 
(
   ID_CLIENTE           INTEGER         not null,
   NOMBRE               VARCHAR2(40),
   APELLIDO             VARCHAR2(40),
   CEDULA               VARCHAR2(15)    NOT NULL,
   DIRECCION            VARCHAR2(50),
   CIUDAD               VARCHAR2(30),
   EDAD                 NUMBER(3)       NOT NULL,
   constraint PK_CLIENTE primary key (ID_CLIENTE)
);

create table RESERVACION 
(
   ID_RESERVACION       INTEGER         not null,
   ID_CLIENTE           INTEGER         NOT NULL,
   CANTIDAD_RESERVACION INTEGER,
   PRECIO               NUMBER(7,2),
   FECHA_INICIO         VARCHAR2,
   FECHA_FIN            VARCHAR2,
   constraint PK_RESERVACION primary key (ID_RESERVACION)
);

create table HABITACION 
(
   ID_HABITACION        INTEGER         not null,
   ID_HOTEL             INTEGER         NOT NULL,
   ID_RESERVACION       INTEGER         not null,
   TIPO_HABITACION      VARCHAR2(40),
   CANTIDAD_HABITACION  INTEGER,
   ESTADO               VARCHAR2(30),
   constraint PK_HABITACION primary key (ID_HABITACION)
);

create table FACTURA 
(
   ID_FACTURA           INTEGER         not null,
   ID_TIPO_PAGO         INTEGER         NOT NULL,
   ID_RESERVACION       INTEGER         NOT NULL,
   TOTAL                NUMBER(7,2),
   FECHA                DATE,
   DESCUENTO            NUMBER(4,2),
   constraint PK_FACTURA primary key (ID_FACTURA)
);

--RELACION ENTRE TABLAS

alter table HOTEL
   add constraint FK_HOTEL_TIPO_CATEGORIA foreign key (ID_TIPO_CATEGORIA)
      references TIPO_CATEGORIA (ID_TIPO_CATEGORIA);
      
alter table HABITACION
   add constraint FK_HABITACION_HOTEL foreign key (ID_HOTEL)
      references HOTEL (ID_HOTEL);

alter table HABITACION
   add constraint FK_HABITACION_RESERVACION foreign key (ID_RESERVACION)
      references RESERVACION (ID_RESERVACION);

alter table FACTURA
   add constraint FK_FACTURA_TIPO_PAGO foreign key (ID_TIPO_PAGO)
      references TIPO_PAGO (ID_TIPO_PAGO);
      
alter table RESERVACION
   add constraint FK_RESERVACION_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE);

alter table FACTURA
   add constraint FK_FACTURA_RESERVACION foreign key (ID_RESERVACION)
      references RESERVACION (ID_RESERVACION);