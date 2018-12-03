import java.util{
    JList=List,
    JArrayList = ArrayList
}
import ceylonic.jdbc.dao {
    QueryService
}
import test.ceylonic.jdbc.dml.noconnection {
    Product,
    TblProduct{...},
    productRowMapper
}
import test.ceylonic.jdbc.northwind {
    CustomersTbl{
        ...
    },
    OrderTbl{
        ...
    },
    Order,
    Customer,
    customerRowMapper,
    orderRowMapper,
    customerOrdersRowMapper,
    orderWithCustomerRowMapper
}

//https://stackoverflow.com/questions/14964609/creating-a-generic-class-to-return-a-table

shared JList<Product> products(){
    QueryService qs = QueryService("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost:3306/test", "root", "root");
    value result =  qs.select().all().from(product).using(productRowMapper).execute();
    value prodList = JArrayList<Product>(result.size());
    for(o in result){
        assert (is Product o);
        prodList.add(o);
    }
    return prodList;
}

shared void listCustomersWhoPaidThruCreditCardOrCash(){
    QueryService qs = QueryService("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost:3306/northwind", "root", "root");
    value result = qs.select().columns({c_all,o_all}).from(o_orders).join().table(c_customers).using(orderWithCustomerRowMapper)
    .on().column(o_customer_id).eq(c_customerId).whereIn(o_payment_type, {"Credit Card","Cash"}).execute();

    for(o in result){
        print(o);
    }
}
