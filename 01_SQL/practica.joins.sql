-- 1. Crear las tablas
CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre_producto TEXT,
    categoria TEXT
);

CREATE TABLE movimientos_almacen (
    id_movimiento INTEGER PRIMARY KEY,
    id_producto INTEGER,
    cantidad INTEGER,
    tipo TEXT
);

-- 2. Insertar datos de prueba
INSERT INTO productos VALUES (1, 'Harina PAN', 'Víveres');
INSERT INTO productos VALUES (2, 'Arroz', 'Víveres');
INSERT INTO productos VALUES (3, 'Refresco', 'Bebidas');

-- Harina y Arroz tienen movimiento. El Refresco NO va a tener movimiento.
INSERT INTO movimientos_almacen VALUES (101, 1, 50, 'Entrada');
INSERT INTO movimientos_almacen VALUES (102, 1, 10, 'Salida');
INSERT INTO movimientos_almacen VALUES (103, 2, 20, 'Entrada');

-- 3. Nuestra consulta con LEFT JOIN
SELECT 
    p.nombre_producto,
    m.cantidad,
    m.tipo
FROM productos p
LEFT JOIN movimientos_almacen m ON p.id_producto = m.id_producto;

SELECT 
    p.nombre_producto,
    COALESCE(SUM(m.cantidad), 0) AS total_movido
FROM productos p
LEFT JOIN movimientos_almacen m ON p.id_producto = m.id_producto
GROUP BY p.id_producto, p.nombre_producto;

SELECT 
    p.categoria,
    m.tipo,
    m.cantidad
FROM productos p
LEFT JOIN movimientos_almacen m ON p.id_producto = m.id_producto;

SELECT 
    p.categoria,
    m.tipo,
    m.cantidad
FROM productos p
LEFT JOIN movimientos_almacen m ON p.id_producto = m.id_producto
where m.tipo = 'Entrada';

SELECT 
    p.categoria,
    SUM(m.cantidad) AS total_entradas
FROM productos p
LEFT JOIN movimientos_almacen m ON p.id_producto = m.id_producto
WHERE m.tipo = 'Entrada'
GROUP BY p.categoria;

SELECT 
    p.categoria,
    SUM(m.cantidad) AS total_entradas
FROM productos p
LEFT JOIN movimientos_almacen m ON p.id_producto = m.id_producto
WHERE m.tipo = 'Entrada'
GROUP BY p.categoria
HAVING total_entradas >= 80;

SELECT 
    p.nombre_producto,
    m.tipo,
    m.cantidad,
    CASE 
        WHEN m.tipo = 'Entrada' THEN m.cantidad
        WHEN m.tipo = 'Salida' THEN -m.cantidad
        ELSE 0
    END AS valor_transformado
FROM productos p
LEFT JOIN movimientos_almacen m ON p.id_producto = m.id_producto;

SELECT 
    p.nombre_producto,
    SUM(
        CASE 
            WHEN m.tipo = 'Entrada' THEN m.cantidad
            WHEN m.tipo = 'Salida' THEN -m.cantidad
            ELSE 0
        END
    ) AS balance_neto
FROM productos p
LEFT JOIN movimientos_almacen m ON p.id_producto = m.id_producto
GROUP BY p.nombre_producto;

git add .
git commit -m "Agrega ejercicios de HAVING y CASE WHEN"
git push

git status

git status


