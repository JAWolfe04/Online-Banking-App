using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;
using MySql.Data.MySqlClient;

namespace asp_core_mvc.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            List<Alerts> alerts = new List<Alerts>();
            List<Transactions> trans = new List<Transactions>();

            string connStr = "server=localhost;user=root;database=cs451_project;port=3306;password=123456";
            MySqlConnection conn = new MySqlConnection(connStr);
            conn.Open();
            string sql = "SELECT * FROM Alerts";
            string sql2 = "SELECT * FROM Transactions";
            MySqlCommand cmd = new MySqlCommand(sql, conn);
            MySqlCommand cmd2 = new MySqlCommand(sql2, conn);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Alerts alert = new Alerts(
                    rdr.GetString(0), // tdate
                    rdr.GetString(1) // alertreason
                );
                alerts.Add(alert);
            }
            rdr.Close();
            MySqlDataReader rdr2 = cmd2.ExecuteReader();
            while (rdr2.Read())
            {
                Transactions transac = new Transactions(
                    rdr2.GetInt32(0), // tid
                    rdr2.GetString(1), // tdate
                    rdr2.GetString(2), // tdesc
                    rdr2.GetString(3), // lo
                    rdr2.GetDouble(4), // amnt
                    rdr2.GetDouble(5) // bal
                );
                trans.Add(transac);
            }
            rdr2.Close();
            conn.Close();

            ViewBag.AlertsData = alerts;
            ViewBag.TransactionsData = trans;

            return View();
        }

        public IActionResult Transactions() { return View(); }
        public IActionResult Alerts() { return View(); }
        public IActionResult Rules() { return View(); }
        public IActionResult Reports() { return View(); }

        public IActionResult About()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
