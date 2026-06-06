using LoginTests;

LoginService loginService = new LoginService();

UserModel userModel = new UserModel("testuser", "password123");

bool result = loginService.Login(userModel, "testuser", "password123");

 Console.WriteLine(result? "Login successful!" : "Login failed!");