Imports System.Data
Imports System.Data.SqlClient

Public Class db_マスタ
	Public Shared Function Select_店舗_DdlSrc(kaisya As String) As DataTable
		Dim sb As StringBuilder = New StringBuilder(1000)
		sb.AppendLine("SELECT [会社店ｺｰﾄﾞ], [店舗名]")
		sb.AppendLine("FROM [M_店舗]")

		If kaisya Is Nothing Then
			sb.AppendLine("WHERE 0 = 1")
		Else
			sb.AppendLine("WHERE [会社ｺｰﾄﾞ] IN (" + kaisya + ")")
		End If

		sb.AppendLine("ORDER BY [表示順];")

		Dim cn As SqlConnection = New SqlConnection(SettingConfig.ConnectingString)
		Dim cmd As SqlCommand = New SqlCommand(sb.ToString(), cn)

		Dim adp As SqlDataAdapter = New SqlDataAdapter(cmd)
		Dim tbl As DataTable = New DataTable()
		adp.Fill(tbl)

		adp.Dispose()
		cmd.Dispose()
		cn.Dispose()

		Dim row As DataRow = tbl.NewRow()
		row(0) = 0
		row(1) = String.Empty
		tbl.Rows.InsertAt(row, 0)

		Return tbl
	End Function

	Public Shared Function Select_部門_DdlSrc(kaisya As String) As DataTable
		Dim sb As StringBuilder = New StringBuilder(1000)
		sb.AppendLine("SELECT [部門ｺｰﾄﾞ], [部門名]")
		sb.AppendLine("FROM [M_部門]")

		If kaisya Is Nothing Then
			sb.AppendLine("WHERE 0 = 1")
		Else
			sb.AppendLine("WHERE [会社ｺｰﾄﾞ] = " + kaisya.Split(","c)(0))
		End If

		sb.AppendLine("ORDER BY [部門ｺｰﾄﾞ];")

		Dim cn As SqlConnection = New SqlConnection(SettingConfig.ConnectingString)
		Dim cmd As SqlCommand = New SqlCommand(sb.ToString(), cn)

		Dim adp As SqlDataAdapter = New SqlDataAdapter(cmd)
		Dim tbl As DataTable = New DataTable()
		adp.Fill(tbl)

		adp.Dispose()
		cmd.Dispose()
		cn.Dispose()

		Dim row As DataRow = tbl.NewRow()
		row(0) = "0"
		row(1) = String.Empty
		tbl.Rows.InsertAt(row, 0)

		Return tbl
	End Function

	Public Shared Function Select_仕入先_DdlSrc(kaisya As String, kaiTen As Integer?, bumon As Short?) As DataTable
		Dim sb As StringBuilder = New StringBuilder(1000)

		sb.AppendLine("WITH")
		sb.AppendLine(" t2 AS (")
		sb.AppendLine("  SELECT DISTINCT a.[締仕入先ｺｰﾄﾞ]")
		sb.AppendLine("  FROM [M_仕入先別締] a")
		sb.AppendLine("  INNER JOIN [M_店舗] b")
		sb.AppendLine("  ON a.[締会社店ｺｰﾄﾞ] = b.[会社店ｺｰﾄﾞ]")
		sb.AppendLine("  WHERE b.[会社ｺｰﾄﾞ] = " + kaisya.Split(","c)(0))

		If kaiTen IsNot Nothing Then
			sb.AppendLine("   AND a.[締会社店ｺｰﾄﾞ] = " + kaiTen.Value.ToString("d"))
		End If
		If bumon IsNot Nothing Then
			sb.AppendLine("   AND a.[締部門ｺｰﾄﾞ] = " + bumon.Value.ToString("d"))
		End If

		sb.AppendLine(" )")
		sb.AppendLine("SELECT [仕入先ｺｰﾄﾞ], ('(' + FORMAT([仕入先ｺｰﾄﾞ], '0') + ') ' + [仕入先名]) AS [仕入先名]")
		sb.AppendLine("FROM [M_仕入先] t1")
		sb.AppendLine("INNER JOIN t2")
		sb.AppendLine("ON t1.[仕入先ｺｰﾄﾞ] = t2.[締仕入先ｺｰﾄﾞ]")
		sb.AppendLine("ORDER BY [仕入先ｺｰﾄﾞ];")

		Dim cn As SqlConnection = New SqlConnection(SettingConfig.ConnectingString)
		Dim cmd As SqlCommand = New SqlCommand(sb.ToString(), cn)

		Dim adp As SqlDataAdapter = New SqlDataAdapter(cmd)
		Dim tbl As DataTable = New DataTable()
		adp.Fill(tbl)

		adp.Dispose()
		cmd.Dispose()
		cn.Dispose()

		Dim row As DataRow = tbl.NewRow()
		row(0) = "0"
		row(1) = String.Empty
		tbl.Rows.InsertAt(row, 0)

		Return tbl
	End Function
End Class
