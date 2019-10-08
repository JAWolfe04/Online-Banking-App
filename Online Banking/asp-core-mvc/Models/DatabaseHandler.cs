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
            string localconn = "server=localhost;" +
                             "user=root;" +
                             "database=cs451_project;" +
                             "port=3306;" +
                             "password=123456";

            string UMKCconn = "server=KC-ISIA-MySQL1D;" +
                             "user=CS451R_FS19G6usr;" +
                             "database=cs451r_fs2019_group6;" +
                             "port=3306;" +
                             "password=TNmDS9KuTrJu7bl";

            //Change to the DB connection you need
            conn = new MySqlConnection(UMKCconn);
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
                alert.TransDate = rdr["TransDate"].ToString();
                alert.AlertReason = rdr["AlertReason"].ToString();
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
                transaction.TransId = Convert.ToInt32(rdr["Transaction_id"]);
                transaction.TransDate = rdr["TrnsDate"].ToString();
                transaction.TransDesc = rdr["TrnsName"].ToString();
                transaction.Location = rdr["TrnsLocation"].ToString();
                transaction.Amount = Convert.ToDouble(rdr["TrnsAmount"]);
                transaction.Balance = Convert.ToDouble(rdr["TrnsBalance"]);
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

        public Rules getRules(Int32 customerID, Int32 accountID)
        {
            Rules rules = new Rules();
            rules.accountID = accountID;
            string sqlStatement = "SELECT * FROM Rules WHERE CustomerId=" + customerID + " AND AccountID=" + accountID;
            MySqlCommand cmd = new MySqlCommand(sqlStatement, conn);
            conn.Open();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while(rdr.Read())
            {
                rules.RuleID = Convert.ToInt32(rdr["RuleID"]);
                rules.OutStateTrans = Convert.ToBoolean(rdr["OutStateTrans"]);
                rules.rangeTrans = Convert.ToBoolean(rdr["RangeTrans"]);
                rules.startTrans = rdr["StartTrans"].ToString();
                rules.endTrans = rdr["EndTrans"].ToString();
                rules.catTrans = Convert.ToBoolean(rdr["CatTrans"]);
                rules.catTxt = rdr["Catagory"].ToString();
                rules.greatTrans = Convert.ToBoolean(rdr["GreatTrans"]);
                rules.greatTransAmt = Convert.ToInt32(rdr["GreatTransAmt"]);
                rules.greatDepo = Convert.ToBoolean(rdr["GreatDepo"]);
                rules.greatDepoAmt = Convert.ToDouble(rdr["GreatDepoAmt"]);
                rules.greatWithdraw = Convert.ToBoolean(rdr["GreatWithdraw"]);
                rules.greatWithdrawAmt = Convert.ToDouble(rdr["GreatWithdrawAmt"]);
                rules.greatBal = Convert.ToBoolean(rdr["GreatBal"]);
                rules.greatBalAmt = Convert.ToDouble(rdr["GreatBalAmt"]);
                rules.lessBal = Convert.ToBoolean(rdr["LessBal"]);
                rules.lessBalAmt = Convert.ToDouble(rdr["LessBalAmt"]);
            }
            conn.Close();
            return rules;
        }

        public void setRules(Int32 customerID, Rules rules)
        {
            string sqlStatement;
            if (rules.RuleID > 0)
            {
                sqlStatement = "UPDATE rules SET" +
                "`CustomerId` = " + customerID +
                ",`AccountID` = " + rules.accountID +
                ",`OutStateTrans` = " + rules.OutStateTrans +
                ",`RangeTrans` = " + rules.rangeTrans +
                ",`StartTrans` = '" + rules.startTrans +
                "',`EndTrans` = '" + rules.endTrans +
                "',`CatTrans` = " + rules.catTrans +
                ",`Catagory` = '" + rules.catTxt +
                "',`GreatTrans` = " + rules.greatTrans +
                ",`GreatTransAmt` = " + rules.greatTransAmt +
                ",`GreatDepo` = " + rules.greatDepo +
                ",`GreatDepoAmt` = " + rules.greatDepoAmt +
                ",`GreatWithdraw` = " + rules.greatWithdraw +
                ",`GreatWithdrawAmt` = " + rules.greatWithdrawAmt +
                ",`GreatBal` = " + rules.greatBal +
                ",`GreatBalAmt` = " + rules.greatBalAmt +
                ",`LessBal` = " + rules.lessBal +
                ",`LessBalAmt` = " + rules.lessBalAmt +
                " WHERE `RuleID` = " + rules.RuleID + ";";
            }
            else
            {
                sqlStatement = "INSERT INTO Rules VALUES (0," +
                customerID + "," + rules.accountID + "," + rules.OutStateTrans + "," +
                rules.rangeTrans + ",'" + rules.startTrans + "','" +
                rules.endTrans + "'," + rules.catTrans + ",'" +
                rules.catTxt + "'," + rules.greatTrans + "," +
                rules.greatTransAmt + "," + rules.greatDepo + "," +
                rules.greatDepoAmt + "," + rules.greatWithdraw + "," +
                rules.greatWithdrawAmt + "," + rules.greatBal + "," +
                rules.greatBalAmt + "," + rules.lessBal + "," +
                rules.lessBalAmt + ")";
            }
            MySqlCommand cmd = new MySqlCommand(sqlStatement, conn);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public void deleteRules(Int32 customerID, Int32 accountID)
        {
            string sqlStatement = "DELETE FROM Rules WHERE CustomerID=" + customerID + " AND AccountID=" + accountID;
            MySqlCommand cmd = new MySqlCommand(sqlStatement, conn);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public Boolean validateUser(LoginModel login)
        {
            Boolean validUser = false;
            String sqlQuery = "SELECT * FROM Customers WHERE CustUserName='" + login.UserName + "' AND CustPassword='" + login.Password + "';";
            MySqlCommand cmd = new MySqlCommand(sqlQuery, conn);
            conn.Open();
            MySqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.Read())
            {
                validUser = true;
                login.CustomerID = Convert.ToInt32(rdr["Customer_ID"]);
                login.FullName = rdr["CustFirst_Name"].ToString() + " " + rdr["CustLast_Name"].ToString();
            }
            conn.Close();

            return validUser;
        }

        public List<Int32> getAccounts(Int32 CustomerID)
        {
            List<Int32> accountID = new List<Int32>();
            string sqlStatement = "SELECT AccountID FROM Customer_Accounts WHERE CustomerID=" + CustomerID;
            MySqlCommand cmd = new MySqlCommand(sqlStatement, conn);
            conn.Open();
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                accountID.Add(Convert.ToInt32(rdr["AccountID"]));
            }
            conn.Close();
            return accountID;
        }
    }
}
