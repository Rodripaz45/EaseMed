import { pool } from "../db.js";
import bcrypt from 'bcrypt';

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
