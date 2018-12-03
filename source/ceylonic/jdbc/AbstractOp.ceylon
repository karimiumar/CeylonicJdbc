import java.sql {
    PreparedStatement,
    Timestamp
}
import java.util {
    JList = List,
    Date,
    Calendar
}
import ceylonic.jdbc.meta {
    ColumnValue,
    Column,
    Table,
    Index,
    Value
}
import java.math {
    BigDecimal
}
import java.time {
    LocalDate,
    ZoneId
}
import java.lang {
    overloaded,
    ObjectArray
}

shared abstract class AbstractOp<T>() of T given T satisfies AbstractOp<T> {

    shared formal String toSql();
    shared formal StringBuilder op();
    shared formal JList<Value> getValues();

    shared PreparedStatement fill(PreparedStatement ps){
        populate(ps, getValuesArray());
        return ps;
    }

    shared void clear(){
        op().clear();
        getValues().clear();
    }


    /**
     * Appends the column name suffixed by =? to a PreparedStatement object.
     * It also adds the column values passed to java.util.List<ColumnValue> list
     *
     * @param columnValues The ColumnValue objects
     * @return Returns the current object
     */
    shared overloaded T columnEq({ColumnValue* } columnValues){
        value len = columnValues.size;
        variable Integer cnt = 1;
        for(v in columnValues) {
            getValues().add(v);
            op().append(v.getColumn().columnName);
            op().append("=?");
            if(cnt++ < len){
                op().append(" AND ");
            }
        }
        return (this) of T;
    }

    /**
     * The NOT EQUAL operator
     * @param condition The condition to suffix with <> operator
     * @return Returns this object
     */
    shared T ne(Column condition) {
        op().append("<>");
        op().append(condition.columnName);
        return (this) of T;
    }

    /**
     * SQL NOT statement
     * @return Returns this object
     */
    shared T not() {
        op().append(" NOT ");
        return (this) of T;
    }

    /**
     * SQL IS statement
     * @return Returns this object
     */
    shared T is_() {
        op().append(" IS ");
        return (this) of T;
    }

    /**
     * The SQL NULL operator
     * @return Returns this object
     */
    shared T null(){
        op().append(" NULL");
        return (this) of T;
    }

    /**
     * SQL AND statement
     * @return Returns this object
     */
    shared overloaded T and() {
        op().append(" AND ");
        return (this) of T;
    }

    shared overloaded T and(Column column) {
        op().append(" AND ");
        op().append(column.columnName);
        return (this) of T;
    }


    /**
     * Marks the beginning of a complex statement
     *
     * @return Returns this object
     */
    shared T beginComplex() {
        op().append("(");
        return (this) of T;
    }

    /**
     * SQL OR statement
     * @return Returns this object
     */
    shared T or() {
        op().append(" OR ");
        return (this) of T;
    }

    /**
     * Ends a complex statement that was begun by <code>beginComplex()</code> method
     *
     * @return Returns this object
     */
    shared T endComplex() {
        op().append(")");
        return (this) of T;
    }

    /**
    * SQL greater than statement
    *
    * @param column The column to prefix with >. It should be followed by <code>populate()</code> method to fill
    * @return Returns this object
    */
    shared overloaded T gt(Column column) {
        op().append(column.columnName);
        op().append(">?");
        return (this) of T;
    }

    /**
     * SQL less than statement
     * @param column The column to prefix with <. It should be followed by <code>populate()</code> method to fill
     * @return Returns this object
     */
    shared overloaded T lt(Column column) {
        op().append(column.columnName);
        op().append("<?");
        return (this) of T;
    }

    /**
     * SQL greater or equal to statement
     *
     * @param column The column to prefix with >= It suffixes >=? to the PreparedStatement Object
     * @return Returns this object
     */
    shared overloaded T ge(Column column) {
        op().append(column.columnName);
        op().append(">=?");
        return (this) of T;
    }

    /**
     * SQL less or equal to statement. It suffixes <=? to the PreparedStatement Object
     *
     * @param column The column to prefix with <=.
     * @return Returns this object
     */
    shared overloaded T le(Column column) {
        op().append(column.columnName);
        op().append("<=?");
        return (this) of T;
    }

    /**
     * SQL UPPER clause
     *
     * @return Returns this object
     */
    shared T upper() {
        op().append(" UPPER ");
        return (this) of T;
    }

    /**
     * SQL HAVING clause
     * @return Returns this object
     */
    shared T having() {
        op().append(" HAVING ");
        return (this) of T;
    }

    /**
     * SQL FROM clause
     * @return Returns this object
     * @param table The table to use with FROM clause
     */
    shared overloaded default T from(Table table) {
        op().append(" FROM ");
        op().append(table.getTableName());
        return (this) of T;
    }

    /**
     * SQL FROM clause.
     * @return Returns this object
     * @param tables The tables to use with FROM clause
     */
    shared overloaded T from({Table*} tables) {
        value len = tables.size;
        variable Integer cnt = 1;
        op().append(" FROM(");
        for(table in tables){
            op().append(table.getTableName());
            if(cnt++ < len){
                op().append(",");
            }
        }
        op().append(")");
        return (this) of T;
    }

    /**
     * SQL WHERE clause.
     * @return Returns this object
     */
    shared overloaded T where() {
        op().append(" WHERE ");
        return (this) of T;
    }

    /**
     * SQL WHERE clause.
     * @return Returns this object
     */
    shared overloaded T where(SelectOp operation) {
        op().append(" WHERE (");
        op().append(operation.string);
        op().append(")");
        return (this) of T;
    }

    /**
     * SQL WHERE IN clause
     * @param column The column name
     * @param values The column populate to set
     * @return The current object
     */
    shared overloaded T where(Column column, {Value*} values) {
        value len = values.size;
        variable Integer cnt = 1;
        op().append(" WHERE ");
        op().append(column.columnName);
        op().append(" IN (");
        for(e in values) {
            op().append("?");
            if(cnt++ < len){
                op().append(",");
            }
            getValues().add(e);
        }
        op().append(")");

        return (this) of T;
    }

    /**
     * SQL WHERE clause
     * @param column The column to append with WHERE clause
     * @return Returns this object
     */
    shared overloaded T where(Column column) {
        op().append(" WHERE ");
        op().append(column.columnName);
        return (this) of T;
    }

    /**
     * SQL TABLE to be worked with
     * @param table The table name
     * @return Returns this object
     */
    shared overloaded default T table(Table table) {
        op().append(table.getTableName());
        return (this) of T;
    }

    /**
     * SQL YEAR() function
     * @param column The column to use with YEAR()
     * @return Returns this object
     */
    shared T year(Column column) {
        op().append(" YEAR(");
        op().append(column.columnName);
        op().append(")");
        return (this) of T;
    }

    /**
     * SQL DISTINCT clause
     * @return Returns this object
     */
    shared overloaded T distinct() {
        op().append("DISTINCT ");
        return (this) of T;
    }

    /**
     * SQL DISTINCT clause
     * @param column The column to use with DISTINCT operator
     * @return Returns this object
     */
    shared overloaded T distinct(Column column) {
        op().append("DISTINCT ");
        op().append(column.columnName);
        return (this) of T;
    }

    /**
     * SQL COUNT() function
     * @param column The column to use with count()
     * @return Returns this object
     */
    shared overloaded T count(Column column) {
        op().append("COUNT(");
        op().append(column.columnName);
        op().append(")");
        return (this) of T;
    }

    /**
     * SQL COUNT() function
     * @param op T type operation
     * @return Returns this object
     */
    shared overloaded T count(T operation) {
        op().append("COUNT(");
        op().append(operation.string);
        op().append(")");
        return (this) of T;
    }

    /**
     * SQL MAX() function
     * @param column The column to use with MAX()
     * @return Returns this object
     */
    shared T max(Column column) {
        op().append("MAX(");
        op().append(column.columnName);
        op().append(")");
        return (this) of T;
    }

    /**
     * SQL MIN() function
     * @param column The column to use with MIN()
     * @return Returns this object
     */
    shared T min(Column column) {
        op().append("MIN(");
        op().append(column.columnName);
        op().append(")");
        return (this) of T;
    }

    /**
     * SQL AVG() function
     * @param column The column to use with AVG()
     * @return Returns this object
     */
    shared T avg(Column column) {
        op().append("AVG(");
        op().append(column.columnName);
        op().append(")");
        return (this) of T;
    }

    /**
     * SQL SUM() function. 'SUM' function is appended around the column
     * @param column The column to sum
     * @return Returns this object
     */
    shared T sum(Column column) {
        op().append("SUM(");
        op().append(column.columnName);
        op().append(")");
        return (this) of T;
    }

    /**
     * The SQL EXISTS clause
     * @param op The SQL operation
     * @return The current object
     */
    shared T exists_(T operation) {
        op().append("EXISTS");
        op().append(" (");
        op().append(operation.string);
        op().append(" )");
        return (this) of T;
    }

    /**
     * SQL BETWEEN clause.
     *
     * @return Returns this object
     */
    shared overloaded T between({ColumnValue*} columnValues) {
        value len = columnValues.size;
        variable Integer cnt = 1;
        op().append(" BETWEEN ");
        for (e in columnValues) {
            op().append("?");
            if(cnt++ < len){
                op().append(" AND ");
            }
            getValues().add(e.getValue());
        }
        return (this) of T;
    }

    /**
     * SQL BETWEEN clause. 'BETWEEN' operator is appended around the SQL operation
     * @param op The SQL operation to wrap in 'BETWEEN' clause
     * @return Returns this object
     */
    shared overloaded T between(T operation) {
        op().append(" BETWEEN (");
        op().append(operation.string);
        op().append(")");
        return (this) of T;
    }

    /**
     * SQL LIKE clause. 'LIKE' operator is appended followed by ''pattern''.
     * @param pattern The String pattern to look for.
     * @return Returns this object
     */
    shared T like(String pattern) {
        op().append(" LIKE ");
        op().append("?");
        getValues().add(ColumnValue.setVal(pattern));
        return (this) of T;
    }

    /**
     * The SQL IN() function. The 'IN' function is appended followed by the SQL operation
     *
     * @param op The SQL operation to wrap in 'IN' function
     * @return Returns this object
     */
    shared T in_(T operation) {
        op().append(" IN (");
        op().append(operation.string);
        op().append(")");
        return (this) of T;
    }

    /**
     * MySQL LIMIT Function
     *
     * @param n The int value of limit
     * @return Returns this object
     */
    shared T limit(Integer n) {
        getValues().add(ColumnValue.setVal(n));
        op().append(" LIMIT ");
        op().append("?");
        return (this) of T;
    }

    /**
     * MySQL OffSet Function
     *
     * @param n The int value to pass in offset
     * @return Returns this object
     */
    shared T offset(Integer n) {
        getValues().add(ColumnValue.setVal(n));
        op().append(" OFFSET ");
        op().append("?");
        return (this) of T;
    }

    /**
     * SQL AS clause
     * @param alias The alias to use
     * @return Returns this object
     */
    shared T as(String aliasName) {
        op().append(" AS ");
        op().append(aliasName);
        op().append(" ");
        return (this) of T;
    }

    /**
     * SQL ORDER BY clause
     * @param column The column on which ORDER BY to apply
     * @return Returns this object
     */
    shared overloaded T orderBy(Column column) {
        op().append(" ORDER BY ");
        op().append(column.columnName);
        return (this) of T;
    }

    /**
     * SQL ORDER BY clause
     * @param column The column on which ORDER BY to apply
     * @return Returns this object
     */
    shared overloaded T orderBy(String column) {
        op().append(" ORDER BY ");
        op().append(column);
        return (this) of T;
    }

    /**
     * SQL ASC clause for ascending order
     * @return Returns this object
     */
    shared T asc() {
        op().append(" ASC ");
        return (this) of T;
    }

    /**
     * SQL DESC clause for descending order
     * @return Returns this object
     */
    shared T desc() {
        op().append(" DESC ");
        return (this) of T;
    }

    /**
     * SQL GREATER THAN clause.
     * @return Returns this object
     */
    shared overloaded T gt() {
        op().append(">");
        return (this) of T;
    }

    /**
     * SQL GREATER THAN clause.
     * @return Returns this object
     */
    shared overloaded T gt(Value val) {
        op().append(">");
        op().append("?");
        getValues().add(val);
        return (this) of T;
    }

    /**
     * SQL LESS THAN clause.
     * @return Returns this object
     */
    shared overloaded T lt() {
        op().append("<");
        return (this) of T;
    }

    /**
     * SQL LESS THAN clause.
     * @return Returns this object
     */
    shared overloaded T lt(Value val) {
        op().append("<");
        op().append("?");
        getValues().add(val);
        return (this) of T;
    }

    /**
     * SQL GREATER OR EQUAL clause.
     * @return Returns this object
     */
    shared overloaded T ge(){
        op().append(">=");
        return (this) of T;
    }

    /**
     * SQL GREATER OR EQUAL TO clause.
     * @return Returns this object
     */
    shared overloaded T ge(ColumnValue val) {
        op().append(val.getColumn().columnName);
        op().append(">=");
        op().append("?");
        getValues().add(val.getValue());
        return (this) of T;
    }

    /**
     * SQL LESS OR EQUAL TO clause.
     * @return Returns this object
     */
    shared overloaded T le(ColumnValue val) {
        op().append(val.getColumn().columnName);
        op().append("<=");
        op().append("?");
        getValues().add(val.getValue());
        return (this) of T;
    }

    /**
     * SQL LESS OR EQUAL clause.
     * @return Returns this object
     */
    shared overloaded T le() {
        op().append("<=");
        return (this) of T;
    }

    /**
     * SQL = operator. An '=' symbol is appended by this method followed by the 'condition'.
     * @param condition The condition to append with = operator
     * @return Returns this object
     */
    shared overloaded T eq(Column condition) {
        op().append("=");
        op().append(condition.columnName);
        return (this) of T;
    }

    /**
     * SQL = operator. An '=' symbol is appended by this method.<br>
     *
     * @return Returns this object
     */
    shared overloaded T eq() {
        op().append("=");
        return (this) of T;
    }

    /**
     * SQL GROUP BY clause. 'GROUP BY' operator is appended followed by columns to group.
     * @param columns The columns to group together
     * @return Returns this object
     *
     */
    shared T groupBy({Column*} columns){
        value len = columns.size;
        variable Integer cnt = 1;
        op().append(" GROUP BY ");
        for(column in columns) {
            op().append(column.columnName);
            if(cnt++ < len){
                op().append(",");
            }
        }
        return (this) of T;
    }

    /**
     * Use this method when grouping columns in
     * conjunction with count(), avg(), min(), max() method
     * @param columns The columns to use
     * @return Returns this object
     */
    shared T with({Column*} columns) {
        for (column in columns){
            op().append(",");
            op().append(column.columnName);
        }
        return (this) of T;
    }

    /**
     * MySQL USING operator. 'USING' operator is appended around the 'column'
     * @param column The column
     * @return Returns this object
     */
    shared T using(Column column) {
        op().append(" USING(");
        op().append(column.columnName);
        op().append(")");
        return (this) of T;
    }

    /**
     * MySQL MINUS operator
     * @return Returns this object
     */
    shared T minus(){
        op().append(" MINUS ");
        return (this) of T;
    }

    /**
     * SQL INNER JOIN clause
     * @return Returns this object
     */
    shared T innerJoin(){
        op().append(" INNER JOIN ");
        return (this) of T;
    }

    /**
     * SQL OUTER JOIN clause
     * @return Returns this object
     */
    shared T outerJoin(){
        op().append(" OUTER JOIN ");
        return (this) of T;
    }

    /**
     *
     * SQL JOIN operation
     * @return Returns this object
     */
    shared T join() {
        op().append(" JOIN ");
        return (this) of T;
    }

    /**
     * SQL LEFT JOIN clause
     * @return Returns this object
     */
    shared T leftJoin() {
        op().append(" LEFT JOIN ");
        return (this) of T;
    }

    /**
     * SQL RIGHT JOIN clause
     * @return Returns this object
     */
    shared T rightJoin() {
        op().append(" RIGHT JOIN");
        return (this) of T;
    }

    /**
     * SQL UNION clause
     * @return Returns this object
     */
    shared T union() {
        op().append(" UNION ");
        return (this) of T;
    }

    /**
     * SQL ON clause used in conjunction with JOIN
     * @return Returns this object
     */
    shared T on() {
        op().append(" ON ");
        return (this) of T;
    }

    /**
     * SQL ANY clause
     * @return Returns this object
     */
    shared T any() {
        op().append(" ANY ");
        return (this) of T;
    }

    /**
     * SQL SOME clause. It's an alias for ANY
     * @return Returns this object
     */
    shared T some(){
        op().append(" SOME ");
        return (this) of T;
    }

    /**
     * SQL SUBSTRING function
     *
     * @return Returns this object
     */
    shared T substring(){
        op().append(" SUBSTRING ");
        return (this) of T;
    }

    /**
     * SQL charindex() function
     * @return Returns this object
     */
    shared T charindex(){
        op().append(" CHARINDEX ");
        return (this) of T;
    }

    /**
     * SQL SELECT clause
     * @return Returns this object
     */
    shared overloaded T select() {
        op().append("SELECT ");
        return (this) of T;
    }

    /**
     * SQL SELECT clause
     * @return Returns this object
     */
    shared overloaded T select({Column*} columns) {
        op().append("SELECT ");
        value len = columns.size;
        variable Integer cnt = 1;
        for(column in columns) {
            op().append(column.columnName);
            if(cnt++ < len){
                op().append(",");
            }
        }
        return (this) of T;
    }

    /**
     * SQL WITH INDEX clause
     * @param index The index name
     * @return Returns this object
     */
    shared T withIndex(Index index) {
        op().append("WITH(");
        op().append("INDEX(");
        op().append(index.index);
        op().append("))");
        return (this) of T;
    }

    shared StringBuilder openBraces() => op().append("(");

    shared StringBuilder closeBraces() => op().append(")");

    {Value*} getValuesArray()  {
        JList<Value> objects = getValues();
        ObjectArray<Value> values = getValues().toArray();
        variable Integer idx = 0;
        for(o in objects){
            values.set(idx++, o);
        }
        variable {Value *} vals = values.iterable.coalesced;
        return vals;
    }

    /*{ColumnValue*} getValuesArray(){
        JList<ColumnValue> objects = getValues();
        ObjectArray<ColumnValue> columnValues = ObjectArray<ColumnValue>(getValues().size());
        variable Integer idx = 0;
        for(o in objects){
            columnValues.set(idx++, o.getValue());
        }
        variable {ColumnValue *} vals = columnValues.iterable.coalesced;
        return vals;
    }*/

    /**
     * Converts the incoming populate to appropriate type in conjunction with PreparedStatement object.
     * These populate will be then be persisted in database
     *
     * @param ps The PreparedStatement object to use
     * @param params The value parameters to use
     * @throws SQLException The SQLException thrown by this method
     */
    void populate(PreparedStatement ps, {Value*} params) {
        import java.sql {
            SqlDate=Date
        }

        for (i->param in params.indexed) {
            variable Integer paramIndex = i + 1;
            value paramValue = param;
            if (!paramValue exists) {
                ps.setObject(paramIndex, null);
            } else if (is Boolean paramValue) {
                ps.setBoolean(paramIndex, paramValue);
            } else if (is Byte paramValue) {
                ps.setByte(paramIndex, paramValue);
            } else if (is Integer paramValue) {
                ps.setInt(paramIndex, paramValue);
            } else if (is Float paramValue) {
                ps.setFloat(paramIndex, paramValue);
            } else if (is String paramValue) {
                ps.setString(paramIndex, paramValue);
            } else if (is Date paramValue) {
                Timestamp ts = Timestamp(paramValue.time);
                ps.setTimestamp(paramIndex, Timestamp(ts.time));
            } else if (is Calendar paramValue) {
                ps.setDate(paramIndex, SqlDate(paramValue.timeInMillis));
            } else if (is BigDecimal paramValue) {
                ps.setBigDecimal(paramIndex, paramValue);
            } else if (is LocalDate paramValue) {
                LocalDate ld = paramValue;
                Date date = Date.from(ld.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
                ps.setDate(paramIndex, SqlDate(date.time));
            } else {
                throw Exception("Unknown type of the param is found. [paramIndex:``paramIndex``]");
            }
        }
    }

}