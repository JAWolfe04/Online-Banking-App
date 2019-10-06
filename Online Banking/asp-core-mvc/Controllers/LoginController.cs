using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;
using Microsoft.AspNetCore.Http;

namespace asp_core_mvc.Controllers
{
    public class LoginController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(LoginModel login)
        {
            DatabaseHandler databaseHandler = new DatabaseHandler();
            if (databaseHandler.validateUser(login))
            {
                HttpContext.Session.SetString("Name", login.FullName);
                HttpContext.Session.SetInt32("CustomerID", login.CustomerID);
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ModelState.AddModelError("", "Incorrect Username/Password");
                return View("Index");
            }
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index");
        }
    }
}