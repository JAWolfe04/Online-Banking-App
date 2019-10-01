using System;

namespace asp_core_mvc.Models
{
    public class Alerts
    {
        public string TransDate { get; set; }
        public string AlertReason { get; set; }

        public Alerts()
        {

        }

        public Alerts(string tDate, string ar)
        {
            TransDate = tDate;
            AlertReason = ar;
        }
    }
}