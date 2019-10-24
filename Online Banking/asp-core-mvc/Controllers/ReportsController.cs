using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;
using asp_core_mvc.ViewModels;
using System;
using OfficeOpenXml;
using System.Collections.Generic;

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

        public IActionResult Export() // EPPlus
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

            // fill with data from here //////////////////// REPLACE WITH DATABASE DATA
            ws.Cells["B3"].Value = "07/01/19";
            ws.Cells["B4"].Value = "07/31/19";
            ws.Cells["B5"].Value = "2";
            List<List<string>> reps = new List<List<string>>();
            reps.Add(new List<string>
            {
                "07/07/19", "Out of State", "Target", "NE", "-98.00", "5138.53"
            });
            reps.Add(new List<string>
            {
                "07/06/19", "Out of State", "Price Chopper", "NE", "-43.00", "5236.53"
            });
            // fill with data above here //////////////////// REPLACE WITH DATABASE DATA

            int startRow = 8;
            foreach (List<string> rep in reps)
            {
                ws.Cells["A" + startRow.ToString()].Value = rep[0];
                ws.Cells["B" + startRow.ToString()].Value = rep[1];
                ws.Cells["C" + startRow.ToString()].Value = rep[2];
                ws.Cells["D" + startRow.ToString()].Value = rep[3];
                ws.Cells["E" + startRow.ToString()].Value = rep[4];
                ws.Cells["F" + startRow.ToString()].Value = rep[5];
                startRow++;
            }
            ws.Cells["A:AZ"].AutoFitColumns();
            result = pkg.GetAsByteArray();
            return File(result, "application/vnd.ms-excel", "export.xlsx");
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
