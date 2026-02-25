@users
Feature: Petstore - User API Tests
  Como QA quiero verificar que los endpoints de User funcionen correctamente

  Background:
    * url baseUrl

  @happypath
  Scenario: Crear un usuario exitosamente
    * def id = 100
    * def username = 'arturodev'
    * def firstName = 'Arturo'
    * def lastName = 'Dev'
    * def email = 'arturo@testing.com'
    * def password = 'password123'
    * def phone = '123456789'
    * def userStatus = 1
    Given path '/user'
    And request read('data/user.json')
    When method post
    Then status 200
    And match response.message != null

  @happypath
  Scenario: Crear multiples usuarios con una lista
    Given path '/user/createWithList'
    And request
      """
      [
        {
          "id": 101,
          "username": "usuario1",
          "firstName": "Juan",
          "lastName": "Perez",
          "email": "juan@test.com",
          "password": "pass123",
          "phone": "111111111",
          "userStatus": 1
        },
        {
          "id": 102,
          "username": "usuario2",
          "firstName": "Maria",
          "lastName": "Lopez",
          "email": "maria@test.com",
          "password": "pass456",
          "phone": "222222222",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 200

  @happypath
  Scenario: Crear multiples usuarios con un array
    Given path '/user/createWithArray'
    And request
      """
      [
        {
          "id": 110,
          "username": "arrayuser1",
          "firstName": "Carlos",
          "lastName": "Gomez",
          "email": "carlos@test.com",
          "password": "pass789",
          "phone": "888888888",
          "userStatus": 1
        },
        {
          "id": 111,
          "username": "arrayuser2",
          "firstName": "Ana",
          "lastName": "Torres",
          "email": "ana@test.com",
          "password": "pass321",
          "phone": "999999999",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 200

  @happypath
  Scenario: Obtener un usuario por username
    * def id = 103
    * def username = 'testuser_get'
    * def firstName = 'Test'
    * def lastName = 'User'
    * def email = 'testget@test.com'
    * def password = 'pass789'
    * def phone = '333333333'
    * def userStatus = 1
    Given path '/user'
    And request read('data/user.json')
    When method post
    Then status 200

    Given path '/user/testuser_get'
    When method get
    Then status 200
    And match response.username == 'testuser_get'
    And match response.firstName == 'Test'
    And match response.lastName == 'User'
    And match response.email == 'testget@test.com'

  @unhappypath
  Scenario: Obtener un usuario que no existe
    Given path '/user/usuario_inexistente_xyz'
    When method get
    Then status 404

  @happypath
  Scenario: Actualizar un usuario exitosamente
    * def id = 104
    * def username = 'testuser_update'
    * def firstName = 'Antes'
    * def lastName = 'Update'
    * def email = 'antes@test.com'
    * def password = 'pass000'
    * def phone = '444444444'
    * def userStatus = 1
    Given path '/user'
    And request read('data/user.json')
    When method post
    Then status 200

    * def firstName = 'Despues'
    * def lastName = 'Actualizado'
    * def email = 'despues@test.com'
    * def password = 'newpass123'
    * def phone = '555555555'
    Given path '/user/testuser_update'
    And request read('data/user.json')
    When method put
    Then status 200

    Given path '/user/testuser_update'
    When method get
    Then status 200
    And match response.firstName == 'Despues'
    And match response.lastName == 'Actualizado'
    And match response.email == 'despues@test.com'

  @happypath
  Scenario: Eliminar un usuario exitosamente
    * def id = 105
    * def username = 'testuser_delete'
    * def firstName = 'Delete'
    * def lastName = 'Me'
    * def email = 'delete@test.com'
    * def password = 'pass111'
    * def phone = '666666666'
    * def userStatus = 1
    Given path '/user'
    And request read('data/user.json')
    When method post
    Then status 200

    Given path '/user/testuser_delete'
    When method delete
    Then status 200

  @unhappypath
  Scenario: Eliminar un usuario que no existe
    Given path '/user/usuario_fantasma_999'
    When method delete
    Then status 404

  @happypath
  Scenario: Login de usuario exitoso
    * def id = 106
    * def username = 'loginuser'
    * def firstName = 'Login'
    * def lastName = 'Test'
    * def email = 'login@test.com'
    * def password = 'loginpass'
    * def phone = '777777777'
    * def userStatus = 1
    Given path '/user'
    And request read('data/user.json')
    When method post
    Then status 200

    Given path '/user/login'
    And param username = 'loginuser'
    And param password = 'loginpass'
    When method get
    Then status 200
    And match response.message contains 'logged in user session'

  @unhappypath
  Scenario: Login sin enviar credenciales
    Given path '/user/login'
    When method get
    Then status 200
    And match response.message contains 'logged in user session'

  @happypath
  Scenario: Logout de usuario exitoso
    Given path '/user/logout'
    When method get
    Then status 200

  @happypath
  Scenario: Verificar que un usuario eliminado ya no existe
    * def id = 120
    * def username = 'user_eliminar_verificar'
    * def firstName = 'Temporal'
    * def lastName = 'User'
    * def email = 'temporal@test.com'
    * def password = 'temppass'
    * def phone = '101010101'
    * def userStatus = 1
    Given path '/user'
    And request read('data/user.json')
    When method post
    Then status 200

    Given path '/user/user_eliminar_verificar'
    When method delete
    Then status 200

    Given path '/user/user_eliminar_verificar'
    When method get
    Then status 404
