import { Router } from "express";
import { register, login } from "../controllers/paciente.controller.js"
import { validateToken } from "../jwt.js";
const router = Router()

router.post('/paciente/register',register)
router.post('/paciente/login',login)

router.get('/paciente', validateToken, (res) => {
    // Si se llega a este punto, el token ha sido validado correctamente
    res.send('Token válido. Acceso autorizado.');
});

export default router