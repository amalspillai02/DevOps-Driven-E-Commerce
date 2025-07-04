const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const authRoutes = require('./routes/authRoutes');

dotenv.config();
const app = express();

app.use(express.json());
app.use('/api/auth', authRoutes);
app.get('/', (req, res) => {
  res.send('Auth Service is up and running 🚀');
});


mongoose.connect(process.env.MONGO_URI)
  .then(() => {
    console.log('MongoDB connected');
    app.listen(5000, () => console.log('Auth service running on port 5000'));
  })
  .catch(err => console.error(err));
