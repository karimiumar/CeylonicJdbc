import java.util {
    JList = List,
    JLinkedList = LinkedList
}
import ceylonic.jdbc.meta {
    ColumnValue,
    Table,
    Value
}

shared object update extends UpdateOp() {}

shared class UpdateOp extends AbstractOp<UpdateOp> {

    static JList<Value> values = JLinkedList<Value>();

    shared new() extends AbstractOp<UpdateOp>(){}

    StringBuilder sb = StringBuilder();

    shared actual UpdateOp table(Table _table) {
        op().append("UPDATE ");
        op().append(_table.getTableName());
        return this;
    }

    shared UpdateOp setColumnValues({ColumnValue*} columnValues){
        value len = columnValues.size;
        variable Integer cnt = 1;
        op().append(" SET ");
        for(cv in columnValues) {
            op().append(cv.getColumn().columnName);
            op().append("=?");
            if(cnt < len) {
                op().append(",");
            }
            values.add(cv.getValue());
        }
        return this;
    }

    shared actual JList<Value> getValues() => values;

    shared actual StringBuilder op() => sb;

    shared actual String toSql() => op().string.trimmed;


}