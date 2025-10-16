
const dotenv = require('dotenv');
dotenv.config({ path: '.env' });
const { defineConfig } = require("cypress");

module.exports = defineConfig({
  video: true,
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
      // Injection des variables du .env dans config.env
      config.env = { ...config.env, ...process.env };
      return config;
    },
  },
});
