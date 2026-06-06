using System;
using System.Collections.Generic;
using System.Text;

namespace OrderingSystem
{
    public class OrderingModel
    {
        public decimal price { get; set; }
        public int quantity { get; set; } = 0;
        public double deliverykilometers { get; set; } 


        public OrderingModel(decimal price, int quantity, double deliverykilometers)
        {
            this.price = price;
            this.quantity = quantity;
            this.deliverykilometers = deliverykilometers;
        }
    }
}
