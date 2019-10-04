using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;

using MySql.Data;
using MySql.Data.MySqlClient;

namespace asp_core_mvc.Controllers
{
    public class AlertsController : Controller
    {
        public IActionResult Index()
        {
            DatabaseHandler databaseHandler = new DatabaseHandler();
            return View(databaseHandler.getAlerts());
        }


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
