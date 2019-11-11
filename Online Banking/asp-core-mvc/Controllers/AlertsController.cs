using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;
using asp_core_mvc.ViewModels;
using Microsoft.AspNetCore.Http;

namespace asp_core_mvc.Controllers
{
    public class AlertsController : Controller
    {
        private AlertsModel generateAlertsModel(int account = 0)
        {
            AlertsModel alertsModel = new AlertsModel();
            DatabaseHandler databaseHandler = new DatabaseHandler();
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            List<Int32> accountIDs = databaseHandler.getAccounts(customerID);
            alertsModel.accounts = accountIDs;
            if (accountIDs.Count > 0)
            {
                if (account > 0)
                {
                    alertsModel.curAccount = account;
                    alertsModel.alerts = databaseHandler.getAlerts(customerID, account);
                }
                else
                {
                    alertsModel.curAccount = accountIDs[0];
                    alertsModel.alerts = databaseHandler.getAlerts(customerID, accountIDs[0]);
                }
            }
            return alertsModel;
        }

        public IActionResult Index()
        {
            return View(generateAlertsModel());
        }

        [HttpPost]
        public IActionResult Index(AlertsModel alertsModel)
        {
            return View(generateAlertsModel(alertsModel.curAccount));
        }


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
