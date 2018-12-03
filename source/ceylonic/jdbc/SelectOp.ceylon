import java.util {
    JList=List,
    JLinkedList=LinkedList
}
import ceylonic.jdbc.meta {
    ColumnValue,
    Column,
    Value
}
import java.lang {
    overloaded
}


shared object select extends SelectOp(){}

shared class SelectOp extends AbstractOp<SelectOp> {
    static value columnValues = JLinkedList<Value>();

    shared new () extends AbstractOp<SelectOp>() {}

    value sb = StringBuilder();


    shared SelectOp all() {
        op().append("*");
        return this;
    }

    shared SelectOp values({ColumnValue*} colValues) {
        value len = colValues.size;
        variable Integer cnt = 1;
        for (val in colValues) {
            columnValues.add(val);
            op().append("?");
            if (cnt++<len) {
                op().append(",");
            }
        }
        return this;
    }


    /**
     * SQL Columns to be selected or worked with
     *
     * @param columns The columns to fetch
     * @return Returns this object
     */
    shared SelectOp columns({Column*} columns) {
        value len = columns.size;
        variable Integer cnt = 1;
        for (column in columns) {
            op().append(column.columnName);
            if (cnt++<len) {
                op().append(",");
            }
        }
        return this;
    }

    /**
     * SQL Columns to be selected or worked with
     *
     * @param columns The columns to fetch
     * @return Returns this object
     */
    shared overloaded SelectOp column(Column column) {
        op().append(column.columnName);
        return this;
    }

    /**
     * SQL Columns to be selected or worked with
     *
     * @param column The columns to fetch
     * @return Returns this object
     */
    shared overloaded SelectOp column(String column) {
        op().append(column);
        return this;
    }

    shared actual JList<Value> getValues() => columnValues;

    shared actual StringBuilder op() => sb;

    shared actual String toSql() => op().string.trimmed;

    string => toSql();
}