﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data.Types;
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

            // Change to the DB connection you need
            conn = new MySqlConnection(localconn);
            // conn = new MySqlConnection(localconn);
        }

        public MySqlConnection getConn()
        {
            return conn;
        }

        public List<Alerts> getAlerts(Int32 customerID, Int32 accountID)
        {
            List<Alerts> alerts = new List<Alerts>();

            conn.Open();
            MySqlCommand cmd = new MySqlCommand("getAlerts", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@customerID", customerID);
            cmd.Parameters.AddWithValue("@accountID", accountID);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Alerts alert = new Alerts();
                alert.AlertID = Convert.ToInt32(rdr["ID"]);
                alert.TransId = Convert.ToInt32(rdr["TransactionID"]);
                alert.TransDate = rdr["Date"].ToString();
                alert.TransDesc = rdr["Desc"].ToString();
                if (rdr["Type"].ToString() == "CR") // Deposit
                    alert.TransType = "";
                else if (rdr["Type"].ToString() == "DR") // Withdrawal
                    alert.TransType = "-";
                alert.Location = rdr["Location"].ToString();
                alert.Amount = Convert.ToDouble(rdr["Amount"]);
                alert.Balance = Convert.ToDouble(rdr["Balance"]);
                alert.Reason = rdr["Reason"].ToString();
                alert.Removed = Convert.ToBoolean(rdr["Removed"]);
                alerts.Add(alert);
            }
            conn.Close();

            return alerts;
        }

        public List<Transactions> getTransactions(Int32 accountID)
        {
            List<Transactions> transactions = new List<Transactions>();

            conn.Open();
            MySqlCommand cmd = new MySqlCommand("getTransactions", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@accountID", accountID);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Transactions transaction = new Transactions();
                transaction.TransId = Convert.ToInt32(rdr["ID"]);
                transaction.TransDate = rdr["Date"].ToString();
                transaction.TransDesc = rdr["Desc"].ToString();
                if (rdr["Type"].ToString() == "CR") // Deposit
                    transaction.TransType = "";
                else if (rdr["Type"].ToString() == "DR") // Withdrawal
                    transaction.TransType = "-";
                transaction.Location = rdr["Location"].ToString();
                transaction.Amount = Convert.ToDouble(rdr["Amount"]);
                transaction.Balance = Convert.ToDouble(rdr["Balance"]);
                transactions.Add(transaction);
            }
            conn.Close();

            return transactions;
        }

        public List<Reports> getReports(Int32 customerID, Int32 accountID)
        {
            List<Reports> reports = new List<Reports>();

            conn.Open();
            MySqlCommand cmd = new MySqlCommand("getReports", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@customerID", customerID);
            cmd.Parameters.AddWithValue("@accountID", accountID);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                if(Convert.ToInt32(rdr["OutState"]) > 0)
                    reports.Add(new Reports("Out of State", Convert.ToInt32(rdr["OutState"])));
                if (Convert.ToInt32(rdr["Range"]) > 0)
                    reports.Add(new Reports("Flagged date range", Convert.ToInt32(rdr["Range"])));
                if (Convert.ToInt32(rdr["Category"]) > 0)
                    reports.Add(new Reports("Flagged catagory", Convert.ToInt32(rdr["Category"])));
                if (Convert.ToInt32(rdr["ExcessTran"]) > 0)
                    reports.Add(new Reports("Excessive Transaction", Convert.ToInt32(rdr["ExcessTran"])));
                if (Convert.ToInt32(rdr["ExcessDepo"]) > 0)
                    reports.Add(new Reports("Excessive Deposit", Convert.ToInt32(rdr["ExcessDepo"])));
                if (Convert.ToInt32(rdr["ExcessWith"]) > 0)
                    reports.Add(new Reports("Excessive Withdraw", Convert.ToInt32(rdr["ExcessWith"])));
                if (Convert.ToInt32(rdr["HighBal"]) > 0)
                    reports.Add(new Reports("High Balance", Convert.ToInt32(rdr["HighBal"])));
                if (Convert.ToInt32(rdr["LowBal"]) > 0)
                    reports.Add(new Reports("Low Balance", Convert.ToInt32(rdr["LowBal"])));
            }
            conn.Close();

            return reports;
        }

        public List<Reports> getPrevReports(Int32 customerID, Int32 accountID)
        {
            List<Reports> prevReports = new List<Reports>();

            conn.Open();
            MySqlCommand cmd = new MySqlCommand("getPrevReports", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@customerID", customerID);
            cmd.Parameters.AddWithValue("@accountID", accountID);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                Reports prevReport = new Reports();
                prevReport.StartDate = rdr["Start"].ToString();
                prevReport.EndDate = rdr["End"].ToString();
                prevReport.AlertsInTimePeriod = Convert.ToInt32(rdr["AlertsInTimePeriod"]);
                prevReports.Add(prevReport);
            }
            conn.Close();

            return prevReports;
        }

        public Rules getRules(Int32 customerID, Int32 accountID)
        {
            Rules rules = new Rules();
            rules.accountID = accountID;

            conn.Open();
            MySqlCommand cmd = new MySqlCommand("getRules", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@customerID", customerID);
            cmd.Parameters.AddWithValue("@accountID", accountID);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                rules.OutStateTrans = Convert.ToBoolean(rdr["OutStateChk"]);
                rules.rangeTrans = Convert.ToBoolean(rdr["RangeChk"]);
                rules.startTrans = rdr["Start"].ToString();
                rules.endTrans = rdr["End"].ToString();
                rules.catTrans = Convert.ToBoolean(rdr["CatChk"]);
                rules.catTxt = rdr["Category"].ToString();
                rules.greatTrans = Convert.ToBoolean(rdr["GTranChk"]);
                rules.greatTransAmt = Convert.ToInt32(rdr["GTranAmt"]);
                rules.greatDepo = Convert.ToBoolean(rdr["GDepoChk"]);
                rules.greatDepoAmt = Convert.ToDouble(rdr["GDepoAmt"]);
                rules.greatWithdraw = Convert.ToBoolean(rdr["GWithChk"]);
                rules.greatWithdrawAmt = Convert.ToDouble(rdr["GWithAmt"]);
                rules.greatBal = Convert.ToBoolean(rdr["GBalChk"]);
                rules.greatBalAmt = Convert.ToDouble(rdr["GBalAmt"]);
                rules.lessBal = Convert.ToBoolean(rdr["LBalChk"]);
                rules.lessBalAmt = Convert.ToDouble(rdr["LBalAmt"]);
            }
            conn.Close();

            return rules;
        }

        public void setRules(Int32 customerID, Rules rules)
        {
            conn.Open();
            MySqlCommand cmd = new MySqlCommand("setRules", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@OutStateChk", rules.OutStateTrans);
            cmd.Parameters.AddWithValue("@RangeChk", rules.rangeTrans);
            cmd.Parameters.AddWithValue("@Start", rules.startTrans);
            cmd.Parameters.AddWithValue("@End", rules.endTrans);
            cmd.Parameters.AddWithValue("@CatChk", rules.catTrans);
            cmd.Parameters.AddWithValue("@Category", rules.catTxt);
            cmd.Parameters.AddWithValue("@GTranChk", rules.greatTrans);
            cmd.Parameters.AddWithValue("@GTranAmt", rules.greatTransAmt);
            cmd.Parameters.AddWithValue("@GDepoChk", rules.greatDepo);
            cmd.Parameters.AddWithValue("@GDepoAmt", rules.greatDepoAmt);
            cmd.Parameters.AddWithValue("@GWithChk", rules.greatWithdraw);
            cmd.Parameters.AddWithValue("@GWithAmt", rules.greatWithdrawAmt);
            cmd.Parameters.AddWithValue("@GBalChk", rules.greatBal);
            cmd.Parameters.AddWithValue("@GBalAmt", rules.greatBalAmt);
            cmd.Parameters.AddWithValue("@LBalChk", rules.lessBal);
            cmd.Parameters.AddWithValue("@LBalAmt", rules.lessBalAmt);
            cmd.Parameters.AddWithValue("@customerID", customerID);
            cmd.Parameters.AddWithValue("@accountID", rules.accountID);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public void deleteRules(Int32 customerID, Int32 accountID)
        {
            conn.Open();
            MySqlCommand cmd = new MySqlCommand("deleteRules", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@customerID", customerID);
            cmd.Parameters.AddWithValue("@accountID", accountID);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public Boolean validateUser(LoginModel login)
        {
            Boolean validUser = false;

            conn.Open();
            MySqlCommand cmd = new MySqlCommand("validateUser", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@username", login.UserName);
            cmd.Parameters.AddWithValue("@password", login.Password);
            MySqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                validUser = true;
                login.CustomerID = Convert.ToInt32(rdr["ID"]);
                login.FullName = rdr["FirstName"].ToString() + " " + rdr["LastName"].ToString();
            }
            conn.Close();

            return validUser;
        }

        public List<Int32> getAccounts(Int32 customerID)
        {
            List<Int32> accountID = new List<Int32>();

            conn.Open();
            MySqlCommand cmd = new MySqlCommand("getAccounts", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@customerID", customerID);
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
