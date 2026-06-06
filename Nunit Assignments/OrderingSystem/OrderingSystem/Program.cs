namespace OrderingSystem
{
    public class Program
    {
        public static void Main(string[] args)
        {

            OrderingModel model = new OrderingModel(15.5m, 25, 10);
            OrderLogic logic = new OrderLogic();

            decimal discount = logic.CalculateDiscount(model);
            decimal deliveryCharge = logic.CalculatedeliveryCharge(model.deliverykilometers);
            decimal total = logic.CalculateTotal(model, discount, deliveryCharge);
            Console.WriteLine("Discount: " + discount );
            Console.WriteLine("Delivery Charge: " + deliveryCharge );
            Console.WriteLine("Total: " + total );  
        }
    }
}