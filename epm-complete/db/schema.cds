namespace com.epm;

using {
    cuid,
    managed,
    Currency,
    Country
} from '@sap/cds/common';

entity Suppliers : cuid {
    name       : String(100);
    contact    : String(100);
    email      : String(100);
    phone      : String(20);
    city       : String(50);
    country    : Country;
    isActive   : Boolean default true; 
}

entity Categories : cuid {
    name            : String(100);
    description     : String(255);

    parentCategory  : Association to Categories;
}

entity Products : cuid, managed {
    name        : String(100);
    description : String(255);
    price       : Decimal(10,2);
    currency    : Currency;
    stock       : Integer;
    minStock    : Integer;
    rating      : Decimal(3,2);

    supplier    : Association to Suppliers;
    category    : Association to Categories;
}

entity Customers : cuid, managed {
    name         : String(100);
    email        : String(100);
    phone        : String(20);
    city         : String(50);
    country      : Country;
    creditLimit  : Decimal(12,2);
}

entity SalesOrders : cuid, managed {
    orderNumber : String(30);

    customer    : Association to Customers;

    orderDate   : Date;
    totalAmount : Decimal(12,2);
    currency    : Currency;
    status      : String(20);

    items       : Composition of many SalesOrderItems
                  on items.order = $self;
}

entity SalesOrderItems : cuid {
    order      : Association to SalesOrders;
    product    : Association to Products;

    quantity   : Integer;
    unitPrice  : Decimal(10,2);
    netAmount  : Decimal(12,2);
}

entity PurchaseOrders : cuid, managed {
    poNumber    : String(30);

    supplier    : Association to Suppliers;

    orderDate   : Date;
    totalAmount : Decimal(12,2);
    currency    : Currency;
    status      : String(20);

    items       : Composition of many PurchaseOrderItems
                  on items.order = $self;
}

entity PurchaseOrderItems : cuid {
    order      : Association to PurchaseOrders;
    product    : Association to Products;

    quantity   : Integer;
    unitPrice  : Decimal(10,2);
}  

view ProductCatalog as select from Products {
    name,
    price,
    supplier.name as supplierName,
    category.name as categoryName,

    case
        when stock <= minStock
        then 'LOW'
        else 'OK'
    end as stockStatus
};

view OrderReport as select from SalesOrders {
    orderNumber,
    customer.name as customerName,
    totalAmount,
    orderDate,
    status
};

view LowStockAlert as select from Products {
    name,
    stock,
    minStock,

    supplier.name    as supplierName,
    supplier.contact as supplierContact,
    supplier.phone   as supplierPhone
}
where stock <= minStock;