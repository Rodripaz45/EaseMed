import { Router } from "express";
import { register, login } from "../controllers/paciente.controller.js"
import { validateToken } from "../jwt.js";
const router = Router()

router.post('/paciente/register',register);
router.post('/paciente/login',login);

//router.get('/paciente', validateToken, (res) => {
    //res.send('Token válido. Acceso autorizado.');
//});

export default router