import ceylonic.jdbc {
    delete
}
import ceylonic.jdbc.meta {
    ColumnValue {
        set
    }
}
import test.ceylonic.jdbc.dml.noconnection {
    TblPerson{
        ...
    }
}
shared void deleteWhereEqTest(){
    delete.from(person).where().columnEq({set(fname, "Trisha")});
    String sql = delete.toSql();
    String expected = "DELETE FROM person  WHERE firstname=?";
    assert(sql == expected);
}

shared void deleteDuplicatesTest(){
    delete.from(p1).innerJoin().table(p2)
    .where().column(p1_id).lt().column(p2_id)
        .and(p1_email).eq(p2_email);
    String sql = delete.toSql();
    String expected = "DELETE FROM person p1  INNER JOIN person p2 WHERE p1.id<p2.id AND p1.email=p2.email";
    assert(sql == expected);
}