#pragma checksum "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "0b16ecf7144738560f7c635fe6549a2974e606db"

#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Reports_Index), @"mvc.1.0.view", @"/Views/Reports/Index.cshtml")]
[assembly:global::Microsoft.AspNetCore.Mvc.Razor.Compilation.RazorViewAttribute(@"/Views/Reports/Index.cshtml", typeof(AspNetCore.Views_Reports_Index))]
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
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"0b16ecf7144738560f7c635fe6549a2974e606db", @"/Views/Reports/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"c1025ff3a56cbdba490e55e75a7805ce0b255268", @"/Views/_ViewImports.cshtml")]
    public class Views_Reports_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<asp_core_mvc.ViewModels.ReportsModel>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            BeginContext(44, 1, true);
            WriteLiteral("\n");
            EndContext();
#line 3 "C:\Users\Jonathan\Desktop\UMKC\CS 451\Project\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
  
    ViewBag.Title = "Reports";

#line default
#line hidden
            BeginContext(81, 5, true);
            WriteLiteral("\n<h1>");
            EndContext();
            BeginContext(87, 13, false);
#line 7 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
Write(ViewBag.Title);

#line default
#line hidden
            EndContext();
            BeginContext(100, 191, true);
            WriteLiteral("</h1>\n\n<table class=\"table table-condensed table-hover\">\n    <thead>\n        <tr>\n            <th>Rule</th>\n            <th>Times Tripped Recently</th>\n        </tr>\n    </thead>\n    <tbody>\n");
            EndContext();
#line 17 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
         foreach (Reports report in Model.Reports)
        {

#line default
#line hidden
            BeginContext(352, 29, true);
            WriteLiteral("        <tr>\n            <td>");
            EndContext();
            BeginContext(382, 17, false);
#line 20 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
           Write(report.RuleReport);

#line default
#line hidden
            EndContext();
            BeginContext(399, 22, true);
            WriteLiteral("</td>\n            <td>");
            EndContext();
            BeginContext(422, 20, false);
#line 21 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
           Write(report.TimesRecently);

#line default
#line hidden
            EndContext();
            BeginContext(442, 20, true);
            WriteLiteral("</td>\n        </tr>\n");
            EndContext();
#line 23 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
        }

#line default
#line hidden
            BeginContext(472, 298, true);
            WriteLiteral(@"    </tbody>
</table>

<p>Previous Reports</p>

<table class=""table table-condensed table-hover"">
    <thead>
        <tr>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Alerts Tripped in Time Period</th>
            <th> </th>
        </tr>
    </thead>
    <tbody>
");
            EndContext();
#line 39 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
         foreach (Reports report in Model.PrevReports)
        {

#line default
#line hidden
            BeginContext(835, 30, true);
            WriteLiteral("        <tr>\r\n            <td>");
            EndContext();
            BeginContext(866, 16, false);
#line 42 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
           Write(report.StartDate);

#line default
#line hidden
            EndContext();
            BeginContext(882, 23, true);
            WriteLiteral("</td>\r\n            <td>");
            EndContext();
            BeginContext(906, 14, false);
#line 43 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
           Write(report.EndDate);

#line default
#line hidden
            EndContext();
            BeginContext(920, 23, true);
            WriteLiteral("</td>\r\n            <td>");
            EndContext();
            BeginContext(944, 25, false);
#line 44 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
           Write(report.AlertsInTimePeriod);

#line default
#line hidden
            EndContext();
            BeginContext(969, 57, true);
            WriteLiteral("</td>\r\n            <!--<td><button type=\"button\" onclick=");
            EndContext();
            BeginContext(1027, 30, false);
#line 45 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
                                             Write(Url.Action("Index", "Reports"));

#line default
#line hidden
            EndContext();
            BeginContext(1057, 95, true);
            WriteLiteral(">___</button></td>-->\r\n            <td><a href=\"/Reports/Export\">Export</a></td>\n        </tr>\n");
            EndContext();
#line 48 "C:\Users\david\Documents\GitHub\semester-group-assignment-group-6\Online Banking\asp-core-mvc\Views\Reports\Index.cshtml"
        }

#line default
#line hidden
            BeginContext(1162, 22, true);
            WriteLiteral("    </tbody>\n</table>\n");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<asp_core_mvc.ViewModels.ReportsModel> Html { get; private set; }
    }
}
#pragma warning restore 1591
