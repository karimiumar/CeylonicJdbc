import ceylonic.jdbc.meta {
    Column{
        column,
        as
    },
    Table{
        table,
        tableAlias = as
    }
}
import ceylonic.jdbc {
    RowMapper
}
import java.sql {
    ResultSet
}

shared class TblSupplier {
    shared static Column supplierId = column("id");
    shared static Column supplierName = column("supplier_name");
    shared static Column contactName = column("contact_name");
    shared static Column suppplierAddr = column("supplier_address");
    shared static Column city = column("city");
    shared static Column country = column("country");
    shared static Table supplier = Table.table("supplier", supplierId);

    shared static Column s1_Id = as("id", "s1");
    shared static Column s1_supplierName = as("supplier_name", "s1");
    shared static Column s1_contactName = as("contact_name", "s1");
    shared static Column s1_suppplierAddr = as("supplier_address", "s1");
    shared static Table s1_supplier = Table.as("supplier", "s1", supplierId);

    new(){}
}

shared class TblPerson {

    shared static Column personId = column("id");
    shared static Column fname = column("firstname");
    shared static Column lname = column("lastname");
    shared static Column email = column("email");
    shared static Column adult = column("adult");
    shared static Column created = column("created");
    shared static Column city = column("city");
    shared static Column country = column("country");
    shared static Column age = column("age");
    shared static Table person = table("person", personId);

    shared static Column p1_id = as("id", "p1");
    shared static Column p1_fname = as("firstname", "p1");
    shared static Column p1_lname = as("lastname", "p1");
    shared static Column p1_email = as("email", "p1");
    shared static Column p1_adult = as("adult", "p1");
    shared static Column p1_created = as("created", "p1");
    shared static Column p1_city = as("city", "p1");
    shared static Column p1_country = as("country", "p1");
    shared static Column p1_age = as("age", "p1");
    shared static Table p1 = tableAlias("person","p1", personId);

    shared static Column p2_id = as("id", "p2");
    shared static Column p2_fname = as("firstname", "p2");
    shared static Column p2_lname = as("lastname", "p2");
    shared static Column p2_email = as("email", "p2");
    shared static Column p2_adult = as("adult", "p2");
    shared static Column p2_created = as("created", "p2");
    shared static Column p2_city = as("city", "p2");
    shared static Column p2_country = as("country", "p2");
    shared static Column p2_age = as("age", "p2");
    shared static Table p2 = tableAlias("person","p2", personId);

    new(){}
}

shared class TblProduct {
    shared static Column productId = column("id");
    shared static Column prd_name = column("product_name");
    shared static Column suppid = column("supplier_id");
    shared static Column unitprice = column("unit_price");
    shared static Column discontinued = column("is_discontinued");
    shared static Column cat_id = column("category_id");
    shared static Table product = Table.table("product", productId);

    shared static Column prd1_id = as("id", "prd1");
    shared static Column prd1_productname = as("product_name", "prd1");
    shared static Column prd1_suppid = as("supplier_id", "prd1");
    shared static Column prd1_unitprice = as("unit_price", "prd1");
    shared static Column prd1_discontinued = as("is_discontinued", "prd1");
    shared static Column prd1_cat_id = as("category_id", "prd1");
    shared static Table prd1 = Table.as("product", "prd1", productId);

    shared static Column prd2_id = as("id", "prd2");
    shared static Column prd2_productname = as("product_name", "prd2");
    shared static Column prd2_suppid = as("supplier_id", "prd2");
    shared static Column prd2_unitprice = as("unit_price", "prd2");
    shared static Column prd2_discontinued = as("is_discontinued", "prd2");
    shared static Column prd2_cat_id = as("category_id", "prd2");
    shared static Table prd2 = Table.as("product", "prd2", productId);
    new(){}
}

shared object productSupplierRowMapper satisfies RowMapper<Set<Product&Supplier>>{
    shared actual Set<Product&Supplier> map(ResultSet rs) {
        value product = Product();
        product.id = rs.getInt("p.id");
        product.discontinued = rs.getBoolean("p.discontinued");
        product.productName = rs.getString("p.product_name");
        product.supplierId = rs.getInt("p.supplier_id");
        product.categotyId = rs.getInt("p.category_id");
        product.unitPrice = rs.getDouble("p.unit_price");
        value supplier = Supplier();
        supplier.id = rs.getInt("s.id");
        supplier.supplierName = rs.getString("s.supplier_name");
        supplier.contactName = rs.getString("s.contact_name");
        supplier.supplierAddress = rs.getString("s.supplier_addr");
        supplier.city = rs.getString("s.city");
        supplier.country = rs.getString("s.country");
        return set{product} & set{supplier};
    }
}

shared class Supplier() {
    shared late Integer id;
    shared late String contactName;
    shared late String supplierName;
    shared late String supplierAddress;
    shared late String city;
    shared late String country;
}

shared object productRowMapper satisfies RowMapper<Product> {
    shared actual Product map(ResultSet rs) {
        value product = Product();
        product.id = rs.getInt("id");
        product.discontinued = rs.getBoolean("discontinued");
        product.productName = rs.getString("product_name");
        product.supplierId = rs.getInt("supplier_id");
        product.categotyId = rs.getInt("category_id");
        product.unitPrice = rs.getDouble("unit_price");
        return product;
    }
}

shared class Product() {
    shared late Integer id;
    shared late Boolean discontinued;
    shared late String productName;
    shared late Integer supplierId;
    shared late Float unitPrice;
    shared late Integer categotyId;

}

shared class TblOrder {
    shared static Column orderId = column("id");
    shared static Column orderDate = column("order_date");
    shared static Column orderNo = column("order_number");
    shared static Column customerId = column("customer_id");
    shared static Column totalAmount = column("total_amount");
    shared static Table order = Table.table("order", orderId);

    shared static Column o1_id = as("id", "o1");
    shared static Column o1_orderDate = as("order_date", "o1");
    shared static Column o1_orderNo = as("order_number", "o1");
    shared static Column o1_customerId = as("customer_id", "o1");
    shared static Column o1_totalAmount = as("total_amount", "o1");
    shared static Table o1 = Table.as("order", "o1", orderId);

    shared static Column o2_id = as("id", "o2");
    shared static Column o2_orderDate = as("order_date", "o2");
    shared static Column o2_orderNo = as("order_number", "o2");
    shared static Column o2_customerId = as("customer_id", "o2");
    shared static Column o2_totalAmount = as("total_amount", "o2");
    shared static Table o2 = Table.as("order", "o2", orderId);
    new(){}
}