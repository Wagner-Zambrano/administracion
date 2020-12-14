create table usuario
(id int primary key not null, nombre varchar(30), direccion varchar(20), ciudad varchar(15), 
pais varchar(10), sexo varchar(10), orientacionsexual varchar(15));

insert into usuario (id, nombre, direccion, ciudad, pais, sexo, orientacionsexual) values
(1, 'juan', 'av manabi', 'portoviejo','ecuador','masculino', 'heterosexual'),
(2, 'mario', 'la pradera', 'manta','ecuador','masculino', 'heterosexual'),
(3, 'maria', 'malecon', 'manta','ecuador','femenina', 'bisexual'),
(4, 'diana', 'proaño', 'montecristi','ecuador','femenina', 'heterosexual'),
(5, 'pablo', 'manta 2000', 'manta','ecuador','masculino', 'homosexual');

select *from usuario;

create table citas
(idc int primary key not null,direccion varchar(15), quien_cita varchar(24), lugar varchar(40), hora time,
motivo_fracaso varchar(20), idusuario int,
CONSTRAINT fk_usuario FOREIGN KEY (idusuario) REFERENCES usuario (id));

insert into citas (idc, direccion, quien_cita, lugar,hora, motivo_fracaso, idusuario) values
(6, 'urbirrio','masculino','parque','16:00:00','mala presentacion',1),
(7, 'la pradera','femenino','piscina','12:00:00','malos habitos',2),
(8, 'malecon','masculino','restaurante','10:00:00','malos habitos',3),
(9, 'av manabi','femenino','parque','13:00:00','origenes',4),
(10, 'la padrera','masculino','piscina','13:00:00','origenes',5),
(16, 'malecon','masculino','parque','13:00:00','origenes',5),
(17, 'proaño','femenino','piscina','13:00:00','malos habitos',5),
(18, 'proaño','femenino','restaurante','13:00:00','malos habitos',5),
(19, 'urbirrio','masculino','parque','13:00:00','mala presentacion',5),
(20, 'urbirrio','masculino','motel','13:00:00','origenes',5),
(21, 'urbirrio','masculino','motel','13:00:00','origenes',5);

select*from citas;


create table gustos
(idg int primary key not null, tipo varchar(15), preferencia varchar(30), idusuario int, idcitas int,
CONSTRAINT fk_usuario1 FOREIGN KEY (idusuario) REFERENCES usuario (id),
CONSTRAINT fk_citas FOREIGN KEY (idcitas) REFERENCES citas (idc));

insert into gustos(idg, tipo, preferencia, idusuario, idcitas) values
(11,'deporte','masculino',1,6),
(12,'musica','femenino',2,7),
(13,'musica','femenino',3,8),
(14,'evento','masculino',4,9),
(15,'deporte','futbol',4,10);

select*from gustos;


create table estado
(ide int primary key not null, descripcion varchar (40), idcitas int, 
CONSTRAINT fk_citas1 FOREIGN KEY (idcitas) REFERENCES citas (idc));

insert into estado(ide, descripcion, idcitas) values
(16,'exitosa',6),
(17,'fallida',7),
(18,'fallida',8),
(19,'exitosa',9),
(20,'exitosa',10);

select*from estado;

/*1*/
select direccion, COUNT (direccion) as citas_ciegas from citas
group by direccion having COUNT(direccion) >1;

/*2*/
SELECT        dbo.estado.descripcion, dbo.usuario.sexo, dbo.usuario.ciudad
FROM            dbo.usuario INNER JOIN
                         dbo.citas ON dbo.usuario.id = dbo.citas.idusuario INNER JOIN
                         dbo.estado ON dbo.citas.idc = dbo.estado.idcitas
WHERE        (dbo.estado.descripcion = 'exitosa')

/*3*/
select motivo_fracaso, COUNT (motivo_fracaso) as motivo from citas
group by motivo_fracaso having COUNT(motivo_fracaso) >1;

/*4*/
SELECT        dbo.usuario.nombre, dbo.gustos.preferencia, dbo.gustos.tipo, dbo.citas.citas_pasadas, dbo.estado.descripcion, dbo.citas.motivo_fracaso
FROM            dbo.citas INNER JOIN
                         dbo.estado ON dbo.citas.idc = dbo.estado.idcitas INNER JOIN
                         dbo.gustos ON dbo.citas.idc = dbo.gustos.idcitas INNER JOIN
                         dbo.usuario ON dbo.citas.idusuario = dbo.usuario.id AND dbo.gustos.idusuario = dbo.usuario.id





