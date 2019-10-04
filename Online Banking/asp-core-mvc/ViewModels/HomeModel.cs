using System.Collections.Generic;
namespace asp_core_mvc.ViewModels
{
    public class HomeModel
    {
        public IEnumerable<asp_core_mvc.Models.Alerts> Alerts { get; set; }
        public IEnumerable<asp_core_mvc.Models.Transactions> Transactions { get; set; }
    }
}
