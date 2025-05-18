const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Cart = require('./Cart');

const Payment = sequelize.define('Payment', {
  cartId: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  amount: DataTypes.FLOAT,
  cardNumber: DataTypes.STRING,
});

module.exports = Payment;
