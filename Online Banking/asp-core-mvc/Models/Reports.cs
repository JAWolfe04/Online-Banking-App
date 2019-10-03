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
    }
}