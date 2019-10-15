﻿using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;
using asp_core_mvc.ViewModels;

namespace asp_core_mvc.Controllers
{
    public class ReportsController : Controller
    {
        public IActionResult Index()
        {
            DatabaseHandler databaseHandler = new DatabaseHandler();
            ReportsModel reportsModel = new ReportsModel();
            reportsModel.Reports = databaseHandler.getReports();
            reportsModel.PrevReports = databaseHandler.getPrevReports();
            return View(reportsModel);
        }


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
