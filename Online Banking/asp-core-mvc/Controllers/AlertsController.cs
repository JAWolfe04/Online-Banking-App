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
            List<Alerts> alerts = new List<Alerts>();

            string connStr = "server=localhost;user=root;database=cs451_project;port=3306;password=123456";
            MySqlConnection conn = new MySqlConnection(connStr);
            conn.Open();
            string sql = "SELECT * FROM Alerts";
            MySqlCommand cmd = new MySqlCommand(sql, conn);
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
            conn.Close();

            ViewBag.AlertsData = alerts;

            return View();
        }


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
