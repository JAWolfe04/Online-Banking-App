﻿using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;
using asp_core_mvc.ViewModels;
using System;
using OfficeOpenXml;
using System.Collections.Generic;
using Microsoft.AspNetCore.Http;

namespace asp_core_mvc.Controllers
{
    public class ReportsController : Controller
    {
        private ReportsModel generateReportsModel(int account = 0)
        {
            ReportsModel reportsModel = new ReportsModel();
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            List<Int32> accountIDs = DatabaseHandler.getAccounts(customerID);
            reportsModel.accounts = accountIDs;
            if (accountIDs.Count > 0)
            {
                if (account > 0)
                {
                    reportsModel.curAccount = account;
                    reportsModel.Reports = DatabaseHandler.getReports(customerID, account);
                    reportsModel.PrevReports = DatabaseHandler.getPrevReports(customerID, account);
                }
                else
                {
                    reportsModel.curAccount = account;
                    reportsModel.Reports = DatabaseHandler.getReports(customerID, accountIDs[0]);
                    reportsModel.PrevReports = DatabaseHandler.getPrevReports(customerID, accountIDs[0]);
                }
            }

            return reportsModel;
        }

        public IActionResult Index()
        {
            if (HttpContext.Session.Get("CustomerID") == null)
                return RedirectToAction("Index", "Login");

            return View(generateReportsModel());
        }

        [HttpPost]
        public IActionResult Index(ReportsModel reportsModel)
        {
            if (HttpContext.Session.Get("CustomerID") == null)
                return RedirectToAction("Index", "Login");

            return View(generateReportsModel(reportsModel.curAccount));
        }

        [HttpGet]
        public IActionResult Export(String sd, String ed, int accountID) // EPPlus [params = startdate, enddate]
        {
            byte[] result;

            ExcelPackage pkg = new ExcelPackage();
            ExcelWorksheet ws = pkg.Workbook.Worksheets.Add("Report");

            ws.Cells["A1"].Value = "Online Banking Report";
            ws.Cells["A3"].Value = "Start Date:";
            ws.Cells["A4"].Value = "End Date:";
            ws.Cells["A5"].Value = "Alerts Tripped:";

            ws.Cells["A7"].Value = "Date";
            ws.Cells["B7"].Value = "Reason for Alert";
            ws.Cells["C7"].Value = "Description";
            ws.Cells["D7"].Value = "Location";
            ws.Cells["E7"].Value = "Amount";
            ws.Cells["F7"].Value = "Balance";
            //ws.Cells["G7"].Value = "TransID";

            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            List<Reports> reps = DatabaseHandler.getPrevReports(customerID, accountID);
            ws.Cells["B3"].Value = sd; // Start Date
            ws.Cells["B4"].Value = ed; // End Date
            foreach (Reports rep in reps)
            {
                if (rep.StartDate == sd && rep.EndDate == ed)
                    ws.Cells["B5"].Value = rep.AlertsInTimePeriod;
            }
            //ws.Cells["B5"].Value = reps.Find(x => x.StartDate.Contains(sd) && x.EndDate.Contains(ed)).AlertsInTimePeriod; // Alerts Tripped

            List<Alerts> alrts = DatabaseHandler.getAlerts((Int32)HttpContext.Session.GetInt32("CustomerID"), accountID);

            int startRow = 8;
            string monthDate = sd.Substring(0, 2);
            string yearDate = sd.Substring(sd.Length - 3, 2);
            foreach (Alerts alrt in alrts)
            {
                // monthly case ___ (same month and year)
                string alrtDate = alrt.TransDate;
                if (alrtDate.Substring(0, 2) == monthDate && alrtDate.Substring(alrtDate.Length - 3, 2) == yearDate)
                // monthly case ^^^ (same month and year) 
                {
                    ws.Cells["A" + startRow.ToString()].Value = alrt.TransDate; // Date
                    ws.Cells["B" + startRow.ToString()].Value = alrt.Reason; // Reason for Alert
                    ws.Cells["C" + startRow.ToString()].Value = alrt.TransDesc; // Description
                    ws.Cells["D" + startRow.ToString()].Value = alrt.Location; // Location
                    ws.Cells["E" + startRow.ToString()].Value = alrt.Amount; // Amount
                    ws.Cells["F" + startRow.ToString()].Value = alrt.Balance; // Balance
                    startRow++;
                }
            }

            ws.Cells["A:AZ"].AutoFitColumns();
            result = pkg.GetAsByteArray();
            string fileName = "export" + sd + "to" + ed + ".xlsx";
            return File(result, "application/vnd.ms-excel", fileName);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
