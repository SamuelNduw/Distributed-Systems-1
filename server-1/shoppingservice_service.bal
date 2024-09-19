import ballerina/grpc;
import ballerina/io;

// Table to store products
table<Product> key(sku) productsTable = table [];
// Table to store orders
table<Order> key(user_id) ordersTable = table [];

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: ONLINESHOPPING_DESC}
service "ShoppingService" on ep {

        
    remote function AddProduct(AddProductRequest value) returns ProductCodeResponse|error {

    Product newProduct = {
        sku: value.product.sku,
        name: value.product.name,
        description: value.product.description,
        price: value.product.price,
        status: value.product.status
    };

    var existingProduct = productsTable[value.product.sku];
    if existingProduct is Product {
        return error("Product with SKU " + value.product.sku + " already exists.");
    }

    productsTable.add(newProduct);
    io:println("Product added: ", newProduct);

    ProductCodeResponse response = {
        product_code: value.product.sku
    };
    return response;
    }

    remote function UpdateProduct(UpdateProductRequest value) returns ProductCodeResponse|error {
        return error("Not implemented");
    }

    remote function RemoveProduct(RemoveProductRequest value) returns ProductListResponse|error {
        return error("Not implemented");
    }

    remote function ListAvailableProducts() returns ProductListResponse|error {
        return error("Not implemented");
    }

    remote function SearchProduct(SearchProductRequest value) returns SearchProductResponse|error {
        return error("Not implemented");
    }

    remote function AddToCart(AddToCartRequest value) returns error? {
        return error("Not implemented");
    }

    remote function PlaceOrder(PlaceOrderRequest value) returns error? {
        return error("Not implemented");
    }

    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
        return error("Not implemented");
    }
}

