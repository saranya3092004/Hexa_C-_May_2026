using System;
using System.Collections.Generic;
using System.Text;

namespace LoginTests
{
    public class LoginService
    {
        public bool Login(UserModel user,string userName,string password)
        {
            if(string.IsNullOrWhiteSpace(user.UserName) || string.IsNullOrWhiteSpace(user.Password))
            {
                throw new ArgumentException("Username or password is required");
            }
            return user.UserName==userName && user.Password == password;
        }
    }
}
