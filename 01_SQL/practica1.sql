-- 1. Crear la tabla limpia de ventas
CREATE TABLE ventas (
    id TEXT,
    vendedor TEXT,
    categoria TEXT,
    monto REAL,
    estatus TEXT
);

-- 2. Insertar los datos que ya limpiamos
INSERT INTO ventas VALUES 
('V-101', 'Pedro Perez', 'TECNOLOGIA', 150.00, 'Completado'),
('V-102', 'Maria Gomez', 'TECNOLOGIA', 200.50, 'Completado'),
('V-103', 'Pedro Perez', 'REPUESTOS', 50.00, 'Devuelto'),
('V-104', 'Carlos Sosa', 'TECNOLOGIA', 310.00, 'Completado'),
('V-105', 'Maria Gomez', 'REPUESTOS', 120.00, 'Completado'),
('V-106', 'Carlos Sosa', 'REPUESTOS', 0.00, 'Pendiente');

-- 3. Tu primera consulta SQL
SELECT * FROM ventas;

SELECT SUM(monto) AS total_pedro
FROM ventas
WHERE vendedor = 'Pedro Perez'
  AND categoria = 'TECNOLOGIA'
  AND estatus = 'Completado';

SELECT vendedor, SUM(monto) AS total_vendido
FROM ventas
WHERE estatus = 'Completado'
GROUP BY vendedor;

SELECT vendedor, SUM(monto) AS total_vendido
FROM ventas
WHERE estatus = 'Completado'
GROUP BY vendedor
ORDER BY total_vendido DESC;

SELECT vendedor, COUNT(*) AS cantidad_ventas
FROM ventas
WHERE estatus = 'Completado'
GROUP BY vendedor;

SELECT vendedor, COUNT(*) AS cantidad_ventas
FROM ventas
WHERE estatus = 'Completado'
GROUP BY vendedor
ORDER BY cantidad_ventas DESC;


SELECT vendedor, AVG(monto) AS promedio_ventas
FROM ventas
WHERE estatus = 'Completado'
GROUP BY vendedor
ORDER BY promedio_ventas DESC;

SELECT 
    vendedor,
    SUM(monto) AS total_vendido,
    COUNT(*) AS cantidad_ventas,
    ROUND(AVG(monto), 2) AS ticket_promedio
FROM ventas
WHERE estatus = 'Completado'
GROUP BY vendedor
ORDER BY total_vendido DESC;

SELECT 
    vendedor,
    SUM(monto) AS total_vendido,
    COUNT(*) AS cantidad_ventas,
    ROUND(AVG(monto), 2) AS ticket_promedio
FROM ventas
WHERE estatus = 'Completado'
GROUP BY vendedor
ORDER BY total_vendido DESC;

SELECT 
    vendedor,
    SUM(monto) AS total_vendido,
    COUNT(*) AS cantidad_ventas,
    ROUND(AVG(monto), 2) AS ticket_promedio
FROM ventas
WHERE estatus = 'Completado'
GROUP BY vendedor
HAVING SUM(monto) > 200
ORDER BY total_vendido DESC;


SELECT 
    vendedor,
    SUM(monto) AS total_vendido,
    COUNT(*) AS cantidad_ventas,
    ROUND(AVG(monto), 2) AS ticket_promedio
FROM ventas
WHERE estatus = 'Completado'
GROUP BY vendedor
HAVING COUNT(*) > 1
ORDER BY total_vendido DESC;

-- Creamos la tabla de datos de vendedores
CREATE TABLE IF NOT EXISTS vendedores (
    nombre TEXT,
    sucursal TEXT
);

-- Insertamos la sucursal de cada uno
INSERT INTO vendedores VALUES 
('Maria Gomez', 'Centro'),
('Carlos Sosa', 'Norte'),
('Pedro Perez', 'Sur');

select * from vendedores;

SELECT 
    v.vendedor,
    s.sucursal,
    SUM(v.monto) AS total_vendido
FROM ventas v
JOIN vendedores s ON v.vendedor = s.nombre
WHERE v.estatus = 'Completado'
GROUP BY v.vendedor, s.sucursal;

INSERT INTO ventas (id, vendedor, categoria, monto, estatus) 
VALUES ('V-107', 'Ana Rivas', 'TECNOLOGIA', 100.0, 'Completado');

SELECT 
    v.vendedor,
    s.sucursal,
    SUM(v.monto) AS total_vendido
FROM ventas v
LEFT JOIN vendedores s ON v.vendedor = s.nombre
WHERE v.estatus = 'Completado'
GROUP BY v.vendedor, s.sucursal;

SELECT 
    v.vendedor,
    COALESCE(s.sucursal, 'Sin Asignar') AS sucursal,
    SUM(v.monto) AS total_vendido
FROM ventas v
LEFT JOIN vendedores s ON v.vendedor = s.nombre
WHERE v.estatus = 'Completado'
GROUP BY v.vendedor, s.sucursal;
