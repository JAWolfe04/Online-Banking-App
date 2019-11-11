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
    public class HomeController : Controller
    {
        private HomeModel generateHomeModel(int account = 0)
        {
            HomeModel homeModel = new HomeModel();
            DatabaseHandler databaseHandler = new DatabaseHandler();
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            List<Int32> accountIDs = databaseHandler.getAccounts(customerID);
            homeModel.accounts = accountIDs;
            if (accountIDs.Count > 0)
            {
                if(account > 0)
                {
                    homeModel.curAccount = account;
                    homeModel.Balance = databaseHandler.getAccount(account).Balance;
                    homeModel.Alerts = databaseHandler.getAlerts(customerID, account);
                    homeModel.Transactions = databaseHandler.getTransactions(account);
                }
                else
                {
                    homeModel.curAccount = accountIDs[0];
                    homeModel.Balance = databaseHandler.getAccount(accountIDs[0]).Balance;
                    homeModel.Alerts = databaseHandler.getAlerts(customerID, accountIDs[0]);
                    homeModel.Transactions = databaseHandler.getTransactions(accountIDs[0]);
                }
            }
            return homeModel;
        }

        public IActionResult Index()
        {
            return View(generateHomeModel());
        }

        [HttpPost]
        public IActionResult Index(HomeModel homeModel)
        {
            return View(generateHomeModel(homeModel.curAccount));
        }

        public IActionResult Transactions() { return View(); }
        public IActionResult Alerts() { return View(); }
        public IActionResult Rules() { return View(); }
        public IActionResult Reports() { return View(); }
        public IActionResult About() { return View(); }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
