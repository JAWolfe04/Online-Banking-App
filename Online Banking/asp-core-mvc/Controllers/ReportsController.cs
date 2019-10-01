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
    public class ReportsController : Controller
    {
        public IActionResult Index()
        {
            List<Reports> reports = new List<Reports>();
            List<Reports> prevReports = new List<Reports>();

            string connStr = "server=localhost;user=root;database=cs451_project;port=3306;password=123456";
            MySqlConnection conn = new MySqlConnection(connStr);
            conn.Open();
            string sql = "SELECT * FROM Reports";
            string sql2 = "SELECT * FROM PreviousReports";
            MySqlCommand cmd = new MySqlCommand(sql, conn);
            MySqlCommand cmd2 = new MySqlCommand(sql2, conn);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Reports report = new Reports(
                    rdr.GetString(0), // alert 
                    rdr.GetInt32(1) // tr
                );
                reports.Add(report);
            }
            rdr.Close();
            MySqlDataReader rdr2 = cmd2.ExecuteReader();
            while (rdr2.Read())
            {
                Reports prevReport = new Reports(
                    rdr2.GetString(0), // sdat
                    rdr2.GetString(1), // edate
                    rdr2.GetInt32(2) // aitp
                );
                prevReports.Add(prevReport);
            }
            rdr2.Close();
            conn.Close();

            ViewBag.ReportsData = reports;
            ViewBag.PrevReportsData = prevReports;

            return View();
        }


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
