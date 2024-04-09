import { Router } from "express";
import { getCita, createCita } from "../controllers/cita.controller.js";
const router = Router()

router.get('/cita',getCita);
router.post('/cita/create', createCita);


export default router;