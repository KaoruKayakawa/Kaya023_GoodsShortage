Imports System.Data
Imports System.Data.SqlClient

Public Class db_F_伝票明細

    Public Shared Function Select_01(kaisya As String, kaiTenCd As Integer?, bumonCd As Short?, siireCd As Short?, nouDt_from As DateTime?, nouDt_to As DateTime?) As DataTable
        Dim sb As StringBuilder = New StringBuilder(1000)
        sb.AppendLine("WITH")
        sb.AppendLine(" t0 AS (")
        sb.AppendLine("  SELECT [会社店ｺｰﾄﾞ]")
        sb.AppendLine("  FROM [M_店舗]")
        sb.AppendLine("  WHERE [会社ｺｰﾄﾞ] IN (" + kaisya + ")")
        sb.AppendLine("   AND ([会社店ｺｰﾄﾞ] = @kaiTenCd OR @kaiTenCd IS NULL)")
        sb.AppendLine(" ),")
        sb.AppendLine(" t1 AS (")
        sb.AppendLine("  SELECT")
        sb.AppendLine("   a.[仕入先ｺｰﾄﾞ],")
        sb.AppendLine("   a.[発注ﾊﾞﾗ数],")
        sb.AppendLine("   a.[納品ﾊﾞﾗ数]")
        sb.AppendLine("  FROM [F_伝票明細] a")
        sb.AppendLine("  INNER JOIN t0")
        sb.AppendLine("  ON a.[会社店ｺｰﾄﾞ] = t0.[会社店ｺｰﾄﾞ]")
        sb.AppendLine("  WHERE (a.[部門ｺｰﾄﾞ] = @bumonCd OR @bumonCd IS NULL)")
        sb.AppendLine("   AND (a.[仕入先ｺｰﾄﾞ] = @siireCd OR @siireCd IS NULL)")
        sb.AppendLine("   AND (a.[納品日] >= @nouDt_from OR @nouDt_from IS NULL)")
        sb.AppendLine("   AND (a.[納品日] <= @nouDt_to OR @nouDt_to IS NULL)")
        sb.AppendLine(" ),")
        sb.AppendLine(" t2 AS (")
        sb.AppendLine("  SELECT")
        sb.AppendLine("   [仕入先ｺｰﾄﾞ],")
        sb.AppendLine("   COUNT(*) AS [発注点数]")
        sb.AppendLine("  FROM t1")
        sb.AppendLine("  GROUP BY [仕入先ｺｰﾄﾞ]")
        sb.AppendLine(" ),")
        sb.AppendLine(" t3 AS (")
        sb.AppendLine("  SELECT")
        sb.AppendLine("   [仕入先ｺｰﾄﾞ],")
        sb.AppendLine("   COUNT(*) AS [欠品点数]")
        sb.AppendLine("  FROM t1")
        sb.AppendLine("  WHERE [納品ﾊﾞﾗ数] = 0")
        sb.AppendLine("  GROUP BY [仕入先ｺｰﾄﾞ]")
        sb.AppendLine(" ),")
        sb.AppendLine(" t4 AS (")
        sb.AppendLine("  SELECT")
        sb.AppendLine("   [仕入先ｺｰﾄﾞ],")
        sb.AppendLine("   COUNT(*) AS [変更点数]")
        sb.AppendLine("  FROM t1")
        sb.AppendLine("  WHERE [納品ﾊﾞﾗ数] <> 0")
        sb.AppendLine("   AND [発注ﾊﾞﾗ数] <> [納品ﾊﾞﾗ数]")
        sb.AppendLine("  GROUP BY [仕入先ｺｰﾄﾞ]")
        sb.AppendLine(" ),")
        sb.AppendLine(" t5 AS (")
        sb.AppendLine("  SELECT")
        sb.AppendLine("   t2.[仕入先ｺｰﾄﾞ],")
        sb.AppendLine("   t2.[発注点数],")
        sb.AppendLine("   ISNULL(t3.[欠品点数], 0) AS [欠品点数],")
        sb.AppendLine("   ISNULL(t4.[変更点数], 0) AS [変更点数]")
        sb.AppendLine("  FROM t2")
        sb.AppendLine("  LEFT OUTER JOIN t3")
        sb.AppendLine("  ON t2.[仕入先ｺｰﾄﾞ] = t3.[仕入先ｺｰﾄﾞ]")
        sb.AppendLine("  LEFT OUTER JOIN t4")
        sb.AppendLine("  ON t2.[仕入先ｺｰﾄﾞ] = t4.[仕入先ｺｰﾄﾞ]")
        sb.AppendLine(" )")
        sb.AppendLine("SELECT")
        sb.AppendLine(" t5.[仕入先ｺｰﾄﾞ],")
        sb.AppendLine(" t6.[仕入先名],")
        sb.AppendLine(" t5.[発注点数],")
        sb.AppendLine(" t5.[欠品点数],")
        sb.AppendLine(" t5.[変更点数],")
        sb.AppendLine(" t5.[欠品点数] + t5.[変更点数] AS [合計],")
        sb.AppendLine(" CAST(t5.[欠品点数] * 100.00 / t5.[発注点数] AS decimal(5, 2)) AS [欠品率],")
        sb.AppendLine(" CAST(t5.[変更点数] * 100.00 / t5.[発注点数] AS decimal(5, 2)) AS [変更率],")
        sb.AppendLine(" CAST((t5.[欠品点数] + t5.[変更点数]) * 100.00 / t5.[発注点数] AS decimal(5, 2)) AS [率合計],")
        sb.AppendLine(" CAST('" + kaisya + "' AS varchar(100)) AS cond_kaisya,")
        sb.AppendLine(" @kaiTenCd AS cond_kaiTenCd,")
        sb.AppendLine(" @bumonCd AS cond_bumonCd,")
        sb.AppendLine(" @nouDt_from AS cond_nouDt_from,")
        sb.AppendLine(" @nouDt_to AS cond_nouDt_to")
        sb.AppendLine("FROM t5")
        sb.AppendLine("INNER JOIN [M_仕入先] t6")
        sb.AppendLine("ON t5.[仕入先ｺｰﾄﾞ] = t6.[仕入先ｺｰﾄﾞ]")
        sb.AppendLine("ORDER BY t5.[仕入先ｺｰﾄﾞ];")

        Dim cn As SqlConnection = New SqlConnection(SettingConfig.ConnectingString)

        Dim cmd As SqlCommand = New SqlCommand(sb.ToString(), cn)
        Dim prm As SqlParameter
        prm = cmd.Parameters.Add(New SqlParameter("@kaiTenCd", SqlDbType.Int))
        If kaiTenCd Is Nothing Then
            prm.Value = DBNull.Value
        Else
            prm.Value = kaiTenCd.Value
        End If
        prm = cmd.Parameters.Add(New SqlParameter("@bumonCd", SqlDbType.SmallInt))
        If bumonCd Is Nothing Then
            prm.Value = DBNull.Value
        Else
            prm.Value = bumonCd.Value
        End If
        prm = cmd.Parameters.Add(New SqlParameter("@siireCd", SqlDbType.SmallInt))
        If siireCd Is Nothing Then
            prm.Value = DBNull.Value
        Else
            prm.Value = siireCd.Value
        End If
        prm = cmd.Parameters.Add(New SqlParameter("@nouDt_from", SqlDbType.DateTime))
        If nouDt_from Is Nothing Then
            prm.Value = DBNull.Value
        Else
            prm.Value = nouDt_from.Value
        End If
        prm = cmd.Parameters.Add(New SqlParameter("@nouDt_to", SqlDbType.DateTime))
        If nouDt_to Is Nothing Then
            prm.Value = DBNull.Value
        Else
            prm.Value = nouDt_to.Value
        End If

        Dim adp As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim tbl As DataTable = New DataTable()
        adp.Fill(tbl)

        adp.Dispose()
        cmd.Dispose()
        cn.Dispose()

        Return tbl
    End Function

    Public Shared ReadOnly Property EmptyTable_01 As DataTable
        Get
            Dim tbl As DataTable = New DataTable("EmptyTable_01")

            tbl.Columns.Add("[会社店ｺｰﾄﾞ]", System.Type.GetType("System.Int32"))
            tbl.Columns.Add("[店舗名]", System.Type.GetType("System.String"))
            tbl.Columns.Add("[仕入先ｺｰﾄﾞ]", System.Type.GetType("System.Int16"))
            tbl.Columns.Add("[仕入先名]", System.Type.GetType("System.String"))
            tbl.Columns.Add("[発注点数]", System.Type.GetType("System.Int32"))
            tbl.Columns.Add("[欠品点数]", System.Type.GetType("System.Int32"))
            tbl.Columns.Add("[変更点数]", System.Type.GetType("System.Int32"))
            tbl.Columns.Add("[合計]", System.Type.GetType("System.Int32"))
            tbl.Columns.Add("[欠品率]", System.Type.GetType("System.Decimal"))
            tbl.Columns.Add("[変更率]", System.Type.GetType("System.Decimal"))
            tbl.Columns.Add("[率合計]", System.Type.GetType("System.Decimal"))

            Return tbl
        End Get
    End Property

    Public Shared Function Select_02(kaisya As String, kaiTenCd As Integer?, bumonCd As Short?, siireCd As Short, nouDt_from As DateTime?, nouDt_to As DateTime?) As DataTable
        Dim sb As StringBuilder = New StringBuilder(1000)
        sb.AppendLine("WITH")
        sb.AppendLine(" t0 AS (")
        sb.AppendLine("  SELECT [会社店ｺｰﾄﾞ]")
        sb.AppendLine("  FROM [M_店舗]")
        sb.AppendLine("  WHERE [会社ｺｰﾄﾞ] IN (" + kaisya + ")")
        sb.AppendLine("   AND ([会社店ｺｰﾄﾞ] = @kaiTenCd OR @kaiTenCd IS NULL)")
        sb.AppendLine(" ),")
        sb.AppendLine(" t1 AS (")
        sb.AppendLine("  SELECT")
        sb.AppendLine("   a.[会社店ｺｰﾄﾞ],")
        sb.AppendLine("   a.[部門ｺｰﾄﾞ],")
        sb.AppendLine("   a.[伝票番号],")
        sb.AppendLine("   a.[行番号],")
        sb.AppendLine("   a.[JANｺｰﾄﾞ],")
        sb.AppendLine("   a.[商品名],")
        sb.AppendLine("   a.[発注日],")
        sb.AppendLine("   a.[発注ﾊﾞﾗ数],")
        sb.AppendLine("   a.[納品ﾊﾞﾗ数]")
        sb.AppendLine("  FROM [F_伝票明細] a")
        sb.AppendLine("  INNER JOIN t0")
        sb.AppendLine("  ON a.[会社店ｺｰﾄﾞ] = t0.[会社店ｺｰﾄﾞ]")
        sb.AppendLine("  WHERE (a.[部門ｺｰﾄﾞ] = @bumonCd OR @bumonCd IS NULL)")
        sb.AppendLine("   AND a.[仕入先ｺｰﾄﾞ] = @siireCd")
        sb.AppendLine("   AND (a.[納品日] >= @nouDt_from OR @nouDt_from IS NULL)")
        sb.AppendLine("   AND (a.[納品日] <= @nouDt_to OR @nouDt_to IS NULL)")
        sb.AppendLine("   AND a.[発注ﾊﾞﾗ数] <> a.[納品ﾊﾞﾗ数]")
        sb.AppendLine(" ),")
        sb.AppendLine(" t2 AS (")
        sb.AppendLine("  SELECT")
        sb.AppendLine("   CAST('欠' AS nchar(1)) AS [区分], *")
        sb.AppendLine("  FROM t1")
        sb.AppendLine("  WHERE [納品ﾊﾞﾗ数] = 0")
        sb.AppendLine("  UNION")
        sb.AppendLine("  SELECT")
        sb.AppendLine("   CAST('変' AS nchar(1)) AS [区分], *")
        sb.AppendLine("  FROM t1")
        sb.AppendLine("  WHERE [納品ﾊﾞﾗ数] <> 0")
        sb.AppendLine(" )")
        sb.AppendLine("SELECT")
        sb.AppendLine(" t2.*,")
        sb.AppendLine(" t3.[店舗名]")
        sb.AppendLine("FROM t2")
        sb.AppendLine("INNER JOIN [M_店舗] t3")
        sb.AppendLine("ON t2.[会社店ｺｰﾄﾞ] = t3.[会社店ｺｰﾄﾞ]")
        sb.AppendLine("ORDER BY t2.[会社店ｺｰﾄﾞ], t2.[JANｺｰﾄﾞ],  t2.[部門ｺｰﾄﾞ], t2.[発注日], t2.[伝票番号], t2.[行番号];")

        Dim cn As SqlConnection = New SqlConnection(SettingConfig.ConnectingString)

        Dim cmd As SqlCommand = New SqlCommand(sb.ToString(), cn)
        Dim prm As SqlParameter
        prm = cmd.Parameters.Add(New SqlParameter("@kaiTenCd", SqlDbType.Int))
        If kaiTenCd Is Nothing Then
            prm.Value = DBNull.Value
        Else
            prm.Value = kaiTenCd.Value
        End If
        prm = cmd.Parameters.Add(New SqlParameter("@bumonCd", SqlDbType.SmallInt))
        If bumonCd Is Nothing Then
            prm.Value = DBNull.Value
        Else
            prm.Value = bumonCd.Value
        End If
        prm = cmd.Parameters.Add(New SqlParameter("@siireCd", SqlDbType.SmallInt))
        prm.Value = siireCd
        prm = cmd.Parameters.Add(New SqlParameter("@nouDt_from", SqlDbType.DateTime))
        If nouDt_from Is Nothing Then
            prm.Value = DBNull.Value
        Else
            prm.Value = nouDt_from.Value
        End If
        prm = cmd.Parameters.Add(New SqlParameter("@nouDt_to", SqlDbType.DateTime))
        If nouDt_to Is Nothing Then
            prm.Value = DBNull.Value
        Else
            prm.Value = nouDt_to.Value
        End If

        Dim adp As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim tbl As DataTable = New DataTable()
        adp.Fill(tbl)

        adp.Dispose()
        cmd.Dispose()
        cn.Dispose()

        Return tbl

    End Function
End Class
