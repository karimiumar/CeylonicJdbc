import ceylonic.jdbc.meta {
    Column{
        as,
        column
    },
    Table {
        table,
        as
    }
}
import ceylonic.jdbc {
    RowMapper
}
import java.sql {
    ResultSet,
    SqlDate = Date
}
import java.time {
    LocalDateTime,
    ZoneId,
    LocalDate
}
import java.lang {
    overloaded
}

shared overloaded LocalDateTime toLocalDateTime(SqlDate sqlDate) {
    return sqlDate.toLocalDate().atStartOfDay();
}

shared overloaded LocalDate toLocalDate(SqlDate sqlDate) {
    return sqlDate.toLocalDate();
}

shared class CustomersTbl {
    shared static Column customerId =  Column{ columnName = "id"; };
    shared static Column company =  Column{ columnName = "company"; };
    shared static Column last_name =  Column{ columnName = "last_name"; };
    shared static Column first_name =  Column{ columnName = "first_name"; };
    shared static Column email_address =  Column{ columnName = "email_address"; };
    shared static Column job_title =  Column{ columnName = "job_title"; };
    shared static Column business_phone =  Column{ columnName = "business_phone"; };
    shared static Column home_phone =  Column{ columnName = "home_phone"; };
    shared static Column mobile_phone =  Column{ columnName = "mobile_phone"; };
    shared static Column fax_number =  Column{ columnName = "fax_number"; };
    shared static Column address =  Column{ columnName = "address"; };
    shared static Column city =  Column{ columnName = "city"; };
    shared static Column state_province =  Column{ columnName = "state_province"; };
    shared static Column zip_postal_code =  Column{ columnName = "zip_postal_code"; };
    shared static Column country_region =  Column{ columnName = "country_region"; };
    shared static Column web_page =  Column{ columnName = "web_page"; };
    shared static Column notes =  Column{ columnName = "notes"; };
    shared static Column attachments =  Column{ columnName = "attachments"; };
    shared static Table customers = Table.table("customers", customerId);

    /**Alias*/
    shared static Column c_all =  as{ columnName = "*"; aliasName = "c"; };
    shared static Column c_customerId =  as{ columnName = "id"; aliasName = "c"; };
    shared static Column c_company =  as{ columnName = "company"; aliasName = "c"; };
    shared static Column c_last_name =  as{ columnName = "last_name"; aliasName = "c"; };
    shared static Column c_first_name =  as{ columnName = "first_name";aliasName = "c";  };
    shared static Column c_email_address =  as{ columnName = "email_address"; aliasName = "c"; };
    shared static Column c_job_title =  as{ columnName = "job_title"; aliasName = "c"; };
    shared static Column c_business_phone =  as{ columnName = "business_phone";aliasName = "c";  };
    shared static Column c_home_phone =  as{ columnName = "home_phone"; aliasName = "c"; };
    shared static Column c_mobile_phone =  as{ columnName = "mobile_phone";aliasName = "c";  };
    shared static Column c_fax_number =  as{ columnName = "fax_number"; aliasName = "c"; };
    shared static Column c_address =  as{ columnName = "address";aliasName = "c";  };
    shared static Column c_city =  as{ columnName = "city"; aliasName = "c"; };
    shared static Column c_state_province =  as{ columnName = "state_province";aliasName = "c";  };
    shared static Column c_zip_postal_code =  as{ columnName = "zip_postal_code"; aliasName = "c"; };
    shared static Column c_country_region =  as{ columnName = "country_region"; aliasName = "c"; };
    shared static Column c_web_page =  as{ columnName = "web_page"; aliasName = "c"; };
    shared static Column c_notes =  as{ columnName = "notes"; aliasName = "c"; };
    shared static Column c_attachments =  as{ columnName = "attachments"; aliasName = "c"; };
    shared static Table c_customers = Table.as("customers", "c",c_customerId);
    shared new(){}
}

