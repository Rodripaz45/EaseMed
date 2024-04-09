import { Router } from "express";
import validarTokenController from "../controllers/auth.controller.js";

const router = Router();

// Ruta para validar el token JWT
router.get('/validar-token', validarTokenController);

export default router;
