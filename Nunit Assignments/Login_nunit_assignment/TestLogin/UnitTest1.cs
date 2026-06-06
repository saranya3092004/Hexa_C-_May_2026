using System;
using NUnit.Framework;
using LoginTests;

namespace TestLogin
{
    [TestFixture]
    public class Tests
    {
        private LoginService _loginService;
        private UserModel _user;

        [SetUp]
        public void Setup()
        {
            _loginService = new LoginService();
            _user = new UserModel("admin", "admin123");
        }

        [Test]
        public void Login_ValidCredentials_ReturnsTrue()
        {
            bool result = _loginService.Login(_user, "admin", "admin123");
            Assert.That(result, Is.True );
        }

        [Test]
        public void Login_InvalidCredentials_ReturnsFalse()
        {
            bool result = _loginService.Login(_user, "invalid", "invalid");
            Assert.That(result, Is.False);
        }

        [Test]
        public void Login_EmptyUsername_ThrowsArgumentException()
        {
            _user.UserName = "";
            Assert.Throws<ArgumentException>(() => _loginService.Login(_user, "", "password123"));
        }

        [Test]
        public void Login_EmptyPassword_ThrowsArgumentException()
        {
            _user.Password = "";
            Assert.Throws<ArgumentException>(() => _loginService.Login(_user, "admin", ""));
        }

        [Test]
        public void Login_NullUsername_ThrowsArgumentException()
        {
            _user.UserName = null;
            Assert.Throws<ArgumentException>(() => _loginService.Login(_user, null, "password123"));
        }
    }
}