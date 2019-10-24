#pragma checksum "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "c43d483bff85c427fef6e1e8a42d4a41bf92c535"

#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Home_Index), @"mvc.1.0.view", @"/Views/Home/Index.cshtml")]
[assembly:global::Microsoft.AspNetCore.Mvc.Razor.Compilation.RazorViewAttribute(@"/Views/Home/Index.cshtml", typeof(AspNetCore.Views_Home_Index))]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#line 1 "C:\Users\Jonathan\Desktop\UMKC\CS 451\Project\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\_ViewImports.cshtml"
using asp_core_mvc;

#line default
#line hidden
#line 2 "C:\Users\Jonathan\Desktop\UMKC\CS 451\Project\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\_ViewImports.cshtml"
using asp_core_mvc.Models;

#line default
#line hidden
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"c43d483bff85c427fef6e1e8a42d4a41bf92c535", @"/Views/Home/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"c1025ff3a56cbdba490e55e75a7805ce0b255268", @"/Views/_ViewImports.cshtml")]
    public class Views_Home_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<asp_core_mvc.ViewModels.HomeModel>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
#line 2 "C:\Users\Jonathan\Desktop\UMKC\CS 451\Project\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
  
    ViewData["Title"] = "Home Page";

#line default
#line hidden
            BeginContext(83, 431, true);
            WriteLiteral(@"
<div class=""jumbotron"">
    <h1>Online Banking</h1>
    <p class=""lead"">This is an online banking web application using ASP.NET Core MVC.</p>
</div>

<div class=""row"">
    <div class=""col-md-4"">
        <h2>System Messages</h2>
        <p>News and System Messages from the Bank.</p>
    </div>
    <div class=""col-md-4"">
        <h2>Account Balance</h2>
        <p>Information about Current Account Balance Here:</p>
        <h2>$");
            EndContext();
            BeginContext(515, 34, false);
#line 19 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
        Write(Model.Transactions.First().Balance);

#line default
#line hidden
            EndContext();
            BeginContext(549, 363, true);
            WriteLiteral(@"</h2>
    </div>
    <div class=""col-md-4"">
        <h2>Recent Alerts</h2>  <!-- Recent 5 Alerts -->
        <table class=""table table-condensed table-hover"" style=""width:400px"">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Reason for Alert</th>
                </tr>
            </thead>
            <tbody>
");
            EndContext();
#line 31 "C:\Users\Jonathan\Desktop\UMKC\CS 451\Project\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                 foreach (Alerts alert in Model.Alerts.Take(5))
                {

#line default
#line hidden
            BeginContext(994, 45, true);
            WriteLiteral("                <tr>\n                    <td>");
            EndContext();
            BeginContext(1040, 15, false);
#line 34 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                   Write(alert.TransDate);

#line default
#line hidden
            EndContext();
            BeginContext(1055, 30, true);
            WriteLiteral("</td>\n                    <td>");
            EndContext();
            BeginContext(1086, 17, false);
#line 35 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                   Write(alert.AlertReason);

#line default
#line hidden
            EndContext();
            BeginContext(1103, 28, true);
            WriteLiteral("</td>\n                </tr>\n");
            EndContext();
#line 37 "C:\Users\Jonathan\Desktop\UMKC\CS 451\Project\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                }

#line default
#line hidden
            BeginContext(1149, 469, true);
            WriteLiteral(@"            </tbody>
        </table>
    </div>
</div>

<div class=""row"">
    <div class=""col-md-4"">
        <h2>Recent Transactions</h2>
        <table class=""table table-condensed table-hover"" style=""width:600px"">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Description</th>
                    <th>Amount</th>
                    <th>Balance</th>
                </tr>
            </thead>
            <tbody>
");
            EndContext();
#line 56 "C:\Users\Jonathan\Desktop\UMKC\CS 451\Project\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                 foreach (Transactions transaction in Model.Transactions.Take(10)) // first 10
                {

#line default
#line hidden
            BeginContext(1731, 45, true);
            WriteLiteral("                <tr>\n                    <td>");
            EndContext();
            BeginContext(1777, 21, false);
#line 59 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                   Write(transaction.TransDate);

#line default
#line hidden
            EndContext();
            BeginContext(1798, 30, true);
            WriteLiteral("</td>\n                    <td>");
            EndContext();  BeginContext(1829, 21, false);
#line 60 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                   Write(transaction.TransDesc);

#line default
#line hidden
            EndContext();
            BeginContext(1850, 30, true);
            WriteLiteral("</td>\n                    <td>");
            EndContext();
            BeginContext(1881, 71, false);
#line 61 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                   Write(String.Format("{0}{1:0.00}", transaction.TransType, transaction.Amount));

#line default
#line hidden
            EndContext();
            BeginContext(1952, 30, true);
            WriteLiteral("</td>\n                    <td>");
            EndContext();
            BeginContext(1983, 46, false);
#line 62 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                   Write(String.Format("{0:0.00}", transaction.Balance));

#line default
#line hidden
            EndContext();
            BeginContext(2029, 28, true);
            WriteLiteral("</td>\n                </tr>\n");
            EndContext();
#line 64 "C:\Users\Jonathan\Desktop\UMKC\CS 451\Project\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Home\Index.cshtml"
                }

#line default
#line hidden
            BeginContext(2075, 55, true);
            WriteLiteral("            </tbody>\n        </table>\n    </div>\n</div>");
            EndContext();
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<asp_core_mvc.ViewModels.HomeModel> Html { get; private set; }
    }
}
#pragma warning restore 1591
