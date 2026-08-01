# Iniciando mi ruta de aprendizaje en Data Analytics e IA
# Fase 1: SQL y power BI
# Práctica 01: Higiene y Limpieza de Datos (Data Cleaning)

## 📌 Objetivo del Proyecto
Procesar y sanear un dataset crudo de ventas en formato `.csv` con errores frecuentes de ingreso de datos, transformándolo en una estructura limpia y estandarizada (`.xlsx`) lista para análisis e ingesta en herramientas de BI.

---

## 🛠️ Problemas Identificados en la Fuente (`ventas_sucias.csv`)

Durante el diagnóstico inicial de la información cruda se detectaron las siguientes inconsistencias:

* **Espacios sobrantes:** Nombres de clientes con espacios al inicio y al final (ej. `  Pedro Perez `), lo que genera duplicidad de entidades en conteos de clientes únicos.
* **Inconsistencia de caja (Mayúsculas/Minúsculas):** Categorías de productos registradas de forma heterogénea (`Laptop` vs `LAPTOP`), afectando las agrupaciones por producto.
* **Discrepancia en formatos de fecha:** Mezcla de formatos ISO (`YYYY-MM-DD`) y regionales (`DD/MM/YYYY`).
* **Registros duplicados:** Transacciones idénticas repetidas en el archivo de origen que inflaban el volumen real de ventas.

---

## 🧼 Proceso de Transformación y Solución

Para corregir estos fallos y garantizar la integridad de los datos, se aplicaron las siguientes técnicas en Excel:

1. **Estandarización de texto:**
   * Aplicación de la función `=ESPACIOS()` para eliminar caracteres invisibles y espacios extras.
   * Uso de `=NOMPROPIO()` y `=MAYUSC()` para homogeneizar la nomenclatura de clientes y catálogo de productos.
2. **Normalización de tipos de datos:**
   * Conversión del campo `Fecha` a formato estándar de fecha corta (`DD/MM/AAAA`).
   * Fijación de valores mediante *Pegado Especial -> Valores* para eliminar dependencias de fórmulas.
3. **Control de duplicados e integridad:**
   * Ejecución del algoritmo de remoción de duplicados a nivel de fila completa, depurando registros repetidos y asegurando el total real de ingresos.

---

## 📁 Estructura del Repositorio

* `ventas_sucias.csv`: Archivo fuente original sin procesar.
* `ventas_limpias.xlsx`: Dataset resultante, auditado y listo para consumo analítico.
* `README.md`: Documentación técnica del proceso.