import { pool } from "../db.js";
import bcrypt from 'bcrypt';

export const getMedico = async (req, res) => {
    try {
        // Ejecuta la consulta SQL para seleccionar todos los campos excepto la contraseña de los médicos
        const [rows] = await pool.query('SELECT id, nombres, apellidos, especialidades, descripcion, username FROM medicos');

        // Envía la respuesta con los médicos encontrados
        res.send(rows);
    } catch (error) {
        // Manejo de errores
        console.error('Error en la consulta SQL:', error);
        res.status(500).send('Error en el servidor');
    }
};


export const createMedico = async (req, res) => {
    const { nombres, apellidos, especialidades, descripcion, username, password } = req.body;

    try {
        // Genera un hash de la contraseña utilizando bcrypt
        const hashedPassword = await bcrypt.hash(password, 6);

        // Ejecuta una consulta SQL para insertar los datos del médico en la tabla 'medicos'
        const [rows] = await pool.query('INSERT INTO medicos (nombres, apellidos, especialidades, descripcion, username, password) VALUES (?, ?, ?, ?, ?, ?)', [nombres, apellidos, JSON.stringify(especialidades), descripcion, username, hashedPassword]);
        
        const medicoToken = {
            id: rows.insertId,
            nombres: nombres,
            apellidos: apellidos,
            especialidades: especialidades,
            descripcion: descripcion,
            username: username
        };
        
        res.status(201).send({ message: 'Médico creado correctamente', medico: medicoToken });
    } catch (error) {
        // Manejo de errores
        console.error('Error al insertar en la base de datos:', error);
        res.status(500).send('Error en el servidor');
    }
};