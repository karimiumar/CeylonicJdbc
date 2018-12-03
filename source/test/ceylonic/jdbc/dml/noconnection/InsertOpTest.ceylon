import ceylonic.jdbc {
    insert
}
import ceylonic.jdbc.meta {
    ColumnValue{
        set
    }
}

import test.ceylonic.jdbc.dml.noconnection {
    TblProduct{...}
}

shared void insertProductTest(){
     insert.intoTable(product).columns({
        set(prd_name, "Sata SSD"),
        set(suppid, 23454),
        set(unitprice, 4563.78),
        set(discontinued, false),
        set(cat_id, 45)
     });

    String sql = insert.toSql();
    String expected = "INSERT INTO product(product_name,supplier_id,unit_price,is_discontinued,category_id)VALUES(?,?,?,?,?)";
    assert(sql == expected);
    for(v in insert.getValues()){
        print(v);
    }
}