shared class OrderDetailsTbl {
    shared static Column orderDetailsId = Column("id");
    shared static Column order_id = Column("order_id");
    shared static Column product_id = Column("product_id");
    shared static Column quantity = Column("quantity");
    shared static Column unit_price = Column("unit_price");
    shared static Column discount = Column("discount");
    shared static Column status_id = Column("status_id");
    shared static Column date_allocated = Column("date_allocated");
    shared static Table order_details = Table.table("order_details", orderDetailsId);
    new(){}
}

shared class OrderTbl {
    shared static Column orderId = Column("id");
    shared static Column customer_id = Column("customer_id");
    shared static Column order_date = Column("order_date");
    shared static Column shipped_date = Column("shipped_date");
    shared static Column shipping_fee = Column("shipping_fee");
    shared static Column payment_type = Column("payment_type");
    shared static Table orders = Table.table("orders", orderId);

    /**Alias*/
    shared static Column o_all = as("*", "o");
    shared static Column o_orderId = as("id", "o");
    shared static Column o_customer_id = as("customer_id", "o");
    shared static Column o_order_date = as("order_date", "o");
    shared static Column o_shipped_date = as("shipped_date", "o");
    shared static Column o_shipping_fee = as("shipping_fee", "o");
    shared static Column o_payment_type = as("payment_type", "o");
    shared static Table o_orders = Table.as("orders", "o", o_orderId);
    new(){}
}

shared class OrdersStatusTbl {
    shared static Column orderStatusId = Column("id");
    shared static Column status_name = Column("status_name");
    shared static Table orders_status = Table.table("orders_status", orderStatusId);
    new(){}
}

shared class OrderStatus(){
    shared late Integer orderStatusId;
    shared late String statusName;
}

shared object orderStatusRowMapper satisfies RowMapper<OrderStatus> {
    shared actual OrderStatus map(ResultSet rs) {
        value os = OrderStatus();
        os.orderStatusId = rs.getInt("id");
        os.statusName = rs.getString("status_name");
        return os;
    }
}

shared class ProductsTbl {
    shared static Column productId = Column("id");
    shared static Column product_code = Column("product_code");
    shared static Column product_name = Column("product_name");
    shared static Column description = Column("description");
    shared static Column list_price = Column("list_price");
    shared static Column discontinued = Column("discontinued");
    shared static Column category = Column("category");
    shared static Table products = Table.table("products", productId);
    new(){}
}

shared class Product(){
    shared late Integer productId;
    shared late String productCode;
    shared late String productName;
    shared late String description;
    shared late Float listPrice;
    shared late Boolean discontinued;
    shared late String category;
}

shared object productRowMapper satisfies RowMapper<Product> {
    shared actual Product map(ResultSet rs) {
        value product = Product();
        product.productId = rs.getInt("id");
        product.productCode = rs.getString("product_code");
        product.productName = rs.getString("product_name");
        product.description = rs.getString("description");
        product.category = rs.getString("category");
        product.discontinued = rs.getBoolean("discontinued");
        product.listPrice = rs.getFloat("list_price");
        return product;
    }
}

shared class Customer(){
    shared late Integer customerId;
    shared late String company;
    shared late String lastName;
    shared late String firstName;
    shared late String email;
    shared late String jobTitle;
    shared late String businessPhone;
    shared late String homePhone;
    shared late String mobilePhone;
    shared late String faxNumber;
    shared late String address;
    shared late String city;
    shared late String state;
    shared late String zip;
    shared late String country;
    shared late String webpage;
    shared late String notes;

    string => "Customer[Id:``customerId``,Last Name:``lastName``,First Name:``firstName``,Email:``email``,Company:``company``,Job Title:``jobTitle``,Business Phone:``businessPhone``,Mobile Phone:``mobilePhone``,Address:``address``,City:``city``,State:``state``,Country:``country``]";
}

shared class Order(){
    shared late Integer orderId;
    shared late Integer customerId;
    shared late Customer customer;
    shared late LocalDateTime orderDate;
    shared late LocalDateTime shippedDate;
    shared late Float shippingFee;
    shared late String paymentType;

    string=>"Order[Id:``orderId``,Order Date:``orderDate``,Shipped Date:``shippedDate``,Shipping Fee:``shippingFee``,Payment Type:``paymentType``, Customer:``customer``]";
}

