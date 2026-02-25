# Escuela Testing Final - Automatizacion API Petstore

Proyecto de automatizacion de pruebas para la API REST de Petstore usando Karate Framework con JUnit5.

## Que se automatiza

Se cubren los modulos **User** y **Store** de la API Petstore (https://petstore.swagger.io/v2), con un total de 20 escenarios que incluyen casos happy path y unhappy path.

### Endpoints cubiertos

**User (12 escenarios)**
- POST /user - Crear usuario
- POST /user/createWithList - Crear usuarios con lista
- POST /user/createWithArray - Crear usuarios con array
- GET /user/{username} - Obtener usuario
- PUT /user/{username} - Actualizar usuario
- DELETE /user/{username} - Eliminar usuario
- GET /user/login - Login
- GET /user/logout - Logout

**Store (8 escenarios)**
- POST /store/order - Crear orden
- GET /store/order/{orderId} - Obtener orden por ID
- DELETE /store/order/{orderId} - Eliminar orden
- GET /store/inventory - Obtener inventario

## Tecnologias

- Java 17
- Karate 1.5.0
- JUnit 5
- Maven

## Estructura del proyecto

```
src/test/java/
  karate-config.js          -> Configuracion global (baseUrl, entorno)
  examples/
    ExamplesTest.java        -> Runner principal (ejecucion en paralelo)
    users/
      users.feature          -> Escenarios de prueba del modulo User
      UsersRunner.java       -> Runner individual para User
    stores/
      store.feature          -> Escenarios de prueba del modulo Store
      StoreRunner.java       -> Runner individual para Store
```

## Como ejecutar

### Todos los tests
```bash
mvn test
```

### Solo un modulo
```bash
mvn test -Dtest=UsersRunner
mvn test -Dtest=StoreRunner
```

### Por tags
```bash
mvn test -Dkarate.options="--tags @happypath"
mvn test -Dkarate.options="--tags @unhappypath"
mvn test -Dkarate.options="--tags @users"
mvn test -Dkarate.options="--tags @store"
```

## Reportes

Despues de la ejecucion, los reportes HTML se generan en:
```
target/karate-reports/karate-summary.html
```
