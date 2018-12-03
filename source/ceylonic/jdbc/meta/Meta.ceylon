import java.util {
    Date,
    Calendar
}
import java.sql {
    Timestamp
}
import java.math {
    BigDecimal,
    BigInteger
}
import java.time {
    LocalDate,
    LocalDateTime,
    LocalTime
}
import java.lang {
    overloaded
}

shared class Column {

    shared static Column as(String columnName, String aliasName){
        return Column(aliasName +"." + columnName);
    }

    shared static Column column(String columnName) {
        //return Column<out T>(columnName);
        return Column(columnName);
    }

    shared String columnName;

    shared new(String columnName) {
        this.columnName = columnName;
    }

    string => columnName;
}

shared alias Value => Anything;

shared class ColumnValue {

    /*static Boolean isValid<Val>(Val val) given Val of
            Integer|Float|String|Character|LocalDate|LocalDateTime|LocalTime|Calendar|Byte|Boolean|BigInteger|BigDecimal|Date|Null {
        variable Boolean result = false;
        if(is Integer val) {
           result = true;
        }
        else if(is Float val) {
            result = true;
        }
        else if(is String val) {
            result = true;
        }
        else if(is Character val) {
            result = true;
        }
        else if(is Date val) {
            result = true;
        }
        else if(is Calendar val) {
            result = true;
        }
        else if(is Boolean val) {
            result = true;
        }
        else if(is BigDecimal val) {
            result = true;
        }
        else if(is BigInteger val) {
            result = true;
        }
        else if(is LocalDate val) {
            result = true;
        }
        else if(is LocalDateTime val) {
            result = true;
        }
        else if(is LocalTime val) {
            result = true;
        }
        return result;
    }*/

    shared overloaded static ColumnValue set<Val>(Column column, Val val)
            given Val of
                    Integer|Float|String|Character|LocalDate|LocalDateTime|LocalTime|Calendar|Byte|Boolean|BigInteger|BigDecimal|Date|Null
    {
        return ColumnValue(column,val);
    }

    shared overloaded static ColumnValue setVal<Val>(Val val)
            given Val of
                    Integer|Float|String|Character|LocalDate|LocalDateTime|LocalTime|Calendar|Byte|Boolean|BigInteger|BigDecimal|Date|Null
    {
        return ColumnValue(Column(""),val);
    }

    Column column;
    Value val;

    new(Column column, Value val){
        this.column = column;
        this.val = val;
    }

    shared Value getValue() => val;

    shared Column getColumn() => column;

    string => "``column.columnName`` ``if (exists val) then val else "NULL"``";
}

shared class Table {

    shared static Table table(String tableName, Column idColumn) {
        return Table(tableName, idColumn);
    }

    shared static Table as(String tableName, String tableAlias, Column idColumn) {
        return Table(tableName +" " +tableAlias, idColumn);
    }

    String tableName;
    Column idColumn;

    new(String tableName, Column idColumn) {
        this.tableName = tableName;
        this.idColumn = idColumn;
    }

    string => tableName;

    shared String getTableName() => tableName;
}

shared class Index( shared String index) {
    string => index;
}