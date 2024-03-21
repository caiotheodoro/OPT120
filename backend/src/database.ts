import { Pool } from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const pool = new Pool({
    user: process.env.DB_USER,
    host: `localhost`,
    port: 5432,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASSWORD,
});


const initalize =  async () => {
    // await pool.connect()
    // await pool.query(`CREATE TABLE "user" (
    //     id SERIAL PRIMARY KEY,
    //     name VARCHAR(200) NOT NULL,
    //     email VARCHAR(500) NOT NULL,
    //     password VARCHAR(255)   NOT NULL
    //     )`)
    // await pool.query(`CREATE TABLE "user_activity" (
    //     id SERIAL PRIMARY KEY,
    // user_id INT      NOT NULL,
    // deliver    DATE NOT NULL,
    // grade    DECIMAL(5,2) NOT NULL
    //     )`)
    // await pool.end()


   

// pool.query(`CREATE TABLE ACTIVITY (
//     id SERIAL PRIMARY KEY,
//     title VARCHAR(200) NOT NULL,
//     description VARCHAR(500) NOT NULL,
//     date timestamp NOT NULL
//     )`)
//     .then(res => console.log(res))
//     .catch(err => console.error(err))



}




export  {pool, initalize};