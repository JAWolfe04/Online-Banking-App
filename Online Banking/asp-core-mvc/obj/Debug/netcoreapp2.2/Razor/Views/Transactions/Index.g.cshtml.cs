#pragma checksum "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "e721ff7275be76a18f48de66e524ce8ce2062921"
// <auto-generated/>
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
#line 1 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\_ViewImports.cshtml"
using asp_core_mvc;

#line default
#line hidden
#line 2 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\_ViewImports.cshtml"
using asp_core_mvc.Models;

#line default
#line hidden
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"e721ff7275be76a18f48de66e524ce8ce2062921", @"/Views/Transactions/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"af1d6546b63a3ccfc3052c486dd0d689b7adbea0", @"/Views/_ViewImports.cshtml")]
    public class Views_Transactions_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<IEnumerable<asp_core_mvc.Models.Transactions>>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            BeginContext(54, 2, true);
            WriteLiteral("\r\n");
            EndContext();
#line 3 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
  
    ViewBag.Title = "Transactions";

#line default
#line hidden
            BeginContext(100, 6, true);
            WriteLiteral("\r\n<h1>");
            EndContext();
            BeginContext(107, 13, false);
#line 7 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
Write(ViewBag.Title);

#line default
#line hidden
            EndContext();
            BeginContext(120, 338, true);
            WriteLiteral(@"</h1> 

<p>Transactions</p> 

<table class=""table table-condensed table-hover"">
    <thead>
        <tr>
            <th>TransId</th>
            <th>TransDate</th>
            <th>TransDesc</th>
            <th>Location</th>
            <th>Amount</th>
            <th>Balance</th>
        </tr>
    </thead>
    <tbody>
");
            EndContext();
#line 23 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
         foreach (Transactions v in ViewBag.TransactionsData)
        {

#line default
#line hidden
            BeginContext(532, 38, true);
            WriteLiteral("            <tr>\r\n                <td>");
            EndContext();
            BeginContext(571, 9, false);
#line 26 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
               Write(v.TransId);

#line default
#line hidden
            EndContext();
            BeginContext(580, 27, true);
            WriteLiteral("</td>\r\n                <td>");
            EndContext();
            BeginContext(608, 11, false);
#line 27 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
               Write(v.TransDate);

#line default
#line hidden
            EndContext();
            BeginContext(619, 27, true);
            WriteLiteral("</td>\r\n                <td>");
            EndContext();
            BeginContext(647, 11, false);
#line 28 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
               Write(v.TransDesc);

#line default
#line hidden
            EndContext();
            BeginContext(658, 27, true);
            WriteLiteral("</td>\r\n                <td>");
            EndContext();
            BeginContext(686, 10, false);
#line 29 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
               Write(v.Location);

#line default
#line hidden
            EndContext();
            BeginContext(696, 27, true);
            WriteLiteral("</td>\r\n                <td>");
            EndContext();
            BeginContext(724, 8, false);
#line 30 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
               Write(v.Amount);

#line default
#line hidden
            EndContext();
            BeginContext(732, 27, true);
            WriteLiteral("</td>\r\n                <td>");
            EndContext();
            BeginContext(760, 9, false);
#line 31 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
               Write(v.Balance);

#line default
#line hidden
            EndContext();
            BeginContext(769, 26, true);
            WriteLiteral("</td>\r\n            </tr>\r\n");
            EndContext();
#line 33 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Transactions\Index.cshtml"
        }

#line default
#line hidden
            BeginContext(806, 26, true);
            WriteLiteral("    </tbody>\r\n</table>\r\n\r\n");
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