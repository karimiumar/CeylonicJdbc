import java.util {
    JList=List,
    JLinkedList=LinkedList
}
import ceylonic.jdbc.meta {
    ColumnValue,
    Table,
    Value
}

shared object insert extends InsertOp(){}

shared class InsertOp extends AbstractOp<InsertOp> {

    static JList<Value> values = JLinkedList<Value>();
    StringBuilder sb = StringBuilder();

    shared new() extends AbstractOp<InsertOp>(){

    }

    shared InsertOp intoTable(Table table) {
        op().append("INSERT INTO ");
        op().append(table.getTableName());
        return this;
    }

    shared InsertOp columns({ColumnValue*} columnValues) {
        value len = columnValues.size;
        variable Integer cnt = 1;
        openBraces();
        for(colVal in columnValues) {
            op().append(colVal.getColumn().columnName);
            if(cnt++ < len) {
                op().append(",");
            }
        }
        closeBraces();
        //Now append the values
        cnt = 1; // reset count
        op().append("VALUES");
        openBraces();
        for(colVal in columnValues) {
            op().append("?");
            if(cnt++ < len) {
                op().append(",");
            }
            values.add(colVal);
        }
        closeBraces();
        return this;
    }

    shared actual JList<Value> getValues() => values;

    shared actual StringBuilder op() => sb;

    shared actual String toSql() => op().string.trimmed;

}