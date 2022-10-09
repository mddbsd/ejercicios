CREATE DABABASE cfl414
/********************************TABLAS***********************************/
CREATE TABLE tb_curs (
    id_curs int NOT NULL AUTO_INCREMENT, 
    nom_curs varchar(45), 
    desc_curs varchar(100), 
    inscriptos int(3), 
    PRIMARY KEY(id_curs)
);

CREATE TABLE tb_dias (
    id_dia int NOT NULL, 
    dia varchar(10),
    PRIMARY KEY id_dias
);

CREATE TABLE tb_horarios (
    id_curs int NOT NULL, 
    id_dia int NOT NULL,
    hr_inicio time,
    hr_fin time,
    PRIMARY KEY(id_curs, id_dia),
    FOREIGN KEY(id_curs) REFERENCES tb_curs(id_curs),
    FOREIGN KEY(id_dia) REFERENCES tb_dias(id_dia)
);

CREATE TABLE tb_postulantes (
    dni_post int NOT NULL,
    cuil_post int NOT NULL,
    apyn_post varchar(40),
    email_post varchar(40) NOT NULL,
    tel_post varchar(20),
    dir_local varchar(20),
    dir_calle varchar(20),
    dir_num varchar(20),
    dir_piso int(10),
    dir_dpto int(10),
    prov_post varchar(40),
    pais_post varchar(40),
    fnac_post date,
    edad_post int(2),
    plans_post int(1),
    gen_post varchar(10),
    titulo_post varchar(20),
    estado_post int(1)
);

/*******************************INSERTS**************************************/
insert into tb_dias 
values (1, 'lunes'),
       (2, 'martes'),
       (3, 'miercoles'),
       (4, 'jueves'),
       (5, 'viernes')
;
INSERT INTO tb_horarios (id_curs, id_dia, hr_inicio, hr_fin)
VALUES (1,1,'9:10','12:00'),
       (1,3,'9:10','12:00'),
       (1,5,'9:10','12:00'),
       (3,1,'12:00','15:00'),
       (3,3,'12:00','15:00'),
       (3,5,'13:00','16:00'),
       (2,5,'13:00','16:00'),
       (4,1,'12:00','15:00'),
       (4,2,'12:00','16:00'),
       (5,1,'9:00','12:00'),
       (5,2,'9:00','12:00')
);
INSERT INTO tb_curs (nom_curs, desc_curs, inscriptos) 
VALUES ('programacion', 'curso de introduccion a la programacion', 14), 
       ('maquillaje','maquillaje artistico', 9), 
       ('electricidad', 'cortaste toda la loz', 20), 
       ('costura','corte y confeccion', 9),
       ('hoteleria','administracion de hoteles',12),
       ('zapateria','reparacion de calzado',16)
);

/********************************CONSULTAS************************************/
SELECT tb_curs.nom_curs AS nom_curs, 
       tb_dias.dia AS dia, 
       tb_horarios.hr_inicio AS hr_inicio, 
       tb_horarios.hr_fin AS hr_fin 
FROM tb_horarios 
    JOIN tb_curs 
        ON tb_horarios.id_curs= tb_curs.id_curs 
    JOIN tb_dias 
        ON tb_horarios.id_dia= tb_dias.id_dia
    AND nom_curs='programacion';

SELECT id_curs, inscriptos FROM tb_curs WHERE id_curs= ?

/*******************************UPDATES***************************************/
UPDATE tb_curs SET inscriptos= ? WHERE id_curs= ?;
/**********************************PRUEBAS************************************/
SELECT nom_curs FROM tb_curs;

SELECT tb_curs.nom_curs AS nom_curs, tb_dias.dia AS dia, tb_horarios.hr_inicio AS hr_inicio, tb_horarios.hr_fin AS hr_fin FROM tb_horarios JOIN tb_curs ON tb_horarios.id_curs= tb_curs.id_curs JOIN tb_dias ON tb_horarios.id_dia= tb_dias.id_dia;
SELECT tb_horarios.hr_inicio AS hr_inicio, tb_horarios.hr_fin AS hr_fin FROM tb_horarios JOIN tb_curs ON tb_horarios.id_horario=tb_curs.id_curs;
INSERT INTO tb_horarios (id_curs, id_dia, hr_inicio, hr_fin)
VALUES (3,1,'12:00','15:00'),
       (3,3,'12:00','15:00'),
       (3,5,'13:00','16:00'),
       (2,5,'13:00','16:00'),
       (4,1,'12:00','15:00'),
       (4,2,'12:00','16:00'),
       (5,1,'9:00','12:00'),
       (5,2,'9:00','12:00');
INSERT INTO tb_cursos