using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;
using asp_core_mvc.ViewModels;
using Microsoft.AspNetCore.Http;

namespace asp_core_mvc.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            DatabaseHandler DBHandle = new DatabaseHandler();
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            HomeModel homeModel = new HomeModel();
            homeModel.Alerts = DBHandle.getAlerts(customerID, 12341001);
            homeModel.Transactions = DBHandle.getTransactions(12341001);

            return View(homeModel);
        }

        public IActionResult Transactions() { return View(); }
        public IActionResult Alerts() { return View(); }
        public IActionResult Rules() { return View(); }
        public IActionResult Reports() { return View(); }
        public IActionResult About() { return View(); }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
