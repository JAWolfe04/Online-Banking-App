using System;

namespace asp_core_mvc.Models
{
    public class Rules
    {
        public int RuleId { get; set; }
        public string RuleDesc { get; set; }
        public string DateCreated { get; set; }

        public Rules()
        {

        }

        public Rules(int rid, string rdesc, string dcr)
        {
            RuleId = rid;
            RuleDesc = rdesc;
            DateCreated = dcr;
        }
    }
}