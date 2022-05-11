Public Class _default
    Inherits System.Web.UI.Page

    Protected _cond_会社 As String
    Protected _cond_店舗 As Integer?
    Protected _cond_仕入先 As Short?
    Protected _cond_部門 As Short?
    Protected _cond_納品日_from As DateTime?
    Protected _cond_納品日_to As DateTime?

    Protected _cap_会社 As String
    Protected _cap_店舗 As String
    Protected _cap_部門 As String
    Protected _cap_仕入先 As String
    Protected _cap_納品日_fromTo As String

    Protected ReadOnly Property _screen_会社 As String
        Get
            Try
                Dim val As String = rbl_会社.SelectedValue

                If val = String.Empty Then
                    Return Nothing
                Else
                    Return val
                End If
            Catch
                Return Nothing
            End Try
        End Get
    End Property

    Protected ReadOnly Property _screen_店舗 As Integer?
        Get
            Try
                Dim val As Integer = Integer.Parse(ddl_店舗.SelectedValue)

                If val = 0 Then
                    Return Nothing
                Else
                    Return val
                End If
            Catch
                Return Nothing
            End Try
        End Get
    End Property

    Protected ReadOnly Property _screen_部門 As Short?
        Get
            Try
                Dim val As Short = Short.Parse(ddl_部門.SelectedValue)

                If val = 0 Then
                    Return Nothing
                Else
                    Return val
                End If
            Catch
                Return Nothing
            End Try
        End Get
    End Property

    Protected ReadOnly Property _screen_仕入先 As Short?
        Get
            Try
                Dim val As Short = Short.Parse(ddl_仕入先.SelectedValue)

                If val = 0 Then
                    Return Nothing
                Else
                    Return val
                End If
            Catch
                Return Nothing
            End Try
        End Get
    End Property

    Protected ReadOnly Property _screen_納品日_from As DateTime?
        Get
            Try
                Return DateTime.ParseExact(tbx_納品日_from.Text + " 00:00:00", "yyyy/MM/dd HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture)
            Catch
                Return Nothing
            End Try
        End Get
    End Property

    Protected ReadOnly Property _screen_納品日_to As DateTime?
        Get
            Try
                Return DateTime.ParseExact(tbx_納品日_to.Text + " 00:00:00", "yyyy/MM/dd HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture)
            Catch
                Return Nothing
            End Try
        End Get
    End Property

    Protected Overrides Sub OnPreInit(e As EventArgs)
        MyBase.OnPreInit(e)

        If IsPostBack Then
            If Me.Session(Const_App.WebSrvSession.Session_SessionId) Is Nothing Then
                Dim errPrms As Dictionary(Of String, String) = New Dictionary(Of String, String)(2)
                errPrms(Const_App.ErrorPaqe.Key_ErrorMsg) = Const_App.ErrorPaqe.ErrMsg1
                errPrms(Const_App.ErrorPaqe.Key_NavUrl) = Request.RawUrl

                Session(Const_App.UrlParam.Session_Param) = errPrms

                Response.Redirect("~/error1.aspx", True)
            End If
        Else
            Me.Session(Const_App.WebSrvSession.Session_SessionId) = Session.SessionID
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then
            Return
        End If

        initCtrl()
    End Sub

    Private Sub Page_LoadComplete(sender As Object, e As EventArgs) Handles Me.LoadComplete
        If Not ScriptManager1.IsInAsyncPostBack Then
            Return
        End If

        Select Case Request.Params("__EVENTARGUMENT")
            Case "tbx_店舗_Changed"
                ddl_店舗_SelectedIndexChanged(Nothing, Nothing)
                up_3.Update()
            Case "tbx_部門_Changed"
                ddl_部門_SelectedIndexChanged(Nothing, Nothing)
                up_3.Update()
        End Select
    End Sub

    ' ポストバック実行スクリプトを取得する。
    ' スクリプト側では、以下の置換を行う。
    '      {0}：UniqueID に相当する ID      サーバ側では、this.Request.Params("__EVENTTARGET") で取得される
    '      {1}：ポストバック引数            サーバ側では、this.Request.Params("__EVENTARGUMENT") で取得される
    Public Function GetPostBackScript() As String
        Dim script As String = Page.ClientScript.GetPostBackEventReference(btn_dummy, "{1}") + ";"
        script = script.Replace(btn_dummy.UniqueID, "{0}")

        Return script.Replace(Chr(34), "'"c)
    End Function

    Protected Sub initCtrl()
        lrl_capWnd.Text = SettingConfig.WindowCaption
        lrl_version.Text = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString()

        rbl_会社.SelectedValue = "10,31"
        rbl_会社_SelectedIndexChanged(Nothing, Nothing)

        tbx_納品日_from.Text = DateTime.Now.ToString("yyyy/MM/dd")
        tbx_納品日_to.Text = tbx_納品日_from.Text

        uc_ListPager_Item.Init_ListPager(New String() {rep_1.ID}, db_F_伝票明細.EmptyTable_01, SettingConfig.ListRowCount)

        If Request.Params.AllKeys.Contains(SettingConfig.PostParam_MenuUrl) Then
            lbtn_toMenu.Visible = True
            lbtn_toMenu.PostBackUrl = Request.Params(SettingConfig.PostParam_MenuUrl)
            hgc_col1.Attributes("style") = "width: 7em;"
        Else
            lbtn_toMenu.Visible = False
            hgc_col1.Attributes("style") = "width: 0;"
        End If
    End Sub

    Protected Sub selectData()
        lbl_会社.Text = _cap_会社
        lbl_店舗.Text = _cap_店舗
        lbl_部門.Text = _cap_部門
        lbl_仕入先.Text = _cap_仕入先
        lbl_納品日_fromTo.Text = _cap_納品日_fromTo

        uc_ListPager_Item.Init_ListPager(New String() {rep_1.ID}, db_F_伝票明細.Select_01(_cond_会社, _cond_店舗, _cond_部門, _cond_仕入先, _cond_納品日_from, _cond_納品日_to), SettingConfig.ListRowCount)
    End Sub

    Protected Sub rbl_会社_SelectedIndexChanged(sender As Object, e As EventArgs)
        ddl_店舗.DataSource = db_マスタ.Select_店舗_DdlSrc(_screen_会社)
        ddl_店舗.DataBind()
        tbx_店舗.Text = ddl_店舗.SelectedValue

        ddl_部門.DataSource = db_マスタ.Select_部門_DdlSrc(_screen_会社)
        ddl_部門.DataBind()
        tbx_部門.Text = ddl_部門.SelectedValue

        ddl_仕入先.DataSource = db_マスタ.Select_仕入先_DdlSrc(_screen_会社, _screen_店舗, _screen_部門)
        ddl_仕入先.DataBind()
        tbx_仕入先.Text = ddl_仕入先.SelectedValue
    End Sub

    Protected Sub ddl_店舗_SelectedIndexChanged(sender As Object, e As EventArgs)
        ddl_仕入先.DataSource = db_マスタ.Select_仕入先_DdlSrc(_screen_会社, _screen_店舗, _screen_部門)
        ddl_仕入先.DataBind()
        tbx_仕入先.Text = ddl_仕入先.SelectedValue
    End Sub

    Protected Sub ddl_部門_SelectedIndexChanged(sender As Object, e As EventArgs)
        ddl_仕入先.DataSource = db_マスタ.Select_仕入先_DdlSrc(_screen_会社, _screen_店舗, _screen_部門)
        ddl_仕入先.DataBind()
        tbx_仕入先.Text = ddl_仕入先.SelectedValue
    End Sub

    Protected Sub btn_Search_Click(sender As Object, e As EventArgs)
        _cond_会社 = _screen_会社
        _cap_会社 = rbl_会社.SelectedItem.Text

        _cond_店舗 = _screen_店舗
        _cap_店舗 = ddl_店舗.SelectedItem.Text

        _cond_部門 = _screen_部門
        _cap_部門 = ddl_部門.SelectedItem.Text

        _cond_仕入先 = _screen_仕入先
        _cap_仕入先 = ddl_仕入先.SelectedItem.Text

        _cap_納品日_fromTo = String.Empty
        Try
            _cond_納品日_from = _screen_納品日_from
            _cap_納品日_fromTo += tbx_納品日_from.Text
        Catch
            _cond_納品日_from = Nothing
        End Try
        _cap_納品日_fromTo += "～"
        Try
            _cond_納品日_to = _screen_納品日_to
            _cap_納品日_fromTo += tbx_納品日_to.Text
        Catch
            _cond_納品日_to = Nothing
        End Try

        selectData()
    End Sub

    Protected Sub rep_1_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If e.Item.ItemType <> ListItemType.Item AndAlso e.Item.ItemType <> ListItemType.AlternatingItem Then
            Return
        End If

        Dim p_仕入先 As Short = DirectCast(DataBinder.Eval(e.Item.DataItem, "仕入先ｺｰﾄﾞ"), Short),
            p_kaisya As String = DirectCast(DataBinder.Eval(e.Item.DataItem, "cond_kaisya"), String),
            p_kaiTenCd As Integer? = If(DataBinder.Eval(e.Item.DataItem, "cond_kaiTenCd") Is DBNull.Value, Nothing, DirectCast(DataBinder.Eval(e.Item.DataItem, "cond_kaiTenCd"), Integer?)),
            p_bumonCd As Short? = If(DataBinder.Eval(e.Item.DataItem, "cond_bumonCd") Is DBNull.Value, Nothing, DirectCast(DataBinder.Eval(e.Item.DataItem, "cond_bumonCd"), Short?)),
            p_nouDt_from As DateTime? = If(DataBinder.Eval(e.Item.DataItem, "cond_nouDt_from") Is DBNull.Value, Nothing, DirectCast(DataBinder.Eval(e.Item.DataItem, "cond_nouDt_from"), DateTime?)),
            p_nouDt_to As DateTime? = If(DataBinder.Eval(e.Item.DataItem, "cond_nouDt_to") Is DBNull.Value, Nothing, DirectCast(DataBinder.Eval(e.Item.DataItem, "cond_nouDt_to"), DateTime?))

        Dim rep As Repeater = DirectCast(e.Item.FindControl("rep_2"), Repeater)
        rep.DataSource = db_F_伝票明細.Select_02(p_kaisya, p_kaiTenCd, p_bumonCd, p_仕入先, p_nouDt_from, p_nouDt_to)
        rep.DataBind()

        If DirectCast(DataBinder.Eval(e.Item.DataItem, "合計"), Integer) > 0 Then
            DirectCast(e.Item.FindControl("tblRow_1"), HtmlTableRow).Style.Item("background-color") = "lightcoral"
        End If
    End Sub
End Class
