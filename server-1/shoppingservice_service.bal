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
        
    }
    remote function UpdateProduct(UpdateProductRequest value) returns ProductCodeResponse|error {
        string sku = value.sku;
        Product updatedProduct = value.product;

        foreach var product in productsTable {
            if product.sku == sku {
                Product temp = productsTable.remove(product.sku);
                productsTable.add(updatedProduct);
                io:println("Updated product: ", updatedProduct.name);
                return {product_code: updatedProduct.sku};
            }
        }
        return error("Product not found for SKU: " + sku);
    }

    remote function RemoveProduct(RemoveProductRequest value) returns ProductListResponse|error {
    }

    remote function ListAvailableProducts() returns ProductListResponse|error {
    }

    remote function SearchProduct(SearchProductRequest value) returns SearchProductResponse|error {
    }

    remote function AddToCart(AddToCartRequest value) returns error? {
    }

    remote function PlaceOrder(PlaceOrderRequest value) returns error? {
    }

    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}