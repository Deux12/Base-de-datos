
drop database if exists jugueteria;

create database jugueteria;

use jugueteria;

create table Articulo (
Cod_art VARCHAR(10) not null primary key,
Descrip text not null,
Uds INT default 0 not null,
PVenta real not null,
constraint ck_stock check (Uds >= 0),
constraint ck_pventa check (PVenta >= 0)
);

create table Cajero (
Nomb_caj VARCHAR(10) not null primary key
);

create table Reg_caja (
Cod_reg INT not null primary key,
Nomb_caj VARCHAR(10) not null,
F_inicio TIMESTAMP not null,
F_fin TIMESTAMP,
constraint fk_cajero foreign key (Nomb_caj) references Cajero(Nomb_caj) on
delete
	no action on
	update
		cascade,
		constraint ck_fechas check (F_fin > F_inicio
			or F_fin is null),
		constraint ck_fecha_inicio check (F_inicio >= '1.1.2015')
);

create table Ticket (
Cod_tic VARCHAR(20) not null primary key,
Nomb_caj VARCHAR(10) not null,
Efectivo boolean not null,
Fecha_hora TIMESTAMP default CURRENT_TIMESTAMP not null,
constraint fk_cajero_2 foreign key (Nomb_caj) references Cajero(Nomb_caj) on
delete no action on
update cascade,
constraint ck_fecha check (Fecha_hora >= '1.1.2015')
);

create table Tic_art (
Cod_art VARCHAR(10) not null,
Cod_tic VARCHAR(20) not null,
Uds INT not null,
PVenta real not null,
constraint pk_tic_art primary key (Cod_art,
Cod_tic),
constraint fk_articulo foreign key (Cod_art) references Articulo(Cod_art) on
delete
	no action on
	update
		cascade,
		constraint fk_ticket foreign key (Cod_tic) references Ticket(Cod_tic) on
		delete
			cascade on
			update
				cascade,
				constraint ck_pventa_2 check (PVenta >= 0)
# constraint ck_uds check (Uds > 0 and Uds <=( select Articulo.Uds from Articulo where Articulo.Cod_art = Tic_art.Cod_art)),
);

delete from	articulo ;

delete from	cajero ;

delete from	reg_caja ;

delete from	ticket ;

delete from	tic_art ;
# Insertamos valores en las tablas para probar las consultas
insert
	into
	articulo(Cod_art,
	Descrip,
	Uds,
	PVenta)
