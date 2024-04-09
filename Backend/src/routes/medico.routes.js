import { Router } from "express";
import { getMedico, createMedico } from "../controllers/medico.controller.js";
const router = Router()

router.get('/medico',getMedico);
router.post('/medico/create', createMedico);


export default router;