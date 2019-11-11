using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Http;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;
using asp_core_mvc.ViewModels;

namespace asp_core_mvc.Controllers
{
    public class TransactionsController : Controller
    {
        private TransactionsModel GenerateTransactionsModel(int account = 0)
        {
            TransactionsModel transModel = new TransactionsModel();
            DatabaseHandler databaseHandler = new DatabaseHandler();
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            List<Int32> accountIDs = databaseHandler.getAccounts(customerID);
            transModel.accounts = accountIDs;
            if (accountIDs.Count > 0)
            {
                if (account > 0)
                {
                    transModel.curAccount = account;
                    transModel.transactions = databaseHandler.getTransactions(account);
                }
                else
                {
                    transModel.curAccount = accountIDs[0];
                    transModel.transactions = databaseHandler.getTransactions(accountIDs[0]);
                }
            }
            return transModel;
        }
            public IActionResult Index()
        {
            return View(GenerateTransactionsModel());
        }

        [HttpPost]
        public IActionResult Index(TransactionsModel transModel)
        {
            return View(GenerateTransactionsModel(transModel.curAccount));
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        
    }
}
