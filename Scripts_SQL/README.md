# Scripts SQL para Agregar Campo Fecha de Nacimiento

Este documento contiene todos los scripts SQL necesarios para actualizar tu base de datos y soportar el nuevo campo de **Fecha de Nacimiento**.

## ?? Orden de Ejecución

### **OPCIÓN 1: Ejecutar Todo de Una Vez (RECOMENDADO)**
Abre el archivo `00_SCRIPT_COMPLETO.sql` en SQL Server Management Studio y ejecuta todo el contenido de una sola vez.

**?? IMPORTANTE:** Antes de ejecutar, reemplaza `tu_base_datos_aqui` con el nombre real de tu base de datos.

---

### **OPCIÓN 2: Ejecutar Scripts Individuales en Orden**
Si prefieres ejecutar paso a paso:

1. **01_Agregar_Columna_FechaNacimiento.sql** - Agrega la columna a la tabla
2. **02_SP_persona_insertar.sql** - Actualiza SP de insertar
3. **03_SP_persona_actualizar.sql** - Actualiza SP de actualizar
4. **04_SP_persona_listar.sql** - Actualiza SP de listado general
5. **05_SP_persona_listar_clientes.sql** - Actualiza SP de listado de clientes
6. **06_SP_persona_listar_proveedores.sql** - Actualiza SP de listado de proveedores
7. **07_SP_persona_buscar.sql** - Actualiza SP de búsqueda general
8. **08_SP_persona_buscar_clientes.sql** - Actualiza SP de búsqueda de clientes
9. **09_SP_persona_buscar_proveedores.sql** - Actualiza SP de búsqueda de proveedores

---

## ?? Pasos a Seguir

### **Paso 1: Abrir SQL Server Management Studio**
1. Abre SQL Server Management Studio
2. Conectate a tu servidor SQL Server
3. Selecciona tu base de datos

### **Paso 2: Ejecutar el Script**
**Opción recomendada (TODO DE UNA VEZ):**
- Abre el archivo `00_SCRIPT_COMPLETO.sql`
- Reemplaza `tu_base_datos_aqui` con el nombre de tu base de datos
- Selecciona todo (Ctrl+A)
- Ejecuta (F5)

**O ejecuta Scripts Individuales:**
- Abre cada archivo en orden
- Reemplaza `tu_base_datos_aqui` con el nombre de tu base de datos
- Ejecuta cada uno (F5)

### **Paso 3: Verificar la Ejecución**
Deberías ver mensajes como:
```
Columna Fecha_Nacimiento agregada exitosamente a la tabla Persona
Stored procedure persona_insertar actualizado exitosamente
Stored procedure persona_actualizar actualizado exitosamente
...
Todos los scripts se ejecutaron correctamente
```

---

## ? Verificar que Todo Funcionó

Después de ejecutar los scripts, puedes verificar que todo está correcto con estas consultas:

### **Verificar que la columna existe:**
```sql
USE [tu_base_datos_aqui]
GO

SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Persona' AND COLUMN_NAME = 'Fecha_Nacimiento'
GO
```

### **Verificar los Stored Procedures:**
```sql
USE [tu_base_datos_aqui]
GO

SELECT SPECIFIC_NAME 
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_NAME LIKE 'persona_%' 
ORDER BY SPECIFIC_NAME
GO
```

---

## ?? Detalles Técnicos

### **Cambios en la Tabla Persona:**
- Se agrega columna `Fecha_Nacimiento` de tipo `DATETIME`
- Valor por defecto: `GETDATE()` (fecha/hora actual)
- Permite valores NULL

### **Cambios en Stored Procedures:**
Todos los SP que manipulan datos de Persona ahora incluyen el parámetro `@fecha_nacimiento DATETIME`:

- ? `persona_insertar` - Inserta nuevo registro con fecha
- ? `persona_actualizar` - Actualiza registro con fecha
- ? `persona_listar` - Retorna lista con fecha
- ? `persona_listar_clientes` - Retorna clientes con fecha
- ? `persona_listar_proveedores` - Retorna proveedores con fecha
- ? `persona_buscar` - Busca y retorna con fecha
- ? `persona_buscar_clientes` - Busca clientes con fecha
- ? `persona_buscar_proveedores` - Busca proveedores con fecha

---

## ?? Próximos Pasos

Después de ejecutar los scripts SQL:

1. ? Scripts SQL ejecutados
2. ? Código C# ya está actualizado (se hizo en el paso anterior)
3. ? Compilación correcta
4. **? Ejecuta la aplicación y prueba la funcionalidad**

---

## ?? Notas Importantes

- **Respaldo:** Se recomienda hacer un backup de la base de datos antes de ejecutar los scripts
- **Nombre de Base de Datos:** Asegúrate de reemplazar `tu_base_datos_aqui` con el nombre correcto
- **Permisos:** Necesitas permisos de administrador para ejecutar scripts DDL/DML
- **Compatibilidad:** Los scripts son compatibles con SQL Server 2012 en adelante

---

## ?? Solución de Problemas

### **Error: "Base de datos no encontrada"**
- Reemplaza `tu_base_datos_aqui` con el nombre exacto de tu base de datos
- Verifica que estés conectado al servidor correcto

### **Error: "Objeto ya existe"**
- Los scripts incluyen `DROP PROCEDURE IF EXISTS` para evitar esto
- Si persiste, ejecuta primero el script de dropear procedimientos

### **Error: "Tabla Persona no encontrada"**
- Verifica que la tabla Persona existe en tu base de datos
- Revisa el nombre exacto (puede ser diferente)

---

## ?? Soporte

Si encuentras problemas:
1. Verifica el nombre exacto de tu base de datos
2. Verifica que tienes permisos administrativos
3. Revisa los mensajes de error en la ventana "Messages"
4. Asegúrate de haber reemplazado `tu_base_datos_aqui` correctamente

