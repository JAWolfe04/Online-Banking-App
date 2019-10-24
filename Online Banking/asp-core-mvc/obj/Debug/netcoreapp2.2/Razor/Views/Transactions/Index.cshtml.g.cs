#pragma checksum "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "7d5da5457afec62dff2373588bb5b9e00be6ea89"

#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Transactions_Index), @"mvc.1.0.view", @"/Views/Transactions/Index.cshtml")]
[assembly:global::Microsoft.AspNetCore.Mvc.Razor.Compilation.RazorViewAttribute(@"/Views/Transactions/Index.cshtml", typeof(AspNetCore.Views_Transactions_Index))]
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
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"7d5da5457afec62dff2373588bb5b9e00be6ea89", @"/Views/Transactions/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"c1025ff3a56cbdba490e55e75a7805ce0b255268", @"/Views/_ViewImports.cshtml")]
    public class Views_Transactions_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<IEnumerable<asp_core_mvc.Models.Transactions>>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            BeginContext(53, 1, true);
            WriteLiteral("\n");
            EndContext();
#line 3 "C:\Users\Jonathan\Desktop\UMKC\CS 451\Project\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
  
    ViewBag.Title = "Transactions";

#line default
#line hidden
            BeginContext(95, 5, true);
            WriteLiteral("\n<h1>");
            EndContext();

            BeginContext(101, 13, false);
#line 7 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
Write(ViewBag.Title);

#line default
#line hidden
            EndContext();
            BeginContext(114, 261, true);
            WriteLiteral(@"</h1> 

<table class=""table table-condensed table-hover"">
    <thead>
        <tr>
            <th>Date</th>
            <th>Desc</th>
            <th>Location</th>
            <th>Amount</th>
            <th>Balance</th>
        </tr>
    </thead>
    <tbody>
");
            EndContext();
#line 20 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
         foreach (Transactions transaction in Model)
        {

#line default
#line hidden
            BeginContext(438, 29, true);
            WriteLiteral("        <tr>\n            <td>");
            EndContext();
            BeginContext(468, 21, false);
#line 23 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
           Write(transaction.TransDate);

#line default
#line hidden
            EndContext();
            BeginContext(489, 22, true);
            WriteLiteral("</td>\n            <td>");
            EndContext();
            BeginContext(512, 21, false);
#line 24 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
           Write(transaction.TransDesc);

#line default
#line hidden
            EndContext();
            BeginContext(533, 22, true);
            WriteLiteral("</td>\n            <td>");
            EndContext();
            BeginContext(556, 20, false);
#line 25 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
           Write(transaction.Location);

#line default
#line hidden
            EndContext();
            BeginContext(576, 22, true);
            WriteLiteral("</td>\n            <td>");
            EndContext();
            BeginContext(599, 71, false);
#line 26 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
           Write(String.Format("{0}{1:0.00}", transaction.TransType, transaction.Amount));

#line default
#line hidden
            EndContext();
            BeginContext(670, 22, true);
            WriteLiteral("</td>\n            <td>");
            EndContext();
            BeginContext(693, 46, false);
#line 27 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
           Write(String.Format("{0:0.00}", transaction.Balance));

#line default
#line hidden
            EndContext();
            BeginContext(739, 20, true);
            WriteLiteral("</td>\n        </tr>\n");
            EndContext();
#line 29 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
        }

#line default
#line hidden
            BeginContext(769, 23, true);
            WriteLiteral("    </tbody>\n</table>\n\n");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<IEnumerable<asp_core_mvc.Models.Transactions>> Html { get; private set; }
    }
}
#pragma warning restore 1591
