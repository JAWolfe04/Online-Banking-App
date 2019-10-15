using System;

namespace asp_core_mvc.Models
{
    public class Alerts
    {
        public int TransId { get; set; }
        public string TransDate { get; set; }
        public string TransDesc { get; set; }
        public string TransType { get; set; }
        public string Location { get; set; }
        public double Amount { get; set; }
        public double Balance { get; set; }
        public string AlertReason { get; set; }
    }
}