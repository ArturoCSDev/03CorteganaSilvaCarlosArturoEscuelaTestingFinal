function fn() {
  var env = karate.env;
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    baseUrl: 'https://petstore.swagger.io/v2'
  }
  if (env == 'dev') {
    config.baseUrl = 'https://petstore.swagger.io/v2';
  } else if (env == 'qa') {
    config.baseUrl = 'https://petstore.swagger.io/v2';
  }
  return config;
}
