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
    public class RulesController : Controller
    {
        public IActionResult Index()
        {
            RulesModel rulesModel = new RulesModel();
            DatabaseHandler databaseHandler = new DatabaseHandler();
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            List<Int32> accountIDs = databaseHandler.getAccounts(customerID);
            rulesModel.accounts = accountIDs;
            if (accountIDs.Count > 0)
            {
                rulesModel.rules = databaseHandler.getRules(customerID, accountIDs[0]);
                rulesModel.curAccount = accountIDs[0];
            }
            return View(rulesModel);
        }

        [HttpPost]
        public IActionResult Index(RulesModel ruleModel)
        {
            RulesModel rulesModel = new RulesModel();
            DatabaseHandler databaseHandler = new DatabaseHandler();
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            List<Int32> accountIDs = databaseHandler.getAccounts(customerID);
            rulesModel.accounts = accountIDs;
            rulesModel.rules = databaseHandler.getRules(customerID, ruleModel.curAccount);
            return View(rulesModel);
        }

        [HttpPost]
        public IActionResult Edit(RulesModel ruleModel)
        {
            DatabaseHandler databaseHandler = new DatabaseHandler();
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            if (ruleModel.rules.OutStateTrans == false && ruleModel.rules.rangeTrans == false &&
                ruleModel.rules.catTrans == false && ruleModel.rules.greatTrans == false &&
                ruleModel.rules.greatDepo == false && ruleModel.rules.greatWithdraw == false &&
                ruleModel.rules.greatBal == false && ruleModel.rules.lessBal == false)
                databaseHandler.deleteRules(customerID, ruleModel.rules.accountID);
            else
                databaseHandler.setRules(customerID, ruleModel.rules);

            return RedirectToAction("Index");
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
