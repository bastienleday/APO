// require dotenv
require("dotenv").config();

// connection to client
const { Pool } = require ("pg");
const pool = new Pool();
pool.connect

module.exports = pool;



