const express = require('express');
const app = express();

// Variables
const PORT = process.env.PORT || 8080;

// Endpoint principal
app.get('/hello', (req, res) => {
  res.json({
    message: 'Hola desde Cloud Run 🚀',
    timestamp: new Date().toISOString(),
    your_ip: req.ip
  });
});

// Endpoint raíz opcional
app.get('/', (req, res) => {
  res.send('Servicio activo en Cloud Run');
});

// Start server
app.listen(PORT, () => {
  console.log(`Servidor escuchando en puerto ${PORT}`);
});
