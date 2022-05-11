Public Class Const_App

    Public Class WebSrvSession
        Public Const Session_SessionId As String = "Const_App_Session_SessionId"
    End Class

    Public Class UrlParam
        Enum VisitPage
            VisitNew
            VisitRelative
            VisitBack
        End Enum

        Public Const Session_VisitPage As String = "Const_App_Session_VisitPage"
        Public Const Session_UrlCalled As String = "Const_App_Session_UrlCalled"

        Public Shared Function GetVisitPage(val As Object) As VisitPage
            If val Is Nothing Then
                Return VisitPage.VisitNew
            End If

            Return DirectCast(val, VisitPage)
        End Function

        Public Const Session_Param As String = "Const_App_Session_Param"
    End Class

    Public Class PopUp
        Public Const Default_Width_PopUp As Integer = 350
        Public Const Default_Width_Msg As Integer = 280
        Public Const Default_TextAlign_Msg As String = "left"

        Public Const Layout_Message As String = "<table style=""table-layout: fixed; width: 100%;"">" _
                + "<colgroup><col /><col style=""width: {0:D}px;"" /><col /></colgroup>" _
                + "<tr style=""height: 10px;""><td></td></tr>" _
                + "<tr><td>&nbsp;</td><td style=""text-align: {1}; overflow-wrap: break-word;"">{2}</td><td>&nbsp;</td></tr>" _
                + "</table>"
    End Class

    Public Class ErrorPaqe
        Public Const Key_ErrorMsg As String = "ErrorMsg"
        Public Const Key_NavUrl As String = "NavUrl"

        Public Const ErrMsg1 As String = "Web サーバーで、セッション タイムアウトが発生しました。"
    End Class

End Class
