import express from 'express';
import cors from 'cors';
import loginroutes from "./routes/login.routes.js";
import registerroutes from "./routes/register.routes.js";

const app = express();

app.use(express.json());

// Configuración de CORS
app.use(cors());

app.use(loginroutes);
app.use(registerroutes);

app.listen(3000);
console.log("Server running on port 3000");
