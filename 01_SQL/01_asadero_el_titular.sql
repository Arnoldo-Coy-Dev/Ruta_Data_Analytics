-- 1. Crear tabla de categorías
CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL
);

-- 2. Crear tabla de productos (Menú Real de El Titular)
CREATE TABLE IF NOT EXISTS productos (
    id_producto INT PRIMARY KEY,
    id_categoria INT,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_venta DECIMAL(10, 2) NOT NULL,
    costo_estimado DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- 3. Crear tabla de ventas
CREATE TABLE IF NOT EXISTS ventas_detalle (
    id_venta INT PRIMARY KEY,
    id_producto INT,
    cantidad INT NOT NULL,
    fecha_venta DATE NOT NULL,
    hora_venta TIME NOT NULL,
    metodo_pago VARCHAR(20),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Inserción de Categorías
INSERT INTO categorias (id_categoria, nombre_categoria) VALUES
(1, 'Pollos Asados'),
(2, 'Pollo a la Broaster'),
(3, 'Pollo Asado y Arroz'),
(4, 'Combos Broaster y Arroz'),
(5, 'Parrillas'),
(6, 'Arroz Chino'),
(7, 'Especiales y Otros'),
(8, 'Adicionales y Bebidas');

-- Inserción de Productos (Muestra del Menú)
INSERT INTO productos (id_producto, id_categoria, nombre_producto, descripcion, precio_venta, costo_estimado) VALUES
(101, 1, 'Pollo Entero Asado', 'Pollo entero + 10 arepas + 2 ensaladas + queso + salsas', 18.00, 7.20),
(102, 1, 'Medio Pollo Asado', '1/2 pollo + 6 arepas + 1 ensalada + queso + salsas', 10.00, 4.00),
(201, 2, 'Pollo Entero Broaster', '10 piezas + 400gr papas + 2 ensaladas', 20.00, 7.80),
(303, 3, 'Asado Para 4', '1 pollo + arroz chino esp. + 10 arepas + 1 queso + 2 ensaladas + refresco 1.5lt', 23.00, 9.20),
(404, 4, 'Combo Familiar Broaster', '10 piezas + arroz chino esp. + 400gr papas + 2 ensaladas + refresco 1.5lt', 30.00, 11.50),
(508, 5, 'Parrilla Pollo, Carne y Puerco', '1/4 pollo + 250gr carne + 250gr puerco + 10 arepas + 2 ensaladas', 16.00, 6.80),
(510, 5, 'Parrilla La Titular', '1 pollo + 400gr carne + 400gr puerco + 3 chorizos + 20 arepas + queso + refresco 1.5lt', 35.00, 14.00),
(604, 6, 'Arroz Chino Especial Combo', 'Para 4 personas + servicio papas + refresco 1lt', 10.00, 3.20),
(701, 7, 'Arepa Llanera', 'Arepa rellena llanera', 4.00, 1.40),
(806, 8, 'Refresco 1.5L', 'Refresco familiar', 2.00, 0.90);

-- Ventas de Fin de Semana
INSERT INTO ventas_detalle (id_venta, id_producto, cantidad, fecha_venta, hora_venta, metodo_pago) VALUES
(1, 101, 18, '2026-08-14', '13:15:00', 'Zelle'),
(2, 510, 8,  '2026-08-14', '14:30:00', 'Efectivo USD'),
(3, 303, 12, '2026-08-14', '19:00:00', 'Punto/BS'),
(4, 604, 25, '2026-08-14', '20:15:00', 'Zelle'),
(5, 201, 15, '2026-08-15', '12:45:00', 'Efectivo USD'),
(6, 508, 14, '2026-08-15', '14:00:00', 'Zelle'),
(7, 510, 5,  '2026-08-15', '20:30:00', 'Efectivo USD'),
(8, 806, 35, '2026-08-15', '21:00:00', 'Punto/BS'),
(9, 701, 22, '2026-08-16', '09:30:00', 'Efectivo USD'),
(10, 102, 30, '2026-08-16', '13:00:00', 'Zelle');


SELECT 
    p.nombre_producto,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio_venta) AS ingreso_total,
    SUM(v.cantidad * p.costo_estimado) AS costo_total,
    SUM(v.cantidad * (p.precio_venta - p.costo_estimado)) AS ganancia_bruta
FROM productos p
LEFT JOIN ventas_detalle v ON p.id_producto = v.id_producto
GROUP BY p.id_producto, p.nombre_producto
ORDER BY ganancia_bruta DESC;


SELECT 
    p.nombre_producto,
    COALESCE(SUM(v.cantidad), 0) AS unidades_vendidas,
    COALESCE(SUM(v.cantidad * p.precio_venta), 0) AS ingreso_total,
    COALESCE(SUM(v.cantidad * p.costo_estimado), 0) AS costo_total,
    COALESCE(SUM(v.cantidad * (p.precio_venta - p.costo_estimado)), 0) AS ganancia_bruta
FROM productos p
LEFT JOIN ventas_detalle v ON p.id_producto = v.id_producto
GROUP BY p.id_producto, p.nombre_producto
ORDER BY ganancia_bruta DESC;


SELECT 
    p.nombre_producto,
    COALESCE(SUM(v.cantidad), 0) AS unidades_vendidas,
    COALESCE(SUM(v.cantidad * p.precio_venta), 0) AS ingreso_total,
    COALESCE(SUM(v.cantidad * p.costo_estimado), 0) AS costo_total,
    COALESCE(SUM(v.cantidad * (p.precio_venta - p.costo_estimado)), 0) AS ganancia_bruta,
    ROUND(
        CASE 
            WHEN SUM(v.cantidad * p.precio_venta) > 0 
            THEN (SUM(v.cantidad * (p.precio_venta - p.costo_estimado)) / SUM(v.cantidad * p.precio_venta)) * 100.0
            ELSE 0 
        END, 2
    ) AS margen_porcentaje
FROM productos p
LEFT JOIN ventas_detalle v ON p.id_producto = v.id_producto
GROUP BY p.id_producto, p.nombre_producto
ORDER BY ganancia_bruta DESC;

SELECT 
    p.nombre_producto,
    COALESCE(SUM(v.cantidad), 0) AS unidades_vendidas,
    COALESCE(SUM(v.cantidad * p.precio_venta), 0) AS ingreso_total,
    COALESCE(SUM(v.cantidad * p.costo_estimado), 0) AS costo_total,
    COALESCE(SUM(v.cantidad * (p.precio_venta - p.costo_estimado)), 0) AS ganancia_bruta,
    ROUND(
        CASE 
            WHEN SUM(v.cantidad * p.precio_venta) > 0 
            THEN (SUM(v.cantidad * (p.precio_venta - p.costo_estimado)) * 100.0) / SUM(v.cantidad * p.precio_venta)
            ELSE 0 
        END, 2
    ) AS margen_porcentaje
FROM productos p
LEFT JOIN ventas_detalle v ON p.id_producto = v.id_producto
GROUP BY p.id_producto, p.nombre_producto
ORDER BY ganancia_bruta DESC;
