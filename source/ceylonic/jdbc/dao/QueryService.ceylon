import ceylonic.jdbc.fluent.contract {
    FluentQueryService
}
import ceylonic.jdbc {
    SelectOp,
    op = select,
    RowMapper
}
import ceylonic.jdbc.meta {
    Table,
    Column,
    Value,
    ColumnValue,
    Index
}
import java.util {
    JList = List,
    JArrayList = ArrayList
}
import java.lang {
    overloaded
}

shared class QueryService(String driverClass, String url, String user, String passwd)
        extends AbstractPersistentService(driverClass, url, user, passwd)
        satisfies FluentQueryService{

    late RowMapper<Object> rowMapper;

    shared actual overloaded QueryService select(){
        op.select();
        return this;
    }

    shared actual QueryService all() {
        op.all();
        return this;
    }

    shared actual QueryService table(Table table) {
        op.table(table);
        return this;
    }

    shared actual QueryService column(Column column){
        op.column(column);
        return this;
    }

    shared actual QueryService columns({Column*} columns){
        op.columns(columns);
        return this;
    }

    shared actual JList<out Anything> execute() {
        JList<Anything> result = JArrayList<Anything>();
        getMappedResult(rowMapper, result, op);
        op.clear();
        return result;
    }

    shared actual overloaded QueryService from(Table table) {
        op.from(table);
        return this;
    }

    shared actual overloaded QueryService from({Table*} tables) {
        op.from(tables);
        return this;
    }

    shared actual SelectOp getSQL() => op;

    shared actual overloaded QueryService using(RowMapper<Object> rowMapper) {
        this.rowMapper = rowMapper;
        return this;
    }

    shared actual QueryService where(Column column) {
        op.where(column);
        return this;
    }

    shared actual QueryService whereIn(Column column, {Value*} values) {
        op.where(column, values);
        return this;
    }
    shared actual overloaded QueryService and() {
        op.and();
        return this;
    }

    shared actual overloaded QueryService and(Column column) {
        op.and(column);
        return this;
    }

    shared actual QueryService any() {
        op.any();
        return this;
    }

    shared actual QueryService as(String aliasName) {
        op.as(aliasName);
        return this;
    }

    shared actual QueryService asc() {
        op.asc();
        return this;
    }

    shared actual QueryService avg(Column column) {
        op.avg(column);
        return this;
    }

    shared actual QueryService beginComplex() {
        op.beginComplex();
        return this;
    }

    shared actual overloaded QueryService between({ColumnValue*} columnValues) {
        op.between(columnValues);
        return this;
    }

    shared actual overloaded QueryService between(SelectOp operation) {
        op.between(operation);
        return this;
    }

    shared actual QueryService columnValueEq({ColumnValue*} columnValues) {
        op.columnEq(columnValues);
        return this;
    }

    shared actual overloaded QueryService count(Column column) {
        op.count(column);
        return this;
    }

    shared actual overloaded QueryService count(SelectOp operation) {
        op.count(operation);
        return this;
    }

    shared actual QueryService desc() {
        op.desc();
        return this;
    }

    shared actual overloaded QueryService distinct() {
        op.distinct();
        return this;
    }

    shared actual overloaded QueryService distinct(Column column) {
        op.distinct(column);
        return this;
    }

    shared actual QueryService endComplex() {
        op.endComplex();
        return this;
    }

    shared actual overloaded QueryService eq(Column condition) {
        op.eq(condition);
        return this;
    }

    shared actual overloaded QueryService eq() {
        op.eq();
        return this;
    }

    shared actual QueryService exists_(SelectOp operation) {
        op.exists_(operation);
        return this;
    }

    shared actual overloaded QueryService ge() {
        op.ge();
        return this;
    }

    shared actual overloaded QueryService ge(ColumnValue val) {
        op.ge(val);
        return this;
    }

    shared actual overloaded QueryService ge(Column column) {
        op.ge(column);
        return this;
    }

    shared actual QueryService groupBy({Column*} columns) {
        op.groupBy(columns);
        return this;
    }

    shared actual overloaded QueryService gt() {
        op.gt();
        return this;
    }

    shared actual overloaded QueryService gt(Value val) {
        op.gt(val);
        return this;
    }

    shared actual overloaded QueryService gt(Column column) {
        op.gt(column);
        return this;
    }

    shared actual QueryService having() {
        op.having();
        return this;
    }

    shared actual QueryService in_(SelectOp operation) {
        op.in_(operation);
        return this;
    }

    shared actual QueryService innerJoin() {
        op.innerJoin();
        return this;
    }

    shared actual QueryService outerJoin() {
        op.outerJoin();
        return this;
    }

    shared actual QueryService is_() {
        op.is_();
        return this;
    }

    shared actual QueryService join() {
        op.join();
        return this;
    }

    shared actual overloaded QueryService le(ColumnValue columnValue) {
        op.le(columnValue);
        return this;
    }

    shared actual overloaded QueryService le(Column column) {
        op.le(column);
        return this;
    }

    shared actual QueryService leftJoin() {
        op.leftJoin();
        return this;
    }

    shared actual QueryService like(String pattern) {
        op.like(pattern);
        return this;
    }

    shared actual QueryService limit(Integer n) {
        op.limit(n);
        return this;
    }

    shared actual overloaded QueryService lt() {
        op.lt();
        return this;
    }

    shared actual overloaded QueryService lt(Value val) {
        op.lt(val);
        return this;
    }

    shared actual overloaded QueryService lt(Column column) {
        op.lt(column);
        return this;
    }

    shared actual QueryService max(Column column) {
        op.max(column);
        return this;
    }

    shared actual QueryService min(Column column) {
        op.min(column);
        return this;
    }

    shared actual QueryService minus() {
        op.minus();
        return this;
    }

    shared actual QueryService ne(Column condition) {
        op.ne(condition);
        return this;
    }

    shared actual QueryService not() {
        op.not();
        return this;
    }

    shared actual QueryService null() {
        op.null();
        return this;
    }

    shared actual QueryService offset(Integer n) {
        op.offset(n);
        return this;
    }

    shared actual QueryService on() {
        op.on();
        return this;
    }

    shared actual QueryService or() {
        op.or();
        return this;
    }

    shared actual QueryService orderBy(Column column) {
        op.orderBy(column);
        return this;
    }

    shared actual QueryService rightJoin() {
        op.rightJoin();
        return this;
    }

    shared actual overloaded QueryService select({Column*} columns) {
        op.select(columns);
        return this;
    }

    shared actual QueryService some() {
        op.some();
        return this;
    }

    shared actual QueryService sum(Column column) {
        op.sum(column);
        return this;
    }

    shared actual QueryService union() {
        op.union();
        return this;
    }

    shared actual QueryService upper() {
        op.upper();
        return this;
    }

    shared actual overloaded QueryService using(Column column) {
        op.using(column);
        return this;
    }

    shared actual QueryService with({Column*} columns) {
        op.with(columns);
        return this;
    }

    shared actual QueryService withIndex(Index index) {
        op.withIndex(index);
        return this;
    }

    shared actual QueryService year(Column column) {
        op.year(column);
        return this;
    }

}