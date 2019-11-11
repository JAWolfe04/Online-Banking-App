using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;

using MySql.Data;
using MySql.Data.MySqlClient;
using Microsoft.AspNetCore.Http;

namespace asp_core_mvc.Controllers
{
    public class AlertsController : Controller
    {
        public IActionResult Index()
        {
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            DatabaseHandler databaseHandler = new DatabaseHandler();
            return View(databaseHandler.getAlerts(customerID, 12341001));
        }


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
