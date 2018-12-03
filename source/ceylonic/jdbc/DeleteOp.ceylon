import java.util {
    JList=List,
    JLinkedList = LinkedList
}
import ceylonic.jdbc.meta {
    ColumnValue,
    Table,
    Column,
    Value
}

shared object delete extends DeleteOp(){}

shared class DeleteOp extends AbstractOp<DeleteOp> {

    static JList<Value> values = JLinkedList<Value>();
    StringBuilder sb = StringBuilder();

    shared new() extends AbstractOp<DeleteOp>(){}

    shared actual DeleteOp from(Table table) {
        op().append("DELETE FROM ");
        op().append(table.getTableName());
        op().append(" ");
        return this;
    }

    shared DeleteOp column(Column column) {
        op().append(column.columnName);
        return this;
    }

    shared DeleteOp anyColumnWithValues({ColumnValue*} columnValues) {
        value len = columnValues.size;
        variable Integer cnt = 1;
        for(cv in columnValues) {
            values.add(cv);
            op().append(cv.getColumn().columnName);
            op().append("?");
            if(cnt++ < len) {
                op().append(" OR ");
            }
        }

        return this;
    }

    shared actual JList<Value> getValues() => values;

    shared actual StringBuilder op() => sb;

    shared actual String toSql() => op().string.trimmed;

}