shared object orderRowMapper satisfies RowMapper<Order> {
    shared actual Order map(ResultSet rs) {
        value order = Order();
        order.orderId = rs.getInt("id");
        order.customerId = rs.getInt("customer_id");
        order.orderDate = toLocalDateTime(rs.getDate("order_date"));
        order.shippedDate = toLocalDateTime(rs.getDate("shipped_date"));
        order.shippingFee = rs.getFloat("shipping_fee");
        order.paymentType = rs.getString("payment_type");
        return order;
    }
}

shared class OrderDetails(){
    shared late Integer orderDetailsId;
    shared late Integer orderId;
    shared late Integer productId;
    shared late Integer quantity;
    shared late Float unitPrice;
    shared late Float discount;
    shared late Integer statusId;
    shared late LocalDateTime dateAllocated;
}

shared object orderDetailsRowMapper satisfies RowMapper<OrderDetails> {
    shared actual OrderDetails map(ResultSet rs) {
        value orderDetail = OrderDetails();
        orderDetail.orderDetailsId = rs.getInt("id");
        orderDetail.orderId = rs.getInt(OrderDetailsTbl.order_id.columnName);
        orderDetail.productId = rs.getInt(OrderDetailsTbl.product_id.columnName);
        orderDetail.quantity = rs.getInt(OrderDetailsTbl.quantity.columnName);
        orderDetail.unitPrice = rs.getFloat(OrderDetailsTbl.unit_price.columnName);
        orderDetail.discount = rs.getFloat(OrderDetailsTbl.discount.columnName);
        orderDetail.statusId = rs.getInt(OrderDetailsTbl.status_id.columnName);
        orderDetail.dateAllocated = toLocalDateTime(rs.getDate(OrderDetailsTbl.date_allocated.columnName));
        return orderDetail;
    }
}

shared object customerRowMapper satisfies RowMapper<Customer> {
    shared actual Customer map(ResultSet rs) {
        value customer = Customer();
        customer.customerId = rs.getInt(CustomersTbl.customerId.columnName);
        customer.company = stringifyNull(rs.getString(CustomersTbl.company.columnName));
        customer.lastName = stringifyNull(rs.getString(CustomersTbl.last_name.columnName));
        customer.firstName = stringifyNull(rs.getString(CustomersTbl.first_name.columnName));
        customer.email = stringifyNull(rs.getString(CustomersTbl.email_address.columnName));
        customer.jobTitle = stringifyNull(rs.getString(CustomersTbl.job_title.columnName));
        customer.businessPhone = stringifyNull(rs.getString(CustomersTbl.business_phone.columnName));
        customer.homePhone = stringifyNull(rs.getString(CustomersTbl.home_phone.columnName));
        customer.mobilePhone = stringifyNull(rs.getString(CustomersTbl.mobile_phone.columnName));
        customer.faxNumber = stringifyNull(rs.getString(CustomersTbl.fax_number.columnName));
        customer.address = stringifyNull(rs.getString(CustomersTbl.address.columnName));
        customer.city = stringifyNull(rs.getString(CustomersTbl.city.columnName));
        customer.state = stringifyNull(rs.getString(CustomersTbl.state_province.columnName));
        customer.zip = stringifyNull(rs.getString(CustomersTbl.zip_postal_code.columnName));
        customer.country = stringifyNull(rs.getString(CustomersTbl.country_region.columnName));
        customer.webpage = stringifyNull(rs.getString(CustomersTbl.web_page.columnName));
        customer.notes = stringifyNull(rs.getString(CustomersTbl.notes.columnName));
        return customer;
    }
}

String stringifyNull(String? string){
    if(exists string) {
        return string;
    }else{
        return "NULL";
    }
}

