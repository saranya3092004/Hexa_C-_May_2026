
using NUnit.Framework;
using OrderingSystem;
namespace OrderingSystemTest
{
    public class OrderingTests
    {
        private OrderingModel _orderingModel;
        private OrderLogic _orderingLogic;

        [SetUp]
        public void Setup()
        {
            _orderingModel = new OrderingModel(15.5m, 25, 10);
            _orderingLogic = new OrderLogic();

        }

        [Test]
        public void CalculateDiscount_QuantityLessThan20_ReturnsZero()
        {

            _orderingModel.price = 100m;
            _orderingModel.quantity = 19;

            decimal discount = _orderingLogic.CalculateDiscount(_orderingModel);


            Assert.That(discount, Is.EqualTo(0m));
        }

        [Test]
        public void CalculateDiscount_QuantityExactly20_Returns20PercentDiscount()
        {
            _orderingModel.price = 100m;
            _orderingModel.quantity = 20;

            decimal discount = _orderingLogic.CalculateDiscount(_orderingModel);

            Assert.That(discount, Is.EqualTo(400m));
        }



        [Test]
        public void CalculatedeliveryCharge_KilometersLessThanOrEqualTo7_ReturnsZero()
        {

            Assert.That(_orderingLogic.CalculatedeliveryCharge(7.0), Is.EqualTo(0m));
            Assert.That(_orderingLogic.CalculatedeliveryCharge(5.5), Is.EqualTo(0m));
        }

        [Test]
        public void CalculatedeliveryCharge_KilometersGreaterThan7_Returns10()
        {

            decimal charge = _orderingLogic.CalculatedeliveryCharge(7.1);


            Assert.That(charge, Is.EqualTo(10m));
        }


        [Test]
        public void CalculateTotal_ValidInputs_ReturnsCorrectTotal()
        {

            _orderingModel.price = 50m;
            _orderingModel.quantity = 2;
            decimal discount = 20m;
            decimal delivery = 10m;

            decimal total = _orderingLogic.CalculateTotal(_orderingModel, discount, delivery);


            Assert.That(total, Is.EqualTo(90m));
        }

        [Test]
        public void CalculateTotal_PriceIsZeroOrNegative_ThrowsArgumentException()
        {

            _orderingModel.price = 0m;
            _orderingModel.quantity = 5;


            Assert.Throws<ArgumentException>(() =>
                _orderingLogic.CalculateTotal(_orderingModel, 0m, 0m)
            );
        }

        [Test]
        public void CalculateTotal_QuantityIsNegative_ThrowsArgumentException()
        {
            _orderingModel.price = 10m;
            _orderingModel.quantity = -1;


            Assert.Throws<ArgumentException>(() =>
                _orderingLogic.CalculateTotal(_orderingModel, 0m, 0m)
            );
        }

    }
}
