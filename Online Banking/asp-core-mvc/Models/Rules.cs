using System;
using System.ComponentModel.DataAnnotations;

namespace asp_core_mvc.Models
{
    public class Rules
    {
        public Int32 RuleID { get; set; }
        public Int32 accountID { get; set; }

        [Display(Name = "Enable out of state transactions")]
        public bool OutStateTrans { get; set; }

        [Display(Name = "Enable transactions between dates")]
        public bool rangeTrans { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Transaction between Start")]
        public String startTrans { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "End")]
        public String endTrans { get; set; }

        [Display(Name = "Enable transaction categories")]
        public bool catTrans { get; set; }

        [Display(Name = "Transaction category")]
        public string catTxt { get; set; }

        [Display(Name = "Enable transactions more than amount")]
        public bool greatTrans { get; set; }

        [DataType(DataType.Currency)]
        [Display(Name = "Transaction more than")]
        public Double greatTransAmt { get; set; }

        [Display(Name = "Enable deposits to account more than amount")]
        public bool greatDepo { get; set; }

        [DataType(DataType.Currency)]
        [Display(Name = "Deposit to account more than")]
        public Double greatDepoAmt { get; set; }

        [Display(Name = "Enable withdraws from account more than amount")]
        public bool greatWithdraw { get; set; }

        [DataType(DataType.Currency)]
        [Display(Name = "Withdraw from account more than")]
        public Double greatWithdrawAmt { get; set; }

        [Display(Name = "Enable balance more than amount")]
        public bool greatBal { get; set; }

        [DataType(DataType.Currency)]
        [Display(Name = "Balance more than")]
        public Double greatBalAmt { get; set; }

        [Display(Name = "Enable balance less than amount")]
        public bool lessBal { get; set; }

        [DataType(DataType.Currency)]
        [Display(Name = "Balance less than")]
        public Double lessBalAmt { get; set; }
    }
}