values ('001', 'Muñeco de plastico', 10, 15),
('002', 'Pelota de goma', 20, 20),
('003', 'Paquete de piezas montables', 35, 10.5),
('004', 'Baraja de Cartas', 5, 5),
('005', 'Peluche', 14, 6),
('006', 'Mini futbolin', 2, 23),
('007', 'Yo-yo', 25, 4),
('008', 'Bicicleta', 23, 199),
('009', 'Muñeco de acción', 50, 25),
('010', 'Muñeca', 32, 9.5),
('011', 'Cometa', 7, 8);insert into cajero (Nomb_caj) values ('Julio'),('Maria'),('Emilio');insert into reg_caja (Cod_reg,Nomb_caj,F_inicio,F_fin)
values (1,'Julio','2015-01-06 10:00:00','2015-01-06 18:00:00'),
(2,'Maria','2015-01-07 10:00:00','2015-01-07 18:00:00'),
(3,'Julio','2015-01-08 10:00:00','2015-01-08 14:00:00'),
(4,'Maria','2015-01-08 14:00:00','2015-01-08 18:00:00'),
(5,'Julio','2015-01-09 10:00:00','2015-01-09 18:00:00'),
(6,'Maria','2015-01-10 10:00:00','2015-01-10 18:00:00'),
(7,'Julio','2015-01-11 10:00:00','2015-01-11 18:00:00'),
(8,'Maria','2015-01-12 10:00:00','2015-01-12 18:00:00'),
(9,'Emilio','2015-01-13 10:00:00','2015-01-13 18:00:00'),
(10,'Julio','2015-01-14 10:00:00','2015-01-14 18:00:00'),
(11,'Emilio','2015-01-15 10:00:00','2015-01-15 18:00:00'),
(12,'Maria','2015-01-16 10:00:00','2015-01-16 18:00:00'),
(13,'Julio','2015-01-01 10:00:00',null),
(14,'Maria','2016-05-01 10:00:00','2016-05-04 18:00:00'),
(15, 'Maria', CURRENT_DATE, null);insert into ticket (Cod_tic,Nomb_caj,Efectivo,Fecha_hora)
values ('001', 'Julio', 1, '2015-01-06 11:00:00'),
('002', 'Julio', 1, '2015-01-08 13:00:00'),
('003', 'Julio', 1, '2015-01-09 12:00:00'),
('004', 'Julio', 1,'2015-01-14 10:30:00'),
('005', 'Maria', 0, '2015-01-07 14:00:00'),
('006', 'Maria', 0, '2015-01-07 17:00:00'),
('007', 'Maria', 1, '2015-01-10 13:00:00'),
('008', 'Maria', 1, '2015-01-10 11:30:00'),
('009', 'Maria', 1, '2015-01-16 10:20:00'),
('010', 'Emilio', 1, '2015-01-13 14:00:00'),
('011', 'Emilio', 0, '2015-01-15 16:00:00'),
('012', 'Maria', 0, '2016-05-01 14:00:00'),
('013', 'Emilio', 1, '2016-05-01 14:00:00'),
('014', 'Maria', 1, CURRENT_DATE),
('015', 'Maria', 0, CURRENT_DATE),
('016', 'Emilio', 1, CURRENT_DATE);insert into tic_art (Cod_art,Cod_tic,Uds,PVenta)
values ('001', '001', 1, 15),
('003', '002', 2, 21),
('002', '003', 3, 60),
('004', '004', 2,10),
('007', '004', 1,4),
('008', '005', 1, 199),
('009', '006', 4, 100),
('006', '007', 2, 46),
('010', '008', 2, 19),
('008', '009', 1, 199),
('011', '010', 1, 8),
('004', '011', 1, 5),
('011','012',1,8),
('008', '014', 1, 199),
('008', '015', 1, 199),
('009','013',1,25),
('009','016',1,25);

/*
* 1. Obtener a partir de los tickets de caja el importe total vendido en efectivo por
cada empleado en el día actual.
* */

SELECT Nomb_caj, SUM(PVenta * Uds) AS ImpTotal
FROM Ticket t INNER JOIN Tic_art ta ON t.Cod_tic = ta.Cod_tic
WHERE CAST(Fecha_hora AS DATE) = CURRENT_DATE AND Efectivo = 1
GROUP BY Nomb_caj;

/*
* 2. Mostrar el nombre del empleado que ha vendido más artículos durante el año
2015.
* */
SELECT Nomb_caj
FROM Ticket t INNER JOIN Tic_art ta ON t.Cod_tic = ta.Cod_tic
WHERE EXTRACT(YEAR FROM Fecha_hora) = 2015 GROUP BY Nomb_caj
HAVING SUM(Uds) = ( SELECT MAX(Ventas2015) FROM ( SELECT SUM(Uds) AS Ventas2015 FROM Ticket t2 INNER JOIN Tic_art ta2
ON t2.Cod_tic = ta2.Cod_tic WHERE EXTRACT(YEAR FROM Fecha_hora) = 2015 GROUP BY Nomb_caj ) as ventas
);
/*
* 3. Listar los artículos que no se han vendido en el mes de mayo de 2016,
ordenados por el número de existencias, de mayor a menor.
* */

SELECT * FROM Articulo a WHERE a.Cod_art NOT in
( SELECT Cod_Art FROM Ticket t INNER JOIN Tic_art ta
ON t.Cod_tic = ta.Cod_tic WHERE CAST(Fecha_hora AS DATE) BETWEEN '2016-05-01 00:00:00' AND '2016-05-31 23:59:59'
) ORDER BY Uds DESC;

# La consulta para obtener el listado de tickets erróneos sería:
SELECT Ticket.*
FROM Ticket, Reg_caja
WHERE Ticket.Nomb_caj <> Reg_caja.Nomb_caj and Fecha_hora
BETWEEN F_inicio AND F_fin;

