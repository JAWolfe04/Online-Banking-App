using System;
using System.Collections.Generic;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;
using asp_core_mvc.ViewModels;
using Microsoft.AspNetCore.Http;

namespace asp_core_mvc.Controllers
{
    public class RulesController : Controller
    {
        private RulesModel GenerateRulesModel(int account = 0)
        {
            RulesModel rulesModel = new RulesModel();
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            List<Int32> accountIDs = DatabaseHandler.getAccounts(customerID);
            rulesModel.accounts = accountIDs;
            if (accountIDs.Count > 0)
            {
                if(account > 0)
                {
                    rulesModel.curAccount = account;
                    rulesModel.rules = DatabaseHandler.getRules(customerID, account);
                }
                else
                {
                    rulesModel.curAccount = accountIDs[0];
                    rulesModel.rules = DatabaseHandler.getRules(customerID, accountIDs[0]);
                }
            }
            return rulesModel;
        }

        public IActionResult Index()
        {
            if (HttpContext.Session.Get("CustomerID") == null)
                return RedirectToAction("Index", "Login");

            return View(GenerateRulesModel());
        }

        [HttpPost]
        public IActionResult Index(RulesModel ruleModel)
        {
            if (HttpContext.Session.Get("CustomerID") == null)
                return RedirectToAction("Index", "Login");

            return View(GenerateRulesModel(ruleModel.curAccount));
        }

        [HttpPost]
        public IActionResult Edit(RulesModel ruleModel)
        {
            Int32 customerID = (Int32)HttpContext.Session.GetInt32("CustomerID");
            if (ruleModel.rules.OutStateTrans == false && ruleModel.rules.rangeTrans == false &&
                ruleModel.rules.catTrans == false && ruleModel.rules.greatTrans == false &&
                ruleModel.rules.greatDepo == false && ruleModel.rules.greatWithdraw == false &&
                ruleModel.rules.greatBal == false && ruleModel.rules.lessBal == false)
                DatabaseHandler.deleteRules(customerID, ruleModel.rules.accountID);
            else
                DatabaseHandler.setRules(customerID, ruleModel.rules);

            return RedirectToAction("Index");
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
