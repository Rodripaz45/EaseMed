import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
import { validateToken } from '../jwt.js';

// Carga las variables de entorno desde el archivo .env
dotenv.config();

// Clave secreta para firmar y verificar el token (obtenida del archivo .env)
const claveSecreta = process.env.JWT_SECRET;

// Controlador para validar el token JWT
const validarTokenController = (req, res) => {
  const token = req.headers.authorization; // Obtén el token de los headers

  try {
    if (!token) {
      throw new Error('Token no proporcionado');
    }

    // Llama a la función validateToken pasándole el token y la clave secreta
    validateToken(token);

    // Si el token es válido, envía una respuesta exitosa
    res.status(200).json({ mensaje: 'Token válido' });
  } catch (error) {
    console.error('Error al validar el token:', error);
    res.status(401).json({ error: 'Acceso no autorizado' });
  }
};

export default validarTokenController;
