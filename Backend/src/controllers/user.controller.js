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


export const login = async (req, res) => {
    const { email, password } = req.body;
    try {
        // Realiza la consulta SQL para seleccionar el usuario por su email
        const [rows] = await pool.query('SELECT * FROM user WHERE email = ?', [email]);

        // Verifica si se encontró algún usuario con el email proporcionado
        if (rows.length > 0) {
            // Verifica si la contraseña proporcionada coincide con la contraseña almacenada (hasheada)
            const user = rows[0];
            const passwordMatch = await bcrypt.compare(password, user.password);

            if (passwordMatch) {
                // Si las contraseñas coinciden, devuelve los detalles del usuario (sin la contraseña)
                delete user.password;
                res.send(user);
            } else {
                // Si las contraseñas no coinciden, devuelve un mensaje de error
                res.status(404).send('Credenciales incorrectas');
            }
        } else {
            // No se encontró ningún usuario con ese email
            res.status(404).send('Credenciales incorrectas');
        }
    } catch (error) {
        // Manejo de errores
        console.error('Error en la consulta SQL:', error);
        res.status(500).send('Error en el servidor');
    }
};
