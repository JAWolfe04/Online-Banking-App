using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using asp_core_mvc.Models;

using MySql.Data;
using MySql.Data.MySqlClient;

namespace asp_core_mvc.Controllers
{
    public class RulesController : Controller
    {
        //Temporary customerID for testing until a login is made
        Int32 tempCustomerID = 5683648;

        public IActionResult Index()
        {
            DatabaseHandler databaseHandler = new DatabaseHandler();
            return View(databaseHandler.getRules(tempCustomerID));
        }

        [HttpPost]
        public IActionResult Edit(Rules ruleModel)
        {
            DatabaseHandler databaseHandler = new DatabaseHandler();
            if (ruleModel.OutStateTrans == false && ruleModel.rangeTrans == false &&
                ruleModel.catTrans == false && ruleModel.greatTrans == false &&
                ruleModel.greatDepo == false && ruleModel.greatWithdraw == false &&
                ruleModel.greatBal == false && ruleModel.lessBal == false)
                databaseHandler.deleteRules(tempCustomerID);
            else
                databaseHandler.setRules(tempCustomerID, ruleModel);

            return RedirectToAction("Index");
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

    }
}
