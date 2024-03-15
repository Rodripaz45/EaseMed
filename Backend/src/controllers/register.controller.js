import { pool } from "../db.js";
import bcrypt from 'bcrypt';

export const register = async (req, res) => {
    const { email, password } = req.body;

    try {
        // Genera un hash de la contraseña utilizando bcrypt
        const hashedPassword = await bcrypt.hash(password, 6);

        // Ejecuta una consulta SQL para insertar el correo electrónico y la contraseña en la tabla de usuarios
        const [rows] = await pool.query('INSERT INTO user (email, password) VALUES (?, ?)', [email, hashedPassword]);

        // Envía una respuesta al cliente con el ID generado por la inserción y el correo electrónico (sin la contraseña)
        res.send({
            id: rows.insertId,
            email,
        });
    } catch (error) {
        // Manejo de errores
        console.error('Error al insertar en la base de datos:', error);
        res.status(500).send('Error en el servidor');
    }
};
