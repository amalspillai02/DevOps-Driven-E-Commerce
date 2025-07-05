const express = require('express');
const dotenv = require('dotenv');
const connectDB = require('./config/db');
const orderRoutes = require('./routes/orderRoutes');

dotenv.config();
const app = express();

app.use(express.json());

app.get('/', (req, res) => {
  res.send('Order Service is up and running 🚀');
});

app.use('/api/orders', orderRoutes);

connectDB();

app.listen(5002, () => console.log('Order service running on port 5002'));
