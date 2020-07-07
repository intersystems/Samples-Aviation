/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// Adds an action for <class>Aviation.EventCube</class> to display the full NTSB report for an
/// Aviation Event fact record.
Class Aviation.KPI.Actions Extends %DeepSee.KPI
{

/// This XData definition defines the KPI.
XData KPI [ XMLNamespace = "http://www.intersystems.com/deepsee/kpi" ]
{
<kpi xmlns="http://www.intersystems.com/deepsee/kpi" name="Aviation Actions">
<action name="GoToReport" displayName="Open NTSB report" />
</kpi>
}

/// This callback is invoked from a dashboard when an action defined by this dashboard is invoked.
ClassMethod %OnDashboardAction(pAction As %String, pContext As %ZEN.proxyObject) As %Status
{
	if (pAction="GoToReport") {
		set pContext.command = "newWindow:Aviation.UI.NTSBLink.zen?ID="_pContext.valueList
	}

	quit $$$OK
}

}

