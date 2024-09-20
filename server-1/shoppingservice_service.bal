import ballerina/grpc;

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
    }

    remote function RemoveProduct(RemoveProductRequest value) returns ProductListResponse|error {
    }

    remote function ListAvailableProducts() returns ProductListResponse|error {
    }

    remote function SearchProduct(SearchProductRequest value) returns SearchProductResponse|error {
         // Extract the sku from the request
    string sku = value.sku;
    
    // Check if the product exists in the productsTable
    if productsTable.hasKey(sku) {
        Product foundProduct = <Product>productsTable[sku];
        // Return the product in the response
        return {
            products: [foundProduct]
        };
    } else {
        // If no product is found, return an empty list
        return {
            products: []
        };
    }
    }

    remote function AddToCart(AddToCartRequest value) returns error? {
    }

    remote function PlaceOrder(PlaceOrderRequest value) returns error? {
    }

    remote function CreateUsers(stream<CreateUsersRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}

