import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';

dotenv.config();

// Obtener la firma del token JWT de las variables de entorno
const JWT_SECRET = process.env.JWT_SECRET;


export const generateToken = (usuarioToken) => {
    try {
        // Generar el token JWT
        const token = jwt.sign(usuarioToken, JWT_SECRET, { expiresIn: '2h' });
        return token;
    } catch (error) {
        // Manejo de errores
        console.error('Error al generar el token:', error);
        return null;
    }
};

export const validateToken = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1]; // Extraer el token del encabezado Authorization
        const decoded = jwt.verify(token, JWT_SECRET);
        req.usuario = decoded; // Guardar la información decodificada en el objeto de solicitud
    } catch (error) {
        console.error('Error al validar el token:', error);
        return res.status(401).send('Token no válido');
    }
};