using System;
using System.Collections.Generic;
using System.Text;

namespace OrderingSystem
{
    public class OrderLogic
    {
       

        public decimal CalculateDiscount(OrderingModel order)
        {
            if (order.quantity >= 20)
            {
                return order.price * order.quantity * 0.2m; 
            }
            return 0;
        }

        public decimal CalculatedeliveryCharge(double deliveryKilometers)
        {
            if (deliveryKilometers > 7)
            {
                return 10;
            }
            return 0;
        }
        public decimal CalculateTotal(OrderingModel order,decimal discount,decimal deliveryCharge)
        {
            
            if (order.price <= 0)
            {
                throw new ArgumentException("Price must be greater than zero.");
            }
            if (order.quantity < 0)
            {
                throw new ArgumentException("Quantity must be a non-negative integer.");
            }
            return (order.price * order.quantity)-discount+deliveryCharge;
        }

       


    }
}
