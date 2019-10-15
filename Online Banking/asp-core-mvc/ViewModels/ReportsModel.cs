using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace asp_core_mvc.ViewModels
{
    public class ReportsModel
    {
        public IEnumerable<asp_core_mvc.Models.Reports> Reports { get; set; }
        public IEnumerable<asp_core_mvc.Models.Reports> PrevReports { get; set; }
    }
}
