const pool = require("../utils/clientConnect");


class CoreDatamapper {
    static tableName;


//GET
    static async getAll(data) {
        
        if(!data ){
            const query = `SELECT * FROM ${this.constructor.tableName}`;
            const response = await pool.query(query);

            return response.rows;
            }

        const query = `SELECT * FROM ${this.constructor.tableName} WHERE "${Object.keys(data)[0]}" = $1`;
        const response = await pool.query(query, [Object.values(data)]);

        return response.rows;
    }


    static async getOne(id) {

        const query = `SELECT * FROM ${this.constructor.tableName} WHERE id = $1`;
        const response = await pool.query(query, [id]);

        if(response.rowCount === 0){
            throw new NotFoundError(NotFoundError.message);

        }

        return response.rows[0];
    }


//POST



    static async create(data) {

        const keys = [];
        const params = [];

        Object.keys(data).forEach((key, index) => {
            keys.push(`${key}`);
            params.push(`$${index + 1}`);

        });


        const query =  `
            INSERT INTO ${this.constructor.tableName} (${keys.join(", ")})
            VALUES (${params.join(", ")})
            RETURNING *`;
        const response = await pool.query(query, [Object.values(data)]);

        return response.rows[0];


    }


//PUT

    static async update(id, data) {
//id check
        const checkQuery = `SELECT * FROM ${this.constructor.tableName} WHERE id = $1`;
        const idcheck = await pool.query(query, [id]);


        if(idcheck.rowCount === 0){
            throw new NotFoundError(NotFoundError.message);
        }

        const newValues = [];

        Object.keys(data).forEach((key, index) => {
            newValues.push(`${key} = $${index + 1}`)
        });

        const query = `UPDATE ${this.constructor.tableName} SET ${newValues.join(", ")} WHERE id = $${newValues.length + 1} RETURNING *`;
        const response = await pool.query(query, [...Object.values(data), id]);


    }


//DELETE

    static async delete(id) {

        //id check
        const checkQuery = `SELECT * FROM ${this.constructor.tableName} WHERE id = $1`;
        const idcheck = await pool.query(query, [id]);
        
        if(idcheck.rowCount === 0){
            throw new NotFoundError(NotFoundError.message);
        }
        
        const query = `DELETE FROM ${this.constructor.tableName} WHERE id = $1 `;
        const response =  await pool.query(query, [id]); 
        
    }





}

module.exports = CoreDatamapper;









