import ceylonic.jdbc.dao {
    QueryService
}
import ceylonic.jdbc.meta {
    Table,
    Column,
    ColumnValue,
    Value,
    Index
}
import ceylonic.jdbc {
    SelectOp,
    RowMapper
}
import java.util { JList=List }
import java.lang {
    overloaded
}

shared interface FluentQueryService {
    shared formal overloaded QueryService select();
    shared formal QueryService all();
    shared formal QueryService table(Table table);
    shared formal overloaded QueryService from(Table table);
    shared formal overloaded QueryService from({Table*} tables);
    shared formal QueryService columns({Column*} columns);
    shared formal QueryService column(Column column);
    shared formal QueryService where(Column column);
    shared formal QueryService whereIn(Column column, {Value*} values);
    shared formal QueryService columnValueEq({ColumnValue*} columnValues);
    shared formal QueryService ne(Column condition);
    shared formal QueryService not();
    shared formal QueryService is_();
    shared formal QueryService null();
    shared formal overloaded QueryService and();
    shared formal overloaded QueryService and(Column column);
    shared formal QueryService beginComplex();
    shared formal QueryService endComplex();
    shared formal QueryService or();
    shared formal overloaded QueryService lt(Column column);
    shared formal overloaded QueryService gt(Column column);
    shared formal overloaded QueryService ge(Column column);
    shared formal overloaded QueryService le(Column column);
    shared formal overloaded QueryService gt();
    shared formal overloaded QueryService lt();
    shared formal overloaded QueryService ge();
    shared formal overloaded QueryService eq(Column condition);
    shared formal overloaded QueryService eq();
    shared formal overloaded QueryService gt(Value val);
    shared formal overloaded QueryService lt(Value val);
    shared formal overloaded QueryService ge(ColumnValue val);
    shared formal overloaded QueryService le(ColumnValue columnValue);
    shared formal QueryService upper();
    shared formal QueryService having();
    shared formal QueryService year(Column column);
    shared formal overloaded QueryService distinct();
    shared formal overloaded QueryService distinct(Column column);
    shared formal overloaded QueryService count(Column column);
    shared formal overloaded QueryService count(SelectOp op);
    shared formal QueryService max(Column column);
    shared formal QueryService min(Column column);
    shared formal QueryService avg(Column column);
    shared formal QueryService sum(Column column);
    shared formal QueryService exists_(SelectOp op);
    shared formal overloaded QueryService between({ColumnValue*} columnValues);
    shared formal overloaded QueryService between(SelectOp op);
    shared formal QueryService like(String pattern);
    shared formal QueryService in_(SelectOp op);
    shared formal QueryService limit(Integer n);
    shared formal QueryService offset(Integer n);
    shared formal QueryService as(String aliasName);
    shared formal QueryService orderBy(Column column);
    shared formal QueryService asc();
    shared formal QueryService desc();
    shared formal QueryService groupBy({Column*} columns);
    shared formal QueryService with({Column*} columns);
    shared formal overloaded QueryService using(Column column);
    shared formal QueryService minus();
    shared formal QueryService innerJoin();
    shared formal QueryService outerJoin();
    shared formal QueryService join();
    shared formal QueryService leftJoin();
    shared formal QueryService rightJoin();
    shared formal QueryService union();
    shared formal QueryService on();
    shared formal QueryService any();
    shared formal QueryService some();
    shared formal overloaded QueryService select({Column*} columns);
    shared formal QueryService withIndex(Index index);

    shared formal SelectOp getSQL();
    shared formal overloaded QueryService using(RowMapper<Anything> rowMapper);
    shared formal JList<out Anything> execute();
}