shared object customerOrdersRowMapper satisfies RowMapper<{Customer|Order*}> {
    shared actual {Customer|Order*} map(ResultSet rs) {
        value customer = Customer();
        customer.customerId = rs.getInt(CustomersTbl.c_customerId.columnName);
        customer.company = stringifyNull(rs.getString(CustomersTbl.company.columnName));
        customer.lastName = stringifyNull(rs.getString(CustomersTbl.last_name.columnName));
        customer.firstName = stringifyNull(rs.getString(CustomersTbl.first_name.columnName));
        customer.email = stringifyNull(rs.getString(CustomersTbl.email_address.columnName));
        customer.jobTitle = stringifyNull(rs.getString(CustomersTbl.job_title.columnName));
        customer.businessPhone = stringifyNull(rs.getString(CustomersTbl.business_phone.columnName));
        customer.homePhone = stringifyNull(rs.getString(CustomersTbl.home_phone.columnName));
        customer.mobilePhone = stringifyNull(rs.getString(CustomersTbl.mobile_phone.columnName));
        customer.faxNumber = stringifyNull(rs.getString(CustomersTbl.fax_number.columnName));
        customer.address = stringifyNull(rs.getString(CustomersTbl.address.columnName));
        customer.city = stringifyNull(rs.getString(CustomersTbl.city.columnName));
        customer.state = stringifyNull(rs.getString(CustomersTbl.state_province.columnName));
        customer.zip = stringifyNull(rs.getString(CustomersTbl.zip_postal_code.columnName));
        customer.country = stringifyNull(rs.getString(CustomersTbl.country_region.columnName));
        customer.webpage = stringifyNull(rs.getString(CustomersTbl.web_page.columnName));
        customer.notes = stringifyNull(rs.getString(CustomersTbl.notes.columnName));
        value order = Order();
        order.orderId = rs.getInt("o.id");
        order.customerId = rs.getInt("o.customer_id");
        order.orderDate = toLocalDateTime(rs.getDate("order_date"));
        order.paymentType = stringifyNull(rs.getString("payment_type"));
        order.shippedDate = toLocalDateTime(rs.getDate("shipped_date"));
        order.shippingFee = rs.getFloat("shipping_fee");
        order.customer = customer;
        value elements = {customer, order};
        return elements;
    }
}

shared object orderWithCustomerRowMapper satisfies RowMapper<Order> {
    shared actual Order map(ResultSet rs) {
        value customer = Customer();
        customer.customerId = rs.getInt(CustomersTbl.c_customerId.columnName);
        customer.company = stringifyNull(rs.getString(CustomersTbl.company.columnName));
        customer.lastName = stringifyNull(rs.getString(CustomersTbl.last_name.columnName));
        customer.firstName = stringifyNull(rs.getString(CustomersTbl.first_name.columnName));
        customer.email = stringifyNull(rs.getString(CustomersTbl.email_address.columnName));
        customer.jobTitle = stringifyNull(rs.getString(CustomersTbl.job_title.columnName));
        customer.businessPhone = stringifyNull(rs.getString(CustomersTbl.business_phone.columnName));
        customer.homePhone = stringifyNull(rs.getString(CustomersTbl.home_phone.columnName));
        customer.mobilePhone = stringifyNull(rs.getString(CustomersTbl.mobile_phone.columnName));
        customer.faxNumber = stringifyNull(rs.getString(CustomersTbl.fax_number.columnName));
        customer.address = stringifyNull(rs.getString(CustomersTbl.address.columnName));
        customer.city = stringifyNull(rs.getString(CustomersTbl.city.columnName));
        customer.state = stringifyNull(rs.getString(CustomersTbl.state_province.columnName));
        customer.zip = stringifyNull(rs.getString(CustomersTbl.zip_postal_code.columnName));
        customer.country = stringifyNull(rs.getString(CustomersTbl.country_region.columnName));
        customer.webpage = stringifyNull(rs.getString(CustomersTbl.web_page.columnName));
        customer.notes = stringifyNull(rs.getString(CustomersTbl.notes.columnName));
        value order = Order();
        order.orderId = rs.getInt("o.id");
        order.customerId = rs.getInt("o.customer_id");
        order.orderDate = toLocalDateTime(rs.getDate("order_date"));
        order.paymentType = stringifyNull(rs.getString("payment_type"));
        order.shippedDate = toLocalDateTime(rs.getDate("shipped_date"));
        order.shippingFee = rs.getFloat("shipping_fee");
        order.customer = customer;
        value elements = order;
        return elements;
    }
}