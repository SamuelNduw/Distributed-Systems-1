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
        // Extract SKU from request
    string skuToRemove = value.sku;

    // Check if the product exists in the table
    Product? productToRemove = productsTable[skuToRemove];
    if (productToRemove is Product) {
        // Remove the product from the table
        Product delete = productsTable.remove(skuToRemove);
        
        // Fetch the updated list of products
        Product[] updatedProducts = from Product product in productsTable select product;

        // Create response with updated list of products
        ProductListResponse response = {
            products: updatedProducts
        };
        
        return response;
    } else {
        // If product does not exist, return an error
        return error("Product with SKU '" + skuToRemove + "' not found.");
    }
}
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

