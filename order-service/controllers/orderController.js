const Order = require('../models/Order');

exports.createOrder = async (req, res) => {
  const { productId, quantity, userId } = req.body;
  const order = await Order.create({ productId, quantity, userId });
  res.status(201).json(order);
};

exports.getOrders = async (req, res) => {
  const orders = await Order.findAll();
  res.json(orders);
};

exports.getOrderById = async (req, res) => {
  const order = await Order.findByPk(req.params.id);
  if (!order) return res.status(404).json({ message: 'Not found' });
  res.json(order);
};