# Escribir el SQL necesario para añadir a la BD un mecanismo que verifique que el
# nombre del usuario que figura en un ticket cuando se crea se corresponde con el
# usuario que está usando la caja en ese momento.

DELIMITER $$

drop trigger if exists verificar_usuario$$
create trigger verificar_usuario
before insert on ticket
for each row 
begin 
	declare cajero_actual varchar(15);
	set cajero_actual = (select rc.Nomb_caj from reg_caja rc where (now() between F_inicio and F_fin)or (now()>=F_inicio and F_fin is null)limit 1);
	if new.Nomb_caj <> cajero_Actual then
	set new.Nomb_caj = cajero_actual;
end if;
end

DELIMITER ; 

# Crear una vista que muestre para cada ticket únicamente la información
# correspondiente a la fecha y a su importe total, desglosado en base e IVA.
/*
DELIMITER //
drop procedure if exists ajustaVendedorTicket 

CREATE PROCEDURE ajustaVendedorTicket ( IN ticket VARCHAR(20) )
BEGIN
DECLARE vendedorANT, vendedorNUEVO VARCHAR(10);
DECLARE fechaTicket TIMESTAMP;
SELECT Nomb_caj, Fecha_hora INTO vendedorANT, fechaTicket FROM Ticket WHERE Cod_tic = ticket;
SELECT Nomb_caj INTO vendedorNUEVO FROM Reg_caja WHERE fechaTicket BETWEEN F_inicio AND F_fin;
IF vendedorANT <> vendedorNUEVO THEN
INSERT INTO RegistroCambios (Cod_tic, Nomb_caj_antiguo, Nomb_caj_nuevo)
VALUES (ticket, vendedorANT, vendedorNUEVO);
UPDATE Ticket SET Nomb_caj = vendedorNUEVO WHERE Cod_tic = ticket;
END IF;
END;

DELIMITER ; */

# Modificar la información que se guarda de cada artículo para añadir el porcentaje de
# IVA que le corresponde, poniendo 21% a los ya existentes.

ALTER TABLE Articulo ADD IVA REAL DEFAULT 0.21;
UPDATE Articulo SET IVA = 0.21;

#Crear una vista que muestre para cada ticket únicamente la información
#correspondiente a la fecha y a su importe total, desglosado en base e IVA.

create view  resumen_ticket as 
SELECT t.Fecha_hora AS Fecha, CONCAT(SUM(ta.Uds * a.PVenta), "€") AS Importe,
FORMAT(SUM(ta.Uds * a.PVenta * a.iva / (1 + a.iva)),2) AS Importe_IVA,
FORMAT(SUM(ta.Uds * a.PVenta / (1 + a.iva)),2) AS Importe_Base
FROM Ticket t, Tic_Art ta, Articulo a where a.Cod_art = ta.Cod_art and t.Cod_tic = ta.Cod_tic group by t.Cod_tic ;

#Crear tres roles en la BD: admin, cajero y supervisor. Definir permisos sobre la BD
#de forma que los usuarios con el rol cajero puedan introducir, borrar y actualizar la
#información correspondiente a las ventas; los usuarios del rol supervisor únicamente
#podrán acceder a la información que proporciona la vista creada en el paso anterior.
#Los usuarios del rol admin tienen acceso total a la BD.

drop role if exists admin;
drop role if exists cajero;
drop role if exists supervisor;

create role if not exists admin;
create role if not exists cajero;
create role if not exists supervisor;

grant all privileges on articulo to admin;
grant all privileges on cajero to admin;
grant all privileges on reg_caja to admin;
grant all privileges on tic_art to admin;
grant all privileges on ticket to admin;

grant select, insert, delete on articulo to cajero;
grant select, insert, delete on ticket to cajero;
grant select, insert, delete on tic_art to cajero;

grant show view on resumen_ticket to supervisor;

#Programar una función que obtenga el nombre del usuario que está usando la caja
#en el momento actual

SET GLOBAL log_bin_trust_function_creators = 1;

delimiter $$

drop function if exists actual_user $$
create function actualUser()
returns varchar(10)

