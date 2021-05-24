B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Public vuetify As VuetifyApp
	Public BANano As BANano
	
	Private appbar As VAppBar
	Private appburger As VAppBarNavIcon
	Private appcontainer As VContainer
	Private applogo As VAvatar
	Private appmain As VLabel
	Private apptitle As VAppBarTitle
	Private inspire As VApp
End Sub

Sub Init
	'initialize the app
	vuetify.Initialize(Me, Main.AppName)
	'load the base template
	BANano.LoadLayout(vuetify.Here, "bvad4baseline")
	'update the caption of the app navbar
	vuetify.SetData("apptitle", Main.AppTitle)
	
	vuetify.SetMounted(Me, "onmounted", Null)	
	'render the ux
	vuetify.Serve
End Sub

'when the instance is mounted
Sub onmounted
	Dim rsTables As BANanoMySQLE
	rsTables.Initialize("dbname", "", "", "")
	rsTables.GetTableNames
	rsTables.JSON = BANano.CallInlinePHPWait(rsTables.MethodName, rsTables.Build)
	rsTables.FromJSON
	Select Case rsTables.OK
	Case False
		Dim strError As String = rsTables.Error
		Log(strError)
		vuetify.ShowSwalError(strError)
		Return
	End Select
	Dim totTables As Int = rsTables.result.size
	vuetify.ShowSwalSuccess($"${totTables} table(s) have been found on your database."$)
	Log(rsTables.result)
End Sub

Private Sub appburger_ClickStop (e As BANanoEvent)
	
End Sub