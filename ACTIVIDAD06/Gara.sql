CREATE TABLESPACE ACTIVIDAD05
DATAFILE 'ACTIVIDAD05.DBF'
SIZE 5M
AUTOEXTEND ON;

ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER Gara
IDENTIFIED BY "1234"
DEFAULT TABLESPACE ACTIVIDAD05;
GRANT DBA TO Gara;

CREATE TABLE Tarea(
    codigo varchar2(6) primary key,
    nombre varchar2(30),
    descripcion varchar2(200),
    usuario varchar2(30),
    fecha date,
    realizada varchar(1) not null check(realizada in('S','N')),
    horas number
)TABLESPACE ACTIVIDAD05;

// 1. 5 insert para la tabla tarea

INSERT INTO tarea(codigo, nombre, descripcion, usuario, fecha, realizada,horas)
VALUES ('01', 'Organizacion dia', 'Reinion diaria', 'Pedro', TO_DATE('15/12/2023', 'DD/MM/YYYY'), 'S', 1);

INSERT INTO tarea (codigo, nombre, descripcion, usuario, fecha, realizada, horas)
VALUES ('02', 'Actualizacion cliente', 'informar casos', 'Robin', TO_DATE('15/12/2023', 'DD/MM/YYYY'), 'S', 2);

INSERT INTO tarea (codigo, nombre, descripcion, usuario, fecha, realizada, horas)
VALUES ('03', 'realizar informes', 'tareas administrativas', 'Alicia', TO_DATE('15/12/2023', 'DD/MM/YYYY'), 'S', 3);

INSERT INTO tarea (codigo, nombre, descripcion, usuario, fecha, realizada, horas)
VALUES ('04', 'Realizar check semanales', 'Tareas pendientes', 'Carla', TO_DATE('22/12/2023', 'DD/MM/YYYY'), 'N', 0);

INSERT INTO tarea (codigo, nombre, descripcion, usuario, fecha, realizada, horas)
VALUES ('05', 'actualizar programas clientes', 'ver peticiones', 'Elisa', TO_DATE('22/12/2023', 'DD/MM/YYYY'), 'S', 2);

SELECT * FROM tarea;

// 2. mostrarTareas
    
    CREATE OR REPLACE PROCEDURE mostrarTarea(p_codigo IN VARCHAR2) AS
  v_tarea tarea%ROWTYPE;
BEGIN
  -- Utilizar un cursor para obtener los datos de la tarea
  FOR tarea_rec IN (SELECT * FROM tarea WHERE codigo = p_codigo) LOOP
    -- Almacenar la fila completa en la variable de tipo ROWTYPE
    v_tarea := tarea_rec;
    DBMS_OUTPUT.PUT_LINE('Código: ' || v_tarea.codigo);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_tarea.nombre);
    DBMS_OUTPUT.PUT_LINE('Descripción: ' || v_tarea.descripcion);
    DBMS_OUTPUT.PUT_LINE('Usuario: ' || v_tarea.usuario);
    DBMS_OUTPUT.PUT_LINE('Fecha: ' || TO_CHAR(v_tarea.fecha, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Realizada: ' || v_tarea.realizada);
    DBMS_OUTPUT.PUT_LINE('Horas: ' || v_tarea.horas);
  END LOOP;

  -- Verificar si se encontró la tarea
  IF v_tarea.codigo IS NULL THEN
    -- Lanzar una excepción si no se encontró la tarea
    RAISE_APPLICATION_ERROR(-20001, 'Tarea no encontrada');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Capturar cualquier excepción no manejada
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

