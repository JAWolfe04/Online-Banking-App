using System;

namespace asp_core_mvc.Models
{
    public class Reports
    {
        public string Alert { get; set; }
        public int TimesRecently { get; set; }

        // previous reports
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public int AlertsInTimePeriod { get; set; }

        public Reports()
        {

        }

        public Reports(string alrt, int tr)
        {
            Alert = alrt;
            TimesRecently = tr;
        }

        // previous reports
        public Reports(string sdate, string edate, int aitp)
        {
            StartDate = sdate;
            EndDate = edate;
            AlertsInTimePeriod = aitp;
        }
    }
}