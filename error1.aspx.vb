Public Class error1
	Inherits System.Web.UI.Page

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If TypeOf Session(Const_App.UrlParam.Session_Param) Is Dictionary(Of String, String) Then
			Dim errPrms As Dictionary(Of String, String) = DirectCast(Session(Const_App.UrlParam.Session_Param), Dictionary(Of String, String))

			If errPrms.ContainsKey(Const_App.ErrorPaqe.Key_ErrorMsg) Then
				lbl_errMsg.Text = errPrms(Const_App.ErrorPaqe.Key_ErrorMsg)
			End If
			If errPrms.ContainsKey(Const_App.ErrorPaqe.Key_NavUrl) Then
				hlk_toPage.NavigateUrl = errPrms(Const_App.ErrorPaqe.Key_NavUrl)
			End If
		End If

		mv1.ActiveViewIndex = If(String.IsNullOrEmpty(lbl_errMsg.Text), 1, 0)
		mv2.ActiveViewIndex = If(String.IsNullOrEmpty(hlk_toPage.NavigateUrl), 1, 0)

		Session(Const_App.UrlParam.Session_Param) = Nothing
	End Sub
End Class
