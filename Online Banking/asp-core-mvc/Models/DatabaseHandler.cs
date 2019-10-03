using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace asp_core_mvc.Models
{
    public class DatabaseHandler
    {
        private MySqlConnection conn;

        public DatabaseHandler()
        {
            string connStr = "server=localhost;" +
                             "user=root;" +
                             "database=cs451_project;" +
                             "port=3306;" +
                             "password=123456";

            conn = new MySqlConnection(connStr);
        }

        public List<Alerts> getAlerts()
        {
            List<Alerts> alerts = new List<Alerts>();
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM Alerts", conn);
            conn.Open();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Alerts alert = new Alerts();
                alert.TransDate = rdr.GetString(0);
                alert.AlertReason = rdr.GetString(1);
                alerts.Add(alert);
            }
            conn.Close();
            return alerts;
        }

        public List<Transactions> getTransactions()
        {
            List<Transactions> transactions = new List<Transactions>();
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM Transactions", conn);
            conn.Open();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Transactions transaction = new Transactions();
                transaction.TransId = rdr.GetInt32(0);
                transaction.TransDate = rdr.GetString(1);
                transaction.TransDesc = rdr.GetString(2);
                transaction.Location = rdr.GetString(3);
                transaction.Amount = rdr.GetDouble(4);
                transaction.Balance = rdr.GetDouble(5);
                transactions.Add(transaction);
            }
            conn.Close();
            return transactions;
        }

        public List<Reports> getReports()
        {
            List<Reports> reports = new List<Reports>();
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM Reports", conn);
            conn.Open();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Reports report = new Reports();
                report.Alert = rdr.GetString(0);
                report.TimesRecently = rdr.GetInt32(1);
                reports.Add(report);
            }
            conn.Close();
            return reports;
        }

        public List<Reports> getPrevReports()
        {
            List<Reports> prevReports = new List<Reports>();
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM PreviousReports", conn);
            conn.Open();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Reports prevReport = new Reports();
                prevReport.StartDate = rdr.GetString(0);
                prevReport.EndDate = rdr.GetString(1);
                prevReport.AlertsInTimePeriod = rdr.GetInt32(2);
                prevReports.Add(prevReport);
            }
            conn.Close();
            return prevReports;
        }

        public List<Rules> getRules()
        {
            List<Rules> rules = new List<Rules>();
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM Rules", conn);
            conn.Open();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Rules rule = new Rules();
                rule.RuleId = rdr.GetInt32(0);
                rule.RuleDesc = rdr.GetString(1);
                rule.DateCreated = rdr.GetString(2);
                rules.Add(rule);
            }
            conn.Close();
            return rules;
        }
    }
}
