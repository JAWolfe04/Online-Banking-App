using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;

namespace asp_core_mvc.Models
{
    public class Transactions
    {
        public int TransId { get; set; }
        public string TransDate { get; set; }
        public string TransDesc { get; set; }
        public string Location { get; set; }
        public double Amount { get; set; }
        public double Balance { get; set; }

        public Transactions()
        {

        }

        public Transactions(int tId, string tDate, string tDesc, string loc, double amnt, double bal)
        {
            TransId = tId;
            TransDate = tDate;
            TransDesc = tDesc;
            Location = loc;
            Amount = amnt;
            Balance = bal;
        }
    }

}