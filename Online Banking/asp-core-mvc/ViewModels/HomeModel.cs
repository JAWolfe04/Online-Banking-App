using System.Collections.Generic;
using asp_core_mvc.Models;

namespace asp_core_mvc.ViewModels
{
    public class HomeModel
    {
        public IEnumerable<Alerts> Alerts { get; set; }
        public IEnumerable<Transactions> Transactions { get; set; }
    }
}
