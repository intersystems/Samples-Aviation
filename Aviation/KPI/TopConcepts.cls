/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
Class Aviation.KPI.TopConcepts Extends %iKnow.DeepSee.GenericKPI
{

///  Override this parameter and <parameter>IKMEASURENAME</parameter> to specify the iKnow
///  domain linked to a particular iKnow measure for the KPI's query to access.
Parameter IKCUBENAME As %String = "AviationEvents";

///  Override this parameter and <parameter>IKCUBENAME</parameter> to specify the iKnow
///  domain linked to a particular iKnow measure for the KPI's query to access.
Parameter IKMEASURENAME As %String = "Report";

///  This XData definition defines the KPI.
XData KPI [ XMLNamespace = "http://www.intersystems.com/deepsee/kpi" ]
{
<kpi name="AviationTopConcepts" displayName="AviationEvents > Top Concepts" >
<property name="resultNumber" disabled="true" />
<property name="entUniId" disabled="true" />
<property name="entity" />
<property name="frequency" />
<property name="spread" />
</kpi>
}

}

