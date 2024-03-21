import express from 'express';
import cors from 'cors';
import userroutes from "./routes/user.routes.js"
import pacienteroutes from "./routes/paciente.routes.js";

const app = express();

app.use(express.json());

// Configuración de CORS
app.use(cors());

app.use(userroutes);
app.use(pacienteroutes);

app.listen(3000);
console.log("Server running on port 3000");
