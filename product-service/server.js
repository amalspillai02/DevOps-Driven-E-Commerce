const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const productRoutes = require('./routes/productRoutes');

dotenv.config();
const app = express();

app.use(express.json());
app.use('/api/product', productRoutes);
app.get('/', (req, res) => {
  res.send('Product Service is up and running 🚀');
});

app.use(express.json());
app.use('/api/products', productRoutes);

mongoose.connect(process.env.MONGO_URI)
  .then(() => {
    console.log('MongoDB connected (Product)');
    app.listen(5001, () => console.log('Product service running on port 5001'));
  })
  .catch(err => console.error(err));
