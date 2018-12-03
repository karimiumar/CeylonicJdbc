import java.sql {
    Connection,
    DriverManager,
    PreparedStatement,
    Statement
}
import java.lang {
    Class
}
import java.util{
    JList = List,
    JArrayList = ArrayList
}
import ceylonic.jdbc {
    AbstractOp,
    InsertOp,
    DeleteOp,
    UpdateOp,
    SelectOp,
    select,
    RowMapper
}
import ceylonic.jdbc.meta {
    Column,
    Table,
    ColumnValue
}

shared object connectionFactory extends ConnectionFactory(){}

shared class ConnectionFactory(){
    shared Connection getConnection(String driver, String url, String user, String passwd){
        Class.forName(driver);
        return DriverManager.getConnection(url, user, passwd);
    }
}

shared abstract class AbstractPersistentService(String driver, String url, String user, String passwd) {

    Connection getConnection(){
        return connectionFactory.getConnection(driver, url, user, passwd);
    }

    shared Anything findById(Table table, RowMapper<Anything> rowMapper, ColumnValue idColumn) {
        JList<Anything> result = JArrayList<Anything>();
        value op = select.all().from(table).where().columnEq({idColumn});
        getMappedResult(rowMapper, result, op);
        if(result.size()>0) {
            assert (exists it = result.get(0));
            return it;
        }else{
            throw Exception("No data found in database with Id: ``idColumn.string``");
        }
    }

    shared void getMappedResult(RowMapper<Object> rowMapper, JList<in Anything> result, AbstractOp<out Object> op){
        try(value ps = prepareAndFill(op)){
            value rs = ps.executeQuery();
            while(rs.next()) {
                value mapped = rowMapper.map(rs);
                result.add(mapped);
            }
        }
    }

    PreparedStatement prepareAndFill(AbstractOp<out Object> op){
        PreparedStatement ps = getConnection().prepareStatement(op.toSql(), Statement.returnGeneratedKeys);
        op.fill(ps);
        return ps;
    }
}