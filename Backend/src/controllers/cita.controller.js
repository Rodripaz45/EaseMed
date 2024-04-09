import { pool } from "../db.js";

export const createCita = async (req, res) => {
    const { id_medico, id_paciente, fecha, hora } = req.body;

    try {
        const { rows } = await pool.query(
            'INSERT INTO cita (id_medico, id_paciente, fecha, hora) VALUES ($1, $2, $3, $4) RETURNING id_cita, id_medico, id_paciente, fecha, hora',
            [id_medico, id_paciente, fecha, hora]
        );

        const citaCreated = rows[0];

        res.status(201).send({ message: 'Cita creada correctamente', cita: citaCreated });
    } catch (error) {
        console.error('Error al insertar en la base de datos:', error);
        res.status(500).send('Error en el servidor');
    }
};
export const getCita = async (req, res) => {
    try {
        const { rows } = await pool.query(`
            SELECT c.id_cita, c.id_medico, m.nombres AS nombre_medico, p.nombre AS nombre_paciente, c.fecha, c.hora
            FROM cita c
            INNER JOIN medicos m ON c.id_medico = m.id
            INNER JOIN pacientes p ON c.id_paciente = p.id
        `);
        res.send(rows);
    } catch (error) {
        console.error('Error en la consulta SQL:', error);
        res.status(500).send('Error en el servidor');
    }
};