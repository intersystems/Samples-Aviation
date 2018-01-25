/// This hidden class helps importing/exporting the Aviation data globals as part of building
/// the samples namespace.
Class Aviation.DataUtils Extends Aviation.Utils [ Hidden ]
{

/// Import Aviation data globals from xml file
ClassMethod Import(path = "") As %Status [ Internal ]
{
	set path = $s($g(path)="":^Sources_"databases/samples/gbl/aviation.xml", 1:path)
	kill ^Aviation.AircraftD
	kill ^Aviation.AircraftI
	kill ^Aviation.CrewD
	kill ^Aviation.CrewI
	kill ^Aviation.Countries
	kill ^Aviation.EventD
	kill ^Aviation.EventI
	kill ^Aviation.EventS
	kill ^Aviation.States
	quit $system.OBJ.Load(path)
}

/// Export aviation data globals
ClassMethod Export(pPath = "") As %Status [ Internal ]
{
	set globals("^Aviation.AircraftD.GBL") = ""
	set globals("^Aviation.AircraftI.GBL") = ""
	set globals("^Aviation.CrewD.GBL") = ""
	set globals("^Aviation.CrewI.GBL") = ""
	set globals("^Aviation.Countries.GBL") = ""
	set globals("^Aviation.EventD.GBL") = ""
	set globals("^Aviation.EventI.GBL") = ""
	set globals("^Aviation.EventS.GBL") = ""
	set globals("^Aviation.States.GBL") = ""
	quit $system.OBJ.Export(.globals, $s($g(pPath)'="":pPath, 1:^Sources_"databases/samples/gbl/aviation.xml"))
}

}

