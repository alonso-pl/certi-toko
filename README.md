# Certi-Toko
---
## Descripción del Proyecto  
Certi-Toko es un sistema de gestión de cursos desarrollado en **Motoko**, diseñado para administrar estudiantes, maestros y certificaciones de manera eficiente. El backend del proyecto se basa en un único **canister**, que centraliza todas las funciones relacionadas con la gestión de entidades, incluyendo:  

- **Estudiantes**  
- **Maestros/Profesores**  
- **Relación Alumno-Curso**  
- **Certificados**  

La estructura de datos de cada entidad está definida en el archivo `types.mo`, mientras que la lógica principal del sistema se encuentra en `main.mo`.

---
## Estado Actual del Proyecto  
🚀 **Fase Pre-Alpha**  
Actualmente, el desarrollo se encuentra en una etapa inicial y solo cuenta con el backend funcional. A futuro, se planea la implementación de una interfaz gráfica y mejoras en la arquitectura.

---
## Instrucciones para Ejecutar el Proyecto  

### Requisitos Previos  
Antes de ejecutar el proyecto, asegúrate de tener instalado **DFX** (DFINITY SDK). Si aún no lo tienes, puedes instalarlo siguiendo la documentación oficial:  
🔗 [Instalar DFX](https://internetcomputer.org/docs/building-apps/getting-started/install)  

### Pasos para Ejecutar Certi-Toko  

1. **Iniciar el servidor local de DFX**  
  Para ello ejecuta el comando `dfx start` preferentemente con las banderas `--clean` y  `--background` de la siguiente manera:

   ```sh
   dfx start --clean --background
   ````
  - `--clean`: Elimina datos previos para una ejecución limpia.

  - `--background`: Permite que el proceso se ejecute en segundo plano sin bloquear la terminal.

2. **Compilar y desplegar el canister**
  El siguiente comando compila el proyecto y lo despliega en el entorno local:

    ```sh
    dfx deploy

3. Acceder al sistema

  Tras la ejecución de dfx deploy, se mostrará un enlace en la terminal.

  Usa este enlace para interactuar con el backend de Certi-Toko.

---
**_Nota_ para "Pruebas Rápidas"**
Para facilitar las pruebas iniciales, se ha incluido una función en  `main.mo` llamada **test_values**, la cual genera automáticamente datos de ejemplo, incluyendo:
- Estudiantes
- Maestros
- Cursos
- Relaciones Alumno-Curso
- Certificados

Esta función permite probar rápidamente las funcionalidades del sistema sin necesidad de ingresar datos manualmente.

---
**EXTRAS**
[Video demo](https://youtu.be/0qu2MTkoVIs)