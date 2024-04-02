import { pool } from "../db.js";
import bcrypt from 'bcrypt';

export const getMedico = async (req, res) => {
    try {
        const { rows } = await pool.query('SELECT id, nombres, apellidos, especialidades, descripcion, username FROM medicos');
        res.send(rows);
    } catch (error) {
        console.error('Error en la consulta SQL:', error);
        res.status(500).send('Error en el servidor');
    }
};


export const createMedico = async (req, res) => {
    const { nombres, apellidos, especialidades, descripcion, username, password } = req.body;

    try {
        const hashedPassword = await bcrypt.hash(password, 10); // Cambié el factor de hashing de 6 a 10 para mayor seguridad

        const { rows } = await pool.query('INSERT INTO medicos (nombres, apellidos, especialidades, descripcion, username, password) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id, nombres, apellidos, especialidades, descripcion, username', [nombres, apellidos, JSON.stringify(especialidades), descripcion, username, hashedPassword]);
        
        const medicoToken = rows[0];
        
        res.status(201).send({ message: 'Médico creado correctamente', medico: medicoToken });
    } catch (error) {
        console.error('Error al insertar en la base de datos:', error);
        res.status(500).send('Error en el servidor');
    }
};
