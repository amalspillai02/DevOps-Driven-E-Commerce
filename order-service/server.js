const express = require('express');
const dotenv = require('dotenv');
const { sequelize } = require('./config/db');
const orderRoutes = require('./routes/orderRoutes');

dotenv.config();
const app = express();

app.use(express.json());
app.use('/api/order', orderRoutes);
app.get('/', (req, res) => {
  res.send('Order Service is up and running 🚀');
});

app.use(express.json());
app.use('/api/orders', orderRoutes);

sequelize.sync().then(() => {
  console.log('PostgreSQL connected & Order table created');
  app.listen(5002, () => console.log('Order service running on port 5002'));
});