begin
		declare caj varchar(10);
		select rc.Nomb_caj into caj
		from reg_caja rc where rc.F_fin is null;
		return caj;
	
end $$

delimiter ;

#y otro que devuelva el nombre del último usuario que usó la
#caja si no hay nadie usándola (si está abierta debe devolver NULL).

delimiter $$

drop function if exists lastUser $$
create function lastUser()
returns varchar(10)

begin
	
	declare caj varchar(10);
		select rc.Nomb_caj into caj
		from reg_caja rc where rc.F_fin = (select max(rc.F_fin) from reg_caja rc);
		return caj;
end;
$$

delimiter ;

#Añadir un mecanismo para que, cada vez que la caja se asigne a un usuario, a éste
#le sea asignado en ese momento el rol cajero; este rol le debe ser retirado cuando el
#usuario ya no tenga asignada la caja.

delimiter $$

drop trigger if exists actualizar_cajero $$
create trigger actualizar_cajero after insert on reg_caja
for each row 

BEGIN
	DECLARE grt VARCHAR(50);
	SET grt = ' GRANT cajero TO ' or new.Nomb_caj or ';';
	call grt;
END;
	
$$

delimiter ;


#Crear una nueva tabla Pedido, que almacena para cada artículo el número de uds
#que se piden, la fecha en que se registra el pedido, la fecha en que se lleva a cabo,
#y la fecha en que se recibe. Estos dos últimos campos tendrán valor NULL mientras
#no se pide y recibe el artículo, respectivamente.

create table pedido(

cod int primary key auto_increment,
art varchar(10),
uds int not null,
fecha_reg timestamp,
fecha_c timestamp default null,
fecha_rec timestamp default null,

foreign key (art) references articulo(Cod_art)
	on delete cascade
	on update cascade
);

#Añadir a cada artículo un campo que indique el número de uds óptimo que se deben
#tener en tienda del mismo (por defecto 6).

alter table articulo
add column op_uds int default '6';
	
#Crear un procedimiento nuevo que
#registre para cada artículo con X o menos uds disponibles (X es un valor variable)
#una nueva línea de pedido por tantas uds como hagan falta para alcanzar las uds
#óptimas.
#Se debe tener en cuenta que ya puede existir un pedido para ese artículo pendiente
#de ser llevado a cabo. En ese caso, solamente se deberá ajustar el número de uds a
#pedir

DROP PROCEDURE IF EXISTS registro_art;
DELIMITER $$

CREATE PROCEDURE registro_art()
BEGIN
	DECLARE n INT DEFAULT 0;
	DECLARE i INT DEFAULT 0;
	declare uds_nec int;
	SELECT COUNT(*) FROM articulo a  INTO n;
	SET i=0;
	WHILE i<n DO 
	if a.Uds < a.op_uds then 
	select (a2.op_uds - a2.Uds) as resta from articulo a2 into uds_nec ;
	insert into pedido(cod,art,uds,fecha_reg,fecha_c,fecha_rec) values 
	('001',a.Descrip,uds_nec,CURRENT_DATE,null,null);
	end if;
	  SET i = i + 1;
END WHILE;
End;
$$

delimiter ;

#Crear un disparador que registre un nuevo pedido de un artículo cuando la tienda se
#quede sin stock o con solo una unidad del mismo.

delimiter $$

drop trigger if exists register_art $$

create trigger register_art after delete on articulo
for each row 
begin 

	if a.Uds <= 1 then 
	insert into pedido (cod,art,uds,fecha_reg,fecha_c,fecha_rec) 
	values ('001',a.Descrip,'1',CURRENT_DATE,null,null);
	end if;
end; 

$$

delimiter ;

#Crear un procedimiento que ponga como recibido con la fecha actual el pedido de un
#artículo dado, aumentando el stock del mismo en el número de uds recibidas.


delimiter $$

drop procedure if exists recb_art $$
create procedure recb_pedido (in pedido int)

begin 
	
	declare stock int;
	declare nomb varchar(10);
	
	update pedido p set p.fecha_rec = current_timestamp();
	select a.Uds from articulo a into stock;
	select a.Descrip from articulo a into nomb;
	update pedido p set p.uds = stock;
	
end;
$$

delimiter ;


